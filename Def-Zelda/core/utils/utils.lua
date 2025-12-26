local M = {}

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

return  M