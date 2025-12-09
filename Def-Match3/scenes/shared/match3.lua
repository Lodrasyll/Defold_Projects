local M = {}

-- === 1. 模块核心数据 ===
M.board = {}
M.board_width = 6
M.board_height = 6
M.block_size = 80
M.callback = {}

M.colors_list = { "black", "yellow", "blue", "purple", "green", "red" }
M.colors_map = {
    [hash("black")] = "black",
    [hash("yellow")] = "yellow",
    [hash("blue")] = "blue",
    [hash("purple")] = "purple",
    [hash("green")] = "green",
    [hash("red")] = "red"
}

-- === 2. 初始化：握手 ===
-- board.script 会调用这个，把“怎么造方块”的方法传进来
function M.init(callbacks)
    M.callback = callbacks
end

-- === 3. 创建数据棋盘 ===
function M.create_board(width, height, block_size)
    M.board_width = width
    M.board_height = height
    M.block_size = block_size

    local board = {
        width = M.board_width,
        height = M.board_height,
        block_size = M.block_size,
        slot = {}
    }
    for x = 0, M.board_width - 1 do
        board.slot[x] = {}
        for y = 0, M.board_height - 1 do
            M.create_block(board, x, y)
        end
    end

    
    M.board = board
    print('棋盘创建完毕！')
    return board
end

-- === 4. 创建单个方块 (逻辑核心) ===
function M.create_block(board, x, y, color)
    -- 如果没有特殊指定，则随机颜色
    if not color then
        color = M.colors_list[math.random(#M.colors_list)]
    end

    -- 计算【相对坐标】
    -- 这样方块永远相对与棋盘原点，不用管棋盘在世界的哪里
    local local_pos = M.slot_to_screen(x, y)

    -- 【关键】呼叫回调函数
    local id = nil
    if M.callback.on_create_block then
        -- 传递相对坐标
        id = M.callback.on_create_block(x, y, color, local_pos)
    end

    -- 存入数据
    board.slot[x][y] = {
        id = id,
        x = x,
        y = y,
        color = hash(color)
    }
end

function M.swap_block(x1, y1, x2, y2, on_complete)
    local board = M.board

    local block_1 = board.slot[x1][y1]
    local block_2 = board.slot[x2][y2]

    board.slot[x1][y1] = block_2
    board.slot[x2][y2] = block_1

    if block_1 then
        block_1.x = x2
        block_1.y = y2
    end

    if block_2 then
        block_2.x = x1
        block_2.y = y1
    end

    if M.callback.on_swap_block then
        M.callback.on_swap_block(block_1, block_2, on_complete)
    end
end

local function get_horizontal_neighbors(board, x, y)
    local center_block = board.slot[x][y]

    if not center_block then
        return {}
    end

    local neighbors = {}

    -- 向左搜索
    for i = x - 1, 0, -1 do
        local neighbor = board.slot[i][y]
        if neighbor and neighbor.color == center_block.color then
            table.insert(neighbors, neighbor)
        else
            break
        end
    end

    -- 向右搜索
    for i = x + 1, M.board_width - 1 do
        local neighbor = board.slot[i][y]
        if neighbor and neighbor.color == center_block.color then
            table.insert(neighbors, neighbor)
        else
            break
        end
    end

    return neighbors
end

local function get_vertical_neighbors(board, x, y)
    local center_block = board.slot[x][y]

    local neighbors = {}

    -- 向上搜索
    for j = y + 1, M.board_height - 1 do
        local neighbor = board.slot[x][j]
        if neighbor and neighbor.color == center_block.color then
            table.insert(neighbors, neighbor)
        else
            break
        end
    end

    -- 向下搜索
    for j = y - 1, 0, -1 do
        local neighbor = board.slot[x][j]
        if neighbor and neighbor.color == center_block.color then
            table.insert(neighbors, neighbor)
        else
            break
        end
    end

    return neighbors
end

function M.find_match_block()
    local board = M.board
    local matches_set = {}
    local has_match = false

    -- 遍历棋盘上每一个方块
    for x = 0, M.board_width - 1 do
        for y = 0, M.board_height - 1 do
            local center_block = board.slot[x][y]

            if center_block then
                -- 分别获取横竖邻居
                local h_neighbors = get_horizontal_neighbors(board, x, y)
                local v_neighbors = get_vertical_neighbors(board, x, y)

                -- 如果邻居数量 >= 2，说明加上自己至少有 3 个，构成消除
                -- A. 检查水平匹配
                if #h_neighbors >= 2 then
                    matches_set[center_block] = true
                    for _, match_block in ipairs(h_neighbors) do
                        matches_set[match_block] = true
                    end
                    has_match = true
                end

                -- B. 检查垂直匹配
                if #v_neighbors >= 2 then
                    matches_set[center_block] = true
                    for _, match_block in ipairs(h_neighbors) do
                        matches_set[match_block] = true
                    end
                    has_match = true
                end

                -- C. 进阶预留：你可以在这里判断 T型/L型
                if #h_neighbors >= 2 and #v_neighbors >= 2 then
                   print("发现炸弹生成机会！")
                end
            end
        end
    end

    return matches_set, has_match
end

function M.remove_match_block(matches_set)
    for block, _ in pairs(matches_set) do
        -- 数据层置空
        M.board.slot[block.x][block.y] = nil
        -- 表现层回调
        if M.callback.on_remove_block then
            M.callback.on_remove_block(block)
        end
    end
end

function M.collapse()
    local board = M.board
    local tween = {}        -- 记录谁移动方便做动画

    -- 双指针法
    for x = 0, M.board_width - 1 do
        local write_y = 0
        for read_y = 0, M.board_height - 1 do
            local block = board.slot[x][read_y]

            if block then
                -- 如果读取位置 不等于= 写入位置，说明方块下面有空洞，需要下落
                if read_y ~= write_y then
                    -- 数据层置换，然后置空
                    board.slot[x][write_y] = block
                    board.slot[x][read_y] = nil
                    -- 记录动画需求
                    tween[block] = { from_y = read_y, to_y = write_y }
                    -- 更新方块y轴方向的索引
                    block.y = write_y
                end
                write_y = write_y + 1
            end   
        end

        -- 清理残余
        for y = write_y, M.board_height - 1 do
            board.slot[x][y] = nil
        end
    end

    return tween
end

function M.fill_board()
    local board = M.board
    local spawn_list = {}

    for x = 0, M.board_width - 1 do
        for y = 0, M.board_height - 1 do
            if board.slot[x][y] == nil then
                -- 填充
                -- 创建方块数据
                local color = M.colors_list[math.random(#M.colors_list)]
                M.create_block(board, x, y, color)
                local new_block = board.slot[x][y]
                -- 计算动画轨迹 start_y: 为了视觉效果，我们让它从棋盘顶部再往上几格的地方出现
                local visual_start_y = M.board_height + (y - 0)
                table.insert(spawn_list, {
                    block = new_block,
                    from_y = visual_start_y,
                    to_y = y
                })
            end
        end
    end

    return spawn_list
end

function M.screen_to_slot(board_origin, screen_x, screen_y)
    local x = math.floor((screen_x - board_origin.x) / M.block_size)
    local y = math.floor((screen_y - board_origin.y) / M.block_size)
    return x, y
end

function M.slot_to_screen(slot_x, slot_y)
    local x = (M.block_size / 2) + M.block_size * slot_x
    local y = (M.block_size / 2) + M.block_size * slot_y
    return vmath.vector3(x, y, 0.5)
end

function M.on_board(x, y)
    return x >= 0 and x < M.board_width and
        y >= 0 and y < M.board_height
end

function M.is_neighbor(x1, y1, x2, y2)
    local diff_x = math.abs(x1 - x2)
    local diff_y = math.abs(y1 - y2)
    return (diff_x + diff_y) == 1
end

function M.is_empty(x, y)
    if M.on_board(x, y) then
        return M.board.slot[x][y] == nil
    end
    return false
end

-- function M.calculated_match()
--     local board = game_data.board
--     M.matches = {}
--     local match_num = 1

--     -- 水平方向检测匹配
--     for y = 0, board_height - 1 do
--         local color_match = nil
--         if board[0][y] then
--             color_match = board[0][y].color
--         end
--         match_num = 1

--         for x = 1, board_width - 1 do
--             local current_brick = board[x][y]
--             local current_color = nil
--             if current_brick ~= nil then
--                 current_color = current_brick.color
--             end

--             if color_match ~= nil and current_color ~= nil and
--             current_color == color_match then
--                 match_num = match_num + 1
--             else
--                 color_match = board[x][y].color

--                 if match_num >= 3 then
--                     local match = {}
--                     for x2 = x - 1, x - match_num, -1 do
--                         table.insert(match, board[x2][y])
--                     end

--                     table.insert(M.matches, match)
--                 end

--                 color_match = current_color
--                 match_num = 1
--             end
--         end
--         -- 边界问题，当最后一个依然为匹配项的时候
--         if match_num >= 3 then
--             local match = {}
--             for x = board_width - 1, board_width - match_num, -1 do
--                 table.insert(match, board[x][y])
--             end
--             table.insert(M.matches, match)
--         end
--     end

--     -- 垂直方向检测匹配
--     for x = 0, board_width - 1 do
--         local color_match = nil
--         if board[x][0] then
--             color_match = board[x][0].color
--         end

--         match_num = 1

--         for y = 1, board_height - 1 do
--             local current_brick = board[x][y]
--             local current_color = nil
--             if current_brick ~= nil then
--                 current_color = current_brick.color
--             end
--             if color_match ~= nil and current_color ~= nil and
--             current_color == color_match then
--                 match_num = match_num + 1
--             else
--                 color_match = board[x][y].color

--                 if match_num >= 3 then
--                     local match = {}
--                     for y2 = y - 1, y - match_num, -1 do
--                         table.insert(match, board[x][y2])
--                     end

--                     table.insert(M.matches, match)
--                 end

--                 color_match = current_color
--                 match_num = 1
--             end
--         end
--         -- 边界问题，当最后一个依然为匹配项的时候
--         if match_num >= 3 then
--             local match = {}
--             for y = board_height - 1, board_height - match_num, -1 do
--                 table.insert(match, board[x][y])
--             end
--             table.insert(M.matches, match)
--         end
--     end

--     return #M.matches > 0 and M.matches or false
-- end

-- function M.get_falling_brick(factory_url)
--     local board = game_data.board
    
--     for x = 0, board_width - 1 do
--         local space = false
--         local space_y = -1
--         local y = 0
--         while y <= board_height - 1 do
--             local brick = board[x][y]
--             if space then
--                 if brick then
--                     board[x][space_y] = brick
--                     brick.y = space_y
--                     board[x][y] = nil
--                     space = false
--                     y = space_y
--                     space_y = -1
--                 elseif brick == nil then
--                     space = true
--                     if space_y == -1 then
--                         space_y = y
--                     end
--                 end
--             end
            
--             y = y + 1
--         end
        
--     end

--     for x = 0, board_width - 1 do
--         for y = board_height - 1, 0, -1 do
--             local brick = board[x][y]
--             if not brick then
--                 local color = game_data.colors_list[math.random(#game_data.colors_list)]
--                 local slot_index = { x, y }
--                 local pos = utils.board_slot_to_world(slot_index)
--                 local new_id = factory.create(factory_url, pos, nil, { color = hash(color) })
--                 board[x][y] = {
--                     id = new_id,
--                     x = x,
--                     y = y,
--                     color = hash(color),
--                     pos = pos
--                 }
--             end
--         end
--     end
-- end

return M