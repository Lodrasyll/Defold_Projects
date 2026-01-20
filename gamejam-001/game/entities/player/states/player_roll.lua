local Roll = {}
local ROLL_SPEED = 500

function Roll.enter(player)
    player.anim_done = false
    sprite.play_flipbook('#sprite', 'roll')

    local roll_dir = player.facing
    player.roll_velocity = vmath.normalize(roll_dir) * ROLL_SPEED
    player.invincible = true
end

function Roll.update(player, dt)
    player.velocity = player.roll_velocity
    if player.anim_done then
        -- 技巧：直接回 Idle，下一帧 player.script 会根据按键自动切回 Run
        player.fsm:stop()
    end
end

function Roll.on_message(player, message_id, message, sender)
    if message_id == hash('animation_done') then
        player.anim_done = true
    end
end

function Roll.exit(player)
    player.invincible = false         -- 关闭无敌
    player.velocity = vmath.vector3() -- 确保停下
end


return Roll