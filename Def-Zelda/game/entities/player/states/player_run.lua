local Run = {}
local ANIMS = {
    RUN_DOWN = hash('walk_down'),
    RUN_UP = hash('walk_up'),
    RUN_LEFT = hash('walk_left'),
    RUN_RIGHT = hash('walk_right')
}

local MIN_RUN_TIME = 0.2

-- 辅助函数
local function get_run_anim(direction)
    if math.abs(direction.x) > math.abs(direction.y) then
        return (direction.x > 0) and ANIMS.RUN_RIGHT or ANIMS.RUN_LEFT
    else
        return (direction.y > 0) and ANIMS.RUN_UP or ANIMS.RUN_DOWN
    end
end

function Run.enter(player)
    local anim = get_run_anim(player.direction)
    sprite.play_flipbook('#sprite', anim)
    player.current_anim = anim
    player.run_timer = 0


    print('player anim: ' .. anim)
end

function Run.update(player, dt)
    player.run_timer = player.run_timer + dt

    -- 移动逻辑
    player.velocity = player.move_speed * player.direction

    -- 动画切换
    if vmath.length(player.direction) > 0 then
        local anim = get_run_anim(player.direction)
        if anim ~= player.current_anim then
            sprite.play_flipbook('#sprite', anim)
            player.current_anim = anim
        end
    end

    -- 状态切换
    if vmath.length(player.direction) == 0 then
        if player.run_timer > MIN_RUN_TIME then
            player.fsm:stop()
        end
    end
end

function Run.on_message(player, message_id, message, sender)
    if message_id == hash('contact_point_response') then
        local pos = go.get_position()
        local new_pos = pos + message.normal * message.distance
        go.set_position(new_pos)
    end
end

function Run.on_input(player, action_id, action)

end

function Run.exit(player)
    player.run_timer = nil
end

return Run
