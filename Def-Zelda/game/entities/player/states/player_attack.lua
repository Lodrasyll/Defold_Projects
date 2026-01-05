local Attack = {}
local ANIMS = {
    ATTACK_UP = hash('attack_up'),
    ATTACK_DOWN = hash('attack_down'),
    ATTACK_LEFT = hash('attack_left'),
    ATTACK_RIGHT = hash('attack_right')
}
local HITBOX_MAP = {
    [ANIMS.ATTACK_UP] = 'up',
    [ANIMS.ATTACK_DOWN] = 'down',
    [ANIMS.ATTACK_LEFT] = 'left',
    [ANIMS.ATTACK_RIGHT] = 'right'
}

-- 辅助函数
local function get_attack_anim(facing)
    local is_horizontal = math.abs(facing.x) > math.abs(facing.y)
    if is_horizontal then
        return (facing.x > 0) and ANIMS.ATTACK_RIGHT or ANIMS.ATTACK_LEFT
    else
        return (facing.y > 0) and ANIMS.ATTACK_UP or ANIMS.ATTACK_DOWN
    end
end

function Attack.enter(player)
    local anim = get_attack_anim(player.facing)
    sprite.play_flipbook('#sprite', anim)
    player.anim_done = false

    local hitbox_key = HITBOX_MAP[anim]
    if hitbox_key then
        player.current_hitbox = player.hitboxes[hitbox_key]
        -- 延迟配合挥剑动画表现自然
        timer.delay(0.1, false, function()
            if player.current_hitbox then
                msg.post(player.current_hitbox, 'enable')
            end
        end)
        -- print('enable hitbox')
    end 
end

function Attack.update(player, dt)
    if player.anim_done then
        player.fsm:stop()
    end
end

function Attack.on_message(player, message_id, message, sender)
    if message_id == hash('animation_done') then
        player.anim_done = true
    end
end

function Attack.exit(player)
    if player.current_hitbox then
        msg.post(player.current_hitbox, 'disable')
        player.current_hitbox = nil
        -- print('disable hitbox')
    end
end


return Attack