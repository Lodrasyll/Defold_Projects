local Idle = {}
local ANIMS = {
    IDLE_DOWN = hash('idle_down'),
    IDLE_UP = hash('idle_up'),
    IDLE_LEFT = hash('idle_left'),
    IDLE_RIGHT = hash('idle_right')
}

-- 辅助函数
local function get_idle_anim(facing)
    
end

function Idle.enter(player)
    local anim = ANIMS.IDLE_DOWN
    local is_horizontal = math.abs(player.facing.x) > math.abs(player.facing.y)
    if is_horizontal then
        if player.facing.x > 0 then anim = ANIMS.IDLE_RIGHT else anim = ANIMS.IDLE_LEFT end
    else
        if player.facing.y > 0 then anim = ANIMS.IDLE_UP else anim = ANIMS.IDLE_DOWN end
    end

    sprite.play_flipbook('#sprite', anim)

    -- 确保待机时没有速度
    player.velocity = vmath.vector3()

    print('player facing: ' .. player.facing)
    print('player anim: ' .. anim)
end

function Idle.update(player, dt)
    -- 状态切换
    if vmath.length(player.direction) ~= 0 then
        player.fsm:move()
    end
end

function Idle.on_input(player, action_id, action)
    
end

function Idle.exit(player)
    
end

return Idle