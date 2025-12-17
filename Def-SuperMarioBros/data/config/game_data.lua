local M = {}

M.tilemap = {}
M.tile_size = 64
M.bg_size = 256
M.tilemap_width = 120
M.tilemap_height = 5

M.score = 0

function M.get_score()
    return M.score
end

function M.set_score(new_score)
    M.score = new_score
end


return M