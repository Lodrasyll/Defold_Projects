local M = {}

M.room_floor_list = {}
M.room_door_list = {}
M.room_registry = {}

-- 定义移动的四个方向
local DIRECTIONS = {
    { x = 0, y = 1 },
    { x = 0, y = -1 },
    { x = -1, y = 0},
    { x = 1, y = 0}
}


local function get_random_tile(tile_or_table)
    -- 情况 1：如果它是一个表（列表）
    if type(tile_or_table) == "table" then
        return tile_or_table[math.random(#tile_or_table)]
    
    -- 情况 2：如果它已经是一个数字了（固定ID）
    elseif type(tile_or_table) == "number" then
        return tile_or_table
    end
end

local function generate_random_walk_grid(width, height, max_rooms)
    math.randomseed(os.time())
    -- 初始化全空的网格
    local grid = {}
    for x = 1, width do
        grid[x] = {}
        for y = 1, height do
            grid[x][y] = 0
        end
    end
    -- 设定起点
    local walker_x = math.random(math.ceil(width / 2))
    local walker_y = math.random(math.ceil(height / 2))
    local start_room = { x = walker_x, y = walker_y }
    -- 标记起点房间
    grid[walker_x][walker_y] = 1
    local room_count = 1 -- 当前生成的起点刚房间
    -- 开始游走循环
    while room_count < max_rooms do
        -- 随机选取一个方向
        local direction = DIRECTIONS[math.random(#DIRECTIONS)]
        -- 计算下一步的坐标
        local next_x = walker_x + direction.x
        local next_y = walker_y + direction.y
        -- 边界检查 检测下一步坐标是否超出地图边界
        if next_x > 1 and next_x < width and next_y > 1 and next_y < height then
            -- 移动指针/移动旷工
            walker_x = next_x
            walker_y = next_y

            -- 决定是否挖掘/生成房间
            if grid[walker_x][walker_y] == 0 then
                grid[walker_x][walker_y] = 1
                room_count = room_count + 1
            end
        end
    end

    return grid, start_room
end

local function resolve_tile_type(context)
    local x, y = context.x, context.y
    local bounds = context.bounds
    local door_pos = context.door_pos
    local active = context.door_active

    if (x < bounds.room_start_x) or (x > bounds.room_end_x) or (y < bounds.room_start_y) or (y > bounds.room_end_y) then
        return 'void'
    end

    -- 房间内部边界标记
    local is_top = (y == bounds.room_end_y)
    local is_bottom = (y == bounds.room_start_y)
    local is_left = (x == bounds.room_start_x)
    local is_right = (x == bounds.room_end_x)

    -- === 🚪 核心：门的连通逻辑 ===
    -- 只有当 active.top 为 true 时，才在墙上“挖”出门

    -- 上门
    if is_top and active.top then
        if x == door_pos.x_left then return 'door_top_L' end
        if x == door_pos.x_right then return 'door_top_R' end
    end
    --下门
    if is_bottom and active.bottom then
        if x == door_pos.x_left then return 'door_bottom_L' end
        if x == door_pos.x_right then return 'door_bottom_R' end
    end
    -- 左门
    if is_left and active.left then
        if y == door_pos.y_side_top then return 'door_left_T' end
        if y == door_pos.y_side_bottom then return 'door_left_B' end
    end
    -- 右门
    if is_right and active.right then
        if y == door_pos.y_side_top then return 'door_right_T' end
        if y == door_pos.y_side_bottom then return 'door_right_B' end
    end

    -- === 墙壁与角落 ===
    if is_top and is_left then return 'corner_tl' end
    if is_top and is_right then return 'corner_tr' end
    if is_bottom and is_left then return 'corner_bl' end
    if is_bottom and is_right then return 'corner_br' end

    if is_top then return 'wall_top' end
    if is_bottom then return 'wall_bottom' end
    if is_left then return 'wall_left' end
    if is_right then return 'wall_right' end

    return 'floor'
end

local function draw_single_room(map_url, grid_x, grid_y, dungeon_config, tile_config, door_config)
    -- 解构配置
    local padding = dungeon_config.padding
    local room_width = dungeon_config.room_width
    local room_height = dungeon_config.room_height
    local layers = tile_config.layers
    local ids = tile_config.ids
    
    -- 计算绘制偏移
    -- grid_x 是 1, 2, 3... 转换成 tilemap 的 1, 31, 61...
    local offset_x = (grid_x - 1) * room_width
    local offset_y = (grid_y - 1) * room_height

    -- 计算局部房间边界
    local room_start_x = 1 + padding
    local room_start_y = 1 + padding
    local room_end_x = room_width - padding
    local room_end_y = room_height - padding

    -- 计算门的基准位置
    local door_x_left = math.floor((room_start_x + room_end_x) / 2)
    local door_x_right = door_x_left + 1
    local door_y_top = room_end_y
    local door_y_bottom = room_start_y  
    local door_y_mid_top = math.floor((room_start_y + room_end_y) / 2)
    local door_y_mid_bottom = door_y_mid_top - 1

    -- 准备渲染规则映射
    local render_rules = {
        ['void'] = { layer = layers.void, id = ids.empty },
        ['floor'] = { layer = layers.ground, list = ids.floors },

        ['wall_top'] = { layer = layers.wall, list = ids.walls.top },
        ['wall_bottom'] = { layer = layers.wall, list = ids.walls.bottom },
        ['wall_left'] = { layer = layers.wall, list = ids.walls.left },
        ['wall_right'] = { layer = layers.wall, list = ids.walls.right },

        ['corner_tl'] = { layer = layers.wall, id = ids.corners.tl },
        ['corner_tr'] = { layer = layers.wall, id = ids.corners.tr },
        ['corner_bl'] = { layer = layers.wall, id = ids.corners.bl },
        ['corner_br'] = { layer = layers.wall, id = ids.corners.br },

        ['door_top_L'] = { layer = layers.door, id = ids.door_test },
        ['door_top_R'] = { layer = layers.door, id = ids.door_test },
        ['door_bottom_L'] = { layer = layers.door, id = ids.door_test },
        ['door_bottom_R'] = { layer = layers.door, id = ids.door_test },

        ["door_left_B"]   = { layer = layers.door, id = ids.door_test },
        ["door_left_T"]   = { layer = layers.door, id = ids.door_test },
        ["door_right_B"]  = { layer = layers.door, id = ids.door_test },
        ["door_right_T"]  = { layer = layers.door, id = ids.door_test },
    }

    -- === 渲染绘制循环 ===
    for x = 1, room_width do
        for y = 1, room_height do
            -- 计算最终绘制在地图上的坐标
            local world_x = offset_x + x
            local world_y = offset_y + y

            -- 准备上下文数据
            local context = {
                x = x, y = y,
                bounds = {
                    room_start_x = room_start_x,
                    room_end_x = room_end_x,
                    room_start_y = room_start_y,
                    room_end_y = room_end_y
                },
                door_pos = {
                    x_left = door_x_left, x_right = door_x_right,
                    y_top = door_y_top, y_bottom = door_y_bottom,
                    y_side_top = door_y_mid_top, y_side_bottom = door_y_mid_bottom
                },
                door_active = door_config
            }

            -- == 阶段A：身份判定
            -- == 阶段B：执行绘制 所有的图块：包括地板、墙、门、透明层
            local type_key = resolve_tile_type(context)
            local rule = render_rules[type_key]

            if rule then
                -- 需要ID
                local final_id = rule.id
                if rule.list then
                    final_id = rule.list[math.random(#rule.list)]
                end
                -- 绘制
                if final_id then
                    tilemap.set_tile(map_url, rule.layer, world_x, world_y, final_id)
                end

                -- 2. ✨ 收集门的数据 (这里是关键修改)
                -- 我们只在检测到特定的 Key 时收集数据
                local door_dir = nil

                if type_key == 'door_top_L' then
                    door_dir = hash("top")
                elseif type_key == 'door_bottom_L' then
                    door_dir = hash("bottom")
                elseif type_key == 'door_left_B' then
                    door_dir = hash("left")
                elseif type_key == 'door_right_B' then
                    door_dir = hash("right")
                end

                if door_dir then
                    -- 计算出世界像素坐标!
                    local tile_size = dungeon_config.tile_size
                    local door_x = (world_x * tile_size) - (tile_size / 2)
                    local door_y = (world_y * tile_size) - (tile_size / 2)

                    -- 2. 根据方向应用偏移 (Offset)
                    local final_pos = vmath.vector3(vmath.vector3(door_x, door_y, 0.5))

                    if door_dir == hash("top") then
                        final_pos.x = final_pos.x + tile_size / 2
                        final_pos.y = final_pos.y + tile_size / 2
                    elseif door_dir == hash("bottom") then
                        final_pos.x = final_pos.x + tile_size / 2
                        final_pos.y = final_pos.y - tile_size / 2
                    elseif door_dir == hash("left") then
                        final_pos.x = final_pos.x - tile_size / 2
                        final_pos.y = final_pos.y + tile_size / 2
                    elseif door_dir == hash("right") then
                        final_pos.x = final_pos.x + tile_size / 2
                        final_pos.y = final_pos.y + tile_size / 2
                    end

                    -- 存入列表：包含位置、方向、类型
                    table.insert(M.room_door_list, {
                        pos = final_pos,
                        dir = door_dir,
                        type = "door",
                        grid_x = grid_x,
                        grid_y = grid_y
                    })
                end

                -- 收集地板数据 (如果你需要生成随机怪物)
                if type_key == 'floor' then
                    -- table.insert(M.room_floor_list, { type = "floor", grid_x = grid_x, grid_y = grid_y, lx = x, ly = y })
                    table.insert(M.room_floor_list, { type = "floor", x = x, y = y }) -- 注意：地板数据量巨大，建议谨慎收集，或者只收集特定随机点的
                end
            end
        end
    end
end

function M.generate_dungeon(map_url, dungeon_config, tile_config)
    print('开始生成地牢')

    -- 内部解构数据
    local dungeon_width = dungeon_config.dungeon_width
    local dungeon_height = dungeon_config.dungeon_height
    local max_rooms = dungeon_config.max_rooms

    local grid_data , start_room = generate_random_walk_grid(dungeon_width, dungeon_height, max_rooms)

    local dungeon = {
        width = dungeon_width,
        height = dungeon_height,
        grid = grid_data,
        start_room = start_room
    }

    -- 遍历数据并渲染
    for grid_x = 1, dungeon_width do
        for grid_y = 1, dungeon_height do
            if dungeon.grid[grid_x][grid_y] == 1 then
                
                -- 检查每一间生成房间的上下左右有没有邻居
                local has_top =    (grid_y < dungeon_height) and (dungeon.grid[grid_x][grid_y + 1] == 1)
                local has_bottom = (grid_y > 1) and              (dungeon.grid[grid_x][grid_y - 1] == 1)
                local has_left =   (grid_x > 1) and              (dungeon.grid[grid_x - 1][grid_y] == 1)
                local has_right =  (grid_x < dungeon_width) and  (dungeon.grid[grid_x + 1][grid_y] == 1)
                -- 打包房间门的信息配置
                local door_config = {
                    top = has_top,
                    bottom = has_bottom,
                    left = has_left,
                    right = has_right
                }
                
                draw_single_room(map_url, grid_x, grid_y, dungeon_config, tile_config, door_config)
            end
        end
    end
    print("生成完毕！")

    return {
        dungeon = dungeon,
        width = dungeon_width,
        height = dungeon_height,
        dungeon_config = dungeon_config,
    }
end


return M