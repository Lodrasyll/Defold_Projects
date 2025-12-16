local M = {}

function M.screen_to_tile(screen_x, screen_y, tile_size)
    local x = math.floor(screen_x / tile_size)
    local y = math.floor(screen_y / tile_size)
    return x, y
end

function M.tile_to_screen(tile_x, tile_y, tile_size)
   local x = tile_size / 2 + tile_x * tile_size
   local y = tile_size / 2 + tile_y * tile_size
   return vmath.vector3(x, y, 0)
end

return M