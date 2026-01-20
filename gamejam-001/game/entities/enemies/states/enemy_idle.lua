local Idle = {}
local ANIMS = {
    
}

function Idle.enter(enemy)

    -- 停止移动，等待时间，然后开始移动
    enemy.direction = vmath.vector3()
    local wait_time = math.random(0.5, 1)
    enemy.idle_timer = timer.delay(wait_time, false, function ()
        if enemy.fsm:can('move') then
            enemy.fsm:move()
        end
    end)
end

function Idle.update(enemy, dt)

end

function Idle.exit(enemy)
    -- 退出清理，防止混乱
    if enemy.idle_timer then
        timer.cancel(enemy.idle_timer)
        enemy.idle_timer = nil
    end
end


return Idle