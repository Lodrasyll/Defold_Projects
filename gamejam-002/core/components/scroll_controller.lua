local M = {
    move_speed = 60,
    move_dir = -1,
    rotate_speed = 0.05,
    pos = vmath.vector3(),
    rotation = vmath.vector4(),
    angle = 0
}

local SCREEN_WIDTH = sys.get_config_number('display.width')

-- 背景无限滚动
function M.bg_scroll(obj, gui_obj, dt)
    if obj then
        M.pos = go.get_position(obj)
        M.pos.x = M.pos.x + M.move_dir * M.move_speed * dt
        go.set_position(M.pos, obj)
    elseif gui_obj then
        M.pos = gui.get_position(gui_obj)
        M.pos.y = M.pos.y + M.move_dir * M.move_speed * dt
        gui.set_position(gui_obj, M.pos)
    end

    if M.pos.x <= SCREEN_WIDTH / 3 then
        M.pos.x = M.pos.x + SCREEN_WIDTH / 3
        if obj then
            go.set_position(M.pos, obj)
        elseif gui_obj then
            gui.set_position(gui_obj, M.pos)
        end
    end

    -- 调试模块

end

-- 背景无限旋转
function M.bg_rotate(obj, gui_obj, dt)
    if obj then
        M.rotation = go.get_rotation(obj)
        M.angle = M.angle + M.move_dir * M.rotate_speed * dt
        go.set_rotation(vmath.quat_rotation_z(M.angle), obj)
    elseif gui_obj then
        M.rotation = go.get_rotation(gui_obj)
        M.angle = M.angle + M.move_dir * M.rotate_speed * dt
        gui.set_rotation(gui_obj, vmath.quat_rotation_z(M.angle))
    end
end

return M