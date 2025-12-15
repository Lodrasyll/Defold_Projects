local M = {
    state = 'main_menu'
}

function M.get_state()
    return M.state
end

function M.set_state(new_state)
    M.state = new_state
end

return M