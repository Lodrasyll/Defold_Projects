local M = {}
local utils = require('core.utils.utils')

function M.create_2d_table(tile_size, table_width, table_height, factory_url)
    local tilemap = {
        tile_size = tile_size,
        width = table_width,
        height = table_height,
        tile = {}
    }

    for x = 0, table_width - 1 do
        tilemap.tile[x] = {}

        for y = 0, table_height - 1 do
            local local_pos = utils.tile_to_screen(x, y, tile_size)
            local id = factory.create(factory_url, local_pos, nil, {})

            tilemap.tile[x][y] = {
                id = id,
                x = x,
                y = y,
            }
        end
    end
    return tilemap
end

return M