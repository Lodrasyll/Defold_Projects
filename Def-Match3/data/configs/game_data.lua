local M = {}

-- list用于随机 map用于查找
M.colors_list = { "black", "yellow", "blue", "purple", "green", "red" }
M.colors_map = {
    [hash("black")] = "black",
    [hash("yellow")] = "yellow",
    [hash("blue")] = "blue",
    [hash("purple")] = "purple",
    [hash("green")] = "green",
    [hash("red")] = "red"
}

M.player_score = 0
M.player_swap_time = 10
M.level = 1
M.highest_combo = 0

return M
