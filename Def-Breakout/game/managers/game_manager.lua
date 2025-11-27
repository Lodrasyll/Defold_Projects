-- main/game_state.lua
local M = {}

M.selected_player = 1     -- 存储玩家选择的索引 (1: 普通, 2: 大, 3: 小)
M.game_state = 'title_state'    -- 游戏默认状态
M.player_score = 0              -- 游戏结算分数
M.brick_count = 0
M.level = 1

function M.get_state()
    return M.game_state
end

function M.set_state(new_state)
    M.game_state = new_state
end

function M.get_score()
    return M.player_score
end

function M.set_score(new_score)
    M.player_score = new_score
end

function M.brick_destoryed()
    M.brick_count = M.brick_count - 1
end

function M.get_brick_count()
    return  M.brick_count
end

function M.set_brick_count(brick_count)
    M.brick_count = brick_count
end

function M.get_level()
    return M.level
end

function M.set_level()
    M.level = M.level + 1
end

return M
