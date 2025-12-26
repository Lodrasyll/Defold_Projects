local M = {}

-- 定义移动的四个方向
local DIRECTIONS = {
    { x = 0, y = 1 },
    { x = 0, y = -1 },
    { x = -1, y = 0},
    { x = 1, y = 0}
}

-- 私有辅助函数
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

local function generate_dungeon_data(width, height)
    -- 数据层：创建地牢数据
    local dungeon = {
        width = width,
        height = height,
        grid = {}
    }
    for x = 1, width do
        dungeon.grid[x] = {}
        for y = 0, height do
            dungeon.grid[x][y] = 0
        end
    end

    return dungeon
end

local function draw_single_room(map_url, grid_x, grid_y, dungeon_config, tile_config, door_config)
    -- 解构配置
    local padding = dungeon_config.padding
    local room_width = dungeon_config.room_width
    local room_height = dungeon_config.room_height
    local layer_names = tile_config.layers
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
    local door_base_x = math.floor((room_start_x + room_end_x) / 2)
    local top_door_base_y = room_end_y
    local bottom_door_base_y = room_start_y

    -- === 渲染绘制循环 ===
    for x = 1, room_width do
        for y = 1, room_height do
            -- 计算最终绘制在地图上的坐标
            local world_x = offset_x + x
            local world_y = offset_y + y

            -- == 阶段A：身份判定
            local is_void = (x < room_start_x) or (x > room_end_x) or (y < room_start_y) or (y > room_end_y)


            -- 所有的图块：包括地板、墙、门、透明层等等
            if is_void then
                tilemap.set_tile(map_url, layer_names.void, world_x, world_y, ids.empty)
                local info = tilemap.get_tile(map_url, layer_names.void, world_x, world_y)
            else
                -- 房间内部绘制逻辑
                local is_top = (y == room_end_y)
                local is_bottom = (y == room_start_y)
                local is_left = (x == room_start_x)
                local is_right = (x == room_end_x)

                -- === 阶段 B: 绘制决策 (Rendering Decision) ===
                -- 优先级：角落 > 墙壁 > 地板
                if is_top and is_left then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.corners.tl))
                
                elseif is_top and is_right then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.corners.tr))
                
                elseif is_bottom and is_left then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.corners.bl))

                elseif is_bottom and is_right then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.corners.br))

                elseif is_top then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.walls.top))

                elseif is_bottom then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.walls.bottom))

                elseif is_left then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.walls.left))

                elseif is_right then
                    tilemap.set_tile(map_url, layer_names.wall, world_x, world_y, get_random_tile(ids.walls.right))

                else
                    tilemap.set_tile(map_url, layer_names.ground, world_x, world_y, get_random_tile(ids.floors))
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
    pprint(start_room)
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
                local has_top = (grid_y < dungeon_height) and (dungeon.grid[grid_x][grid_y + 1] == 1)
                local has_bottom = (grid_y > 1) and (dungeon.grid[grid_x][grid_y - 1] == 1)
                local has_left = (grid_x < dungeon_width) and (dungeon.grid[grid_x + 1][grid_y] == 1)
                local has_right = (grid_x > 1) and (dungeon.grid[grid_x - 1][grid_y] == 1)

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