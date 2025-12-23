local Attack = {}
local ANIMS = {
    ATTACK_UP = hash('attack_up'),
    ATTACK_DOWN = hash('attack_down'),
    ATTACK_LEFT = hash('attack_left'),
    ATTACK_RIGHT = hash('attack_right')
}

-- 辅助函数
local function get_attack_anim(facing)
    local is_horizontal = math.abs(facing.x) > math.abs(facing.y)
    if is_horizontal then
        if facing.x > 0 then
            return ANIMS.ATTACK_RIGHT
        else 
            return ANIMS.ATTACK_LEFT
        end
    else
        if facing.y > 0 then
            return ANIMS.ATTACK_UP
        else 
            return ANIMS.ATTACK_DOWN
        end
    end
end

function Attack.enter(player)
    local anim = get_attack_anim(player.facing)
    sprite.play_flipbook('#sprite', anim)
    player.anim_done = false
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


return Attack