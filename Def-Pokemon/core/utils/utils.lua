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

return  M