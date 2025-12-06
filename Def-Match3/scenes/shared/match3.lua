local M = {}

M.matches = {}

local game_data = require('data.configs.game_data')
local utils = require('core.utils.utils')
local board_width = game_data.board_width
local board_height = game_data.board_height
local board = game_data.board


function M.calculated_match()
    M.matches = {}
    local match_num = 1

    -- 水平方向检测匹配
    for y = 0, board_height - 1 do
        local color_match = nil
        if board[0][y] then
            local color_match = board[0][y].color
        end
        match_num = 1

        for x = 1, board_width - 1 do
            local current_brick = board[x][y]
            local current_color = nil
            if current_brick ~= nil then
                current_color = current_brick.color
            end

            if color_match ~= nil and current_color ~= nil and
            current_color == color_match then
                match_num = match_num + 1
            else
                color_match = board[x][y].color

                if match_num >= 3 then
                    local match = {}
                    for x2 = x - 1, x - match_num, -1 do
                        table.insert(match, board[x2][y])
                    end

                    table.insert(M.matches, match)
                end

                color_match = current_color
                match_num = 1
            end
        end
        -- 边界问题，当最后一个依然为匹配项的时候
        if match_num >= 3 then
            local match = {}
            for x = board_width - 1, board_width - match_num, -1 do
                table.insert(match, board[x][y])
            end
            table.insert(M.matches, match)
        end
    end

    -- 垂直方向检测匹配
    for x = 0, board_width - 1 do
        local color_match = board[x][0].color
        match_num = 1

        for y = 1, board_height - 1 do
            if board[x][y].color == color_match then
                match_num = match_num + 1
            else
                color_match = board[x][y].color

                if match_num >= 3 then
                    local match = {}
                    for y2 = y - 1, y - match_num, -1 do
                        table.insert(match, board[x][y2])
                    end

                    table.insert(M.matches, match)
                end

                match_num = 1
                if y >= board_height - 2 then
                    break
                end
            end
        end
        -- 边界问题，当最后一个依然为匹配项的时候
        if match_num >= 3 then
            local match = {}
            for y = board_height - 1, board_height - match_num, -1 do
                table.insert(match, board[x][y])
            end
            table.insert(M.matches, match)
        end
    end

    if #M.matches > 0 then
        return true
    else
        return false
    end
end

function M.remove_match()
    if M.matches then
        for key, match in pairs(M.matches) do
            for key, brick in pairs(match) do
                if brick.id then
                    go.delete(brick.id)
                end

                board[brick.x][brick.y] = nil
            end
        end
    end

    M.matches = {}
end

function M.get_falling_brick(factory_url)
    for x = 0, board_width - 1 do
        -- ‘写指针’, 它指向下一个方块应该放置的位置（从底部开始堆叠）
        local write_y = 0

        -- STEP 1: 处理现有的方块（下落逻辑）
        for read_y = 0, board_height - 1 do
            local brick = board[x][read_y]
            if brick ~= nil then
                if read_y > write_y then
                    -- 更新数据层
                    board[x][write_y] = brick
                    board[x][read_y] = nil
                    brick.y = write_y
                    -- 更新表现层
                    local slot_index = { x, write_y }
                    local target_pos = utils.board_slot_to_world(slot_index)
                    go.animate(brick.id, "position", go.PLAYBACK_ONCE_FORWARD, target_pos, go.EASING_OUTBOUNCE, 0.5)
                end
                -- 无论有没有移动，写指针都要+1，准备接纳下一个方块
                write_y = write_y + 1
            end
        end

        -- STEP 2: 生成新方块（填充逻辑）
        for fill_y = write_y, board_height - 1 do
            local new_color = game_data.colors_list[math.random(#game_data.colors_list)]
            local spawm_slot_index = { x, board_height }
            local spawn_pos = utils.board_slot_to_world(spawm_slot_index)
            local target_slot_index = { x, board_height }
            local target_pos = utils.board_slot_to_world(target_slot_index)
            local new_id = factory.create(factory_url, spawn_pos, nil, { color = hash(new_color) })

            board[x][fill_y] = {
                id = new_id,
                x = x,
                y = fill_y,
                color = hash(new_color),
                pos = target_pos
            }
            go.animate(new_id, "position", go.PLAYBACK_ONCE_FORWARD, target_pos, go.EASING_OUTBOUNCE, 0.5, 0) -- 最后一个0是delay，可以加上 x*0.1
        end
    end
end


return M