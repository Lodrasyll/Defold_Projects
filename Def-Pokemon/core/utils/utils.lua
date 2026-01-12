local M = {}
local TILE_SIZE = 16 * 3

function M.position_to_index(pos_x, pos_y, size)
    local x = math.floor(pos_x / size.x)
    local y = math.floor(pos_y / size.y)

    return x, y
end

function M.index_to_position(index_x, index_y, size)
    local x = index_x * size.x + size / 2
    local y = index_y * size.y + size / 2
    return vmath.vector3(x, y, 0)
end

-- gx, gy: 房间在棋盘上的索引 (1-based)
-- lx, ly: 房间内部的局部格子索引 (1-based, 比如 15, 10 是房间中心)
function M.get_world_position(grid_x, grid_y, local_x, local_y, config)
    local tile_size = config.TILE_SIZE
    local room_width = config.ROOMMAP_WIDTH
    local room_height = config.ROOMMAP_HEIGHT

    -- 计算图块的绝对坐标
    local tile_x = (grid_x - 1) * room_width + local_x
    local tile_y = (grid_y - 1) * room_height + local_y

    -- 转换为像素坐标
    local pos_x = (tile_x * tile_size) - (tile_size / 2)
    local pos_y = (tile_y * tile_size) - (tile_size / 2)

    return vmath.vector3(pos_x, pos_y, 1)
end

function M.tile_id(inst, x, y) --inst is self
    x = math.ceil(x)
    y = math.ceil(y)
    return tilemap.get_tile(inst.TILEMAP, inst.TILEMAP_LAYER, math.ceil(x / TILE_SIZE), math.ceil(y / TILE_SIZE)) --TILEMAP & TILEMAP_LAYER is saved as layer on object
end

--- 从任意字典（非连续 Key 的表）中随机获取一个元素
-- @param dictionary (table): 你的源数据表
-- @return key (any): 被选中的 Key
-- @return value (any): 被选中的 Value
-- @return nil: 如果表是空的，返回 nil
function M.random_from_dict(dictionary)
    -- 防御性编程：如果传入的不是表，直接返回
    if type(dictionary) ~= "table" then
        print("[Error] random_from_dict: Input is not a table")
        return nil, nil
    end

    -- 1. 提取所有的 Key
    local keys = {}
    for k, _ in pairs(dictionary) do
        table.insert(keys, k)
    end

    -- 2. 检查表是否为空
    if #keys == 0 then
        return nil, nil
    end

    -- 3. 随机选择一个索引
    local random_index = math.random(#keys)
    local random_key = keys[random_index]

    -- 4. 返回 Key 和 Value (双返回值在 Lua 中非常有用)
    return random_key, dictionary[random_key]
end

return  M