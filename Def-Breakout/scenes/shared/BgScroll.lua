local M = {
    scroll_speed = 60,
    scroll_dir = 1,
    pos = vmath.vector3()
}

local SCREEN_HEIGHT = sys.get_config_number('display.height')

function M.update(obj, guiobj, dt)
    if obj then
        M.pos = go.get_position(obj)
        M.pos.y = M.pos.y + M.scroll_dir * M.scroll_speed * dt
        go.set_position(M.pos, obj)
    elseif guiobj then
        M.pos = gui.get_position(guiobj)
        M.pos.y = M.pos.y + M.scroll_dir * M.scroll_speed * dt
        gui.set_position(guiobj, M.pos)
    end

    if M.pos.y >= SCREEN_HEIGHT then
        M.pos.y = M.pos.y - SCREEN_HEIGHT
        if obj then
            go.set_position(M.pos, obj)
        elseif guiobj then
            gui.set_position(guiobj, M.pos)
        end
    end

    -- 调试模块

end

return M