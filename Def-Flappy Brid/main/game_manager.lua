local M = {
    game_state = 'title_state',
    player_score = 0,
    gold_score = 10,
    sliver_score = 8,
    bronze_score = 5,
}

function M.get_game_state()
    return M.game_state
end

function M.set_game_state(new_state)
    M.game_state = new_state
end

function M.get_player_score()
    return M.player_score
end

function M.set_player_score(new_score)
    M.player_score = new_score
end


return M