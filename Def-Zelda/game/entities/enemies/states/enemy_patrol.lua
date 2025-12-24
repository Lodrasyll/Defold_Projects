local Patrol = {}
local ANIMS = {

}

local function start_patrol(enemy)
    local DIRECTIONS = {
        vmath.vector3(0, 1, 0),
        vmath.vector3(0, -1, 0),
        vmath.vector3(-1, 0, 0),
        vmath.vector3(1, 0, 0)
    }
    enemy.direction = DIRECTIONS[math.random(#DIRECTIONS)]
end

function Patrol.enter(enemy)
    start_patrol(enemy)
    local patrol_duration = math.random(2, 5)
    enemy.patrol_timer = timer.delay(patrol_duration, false, function ()
        if enemy.fsm:can('stop') then
            enemy.fsm:stop()
        end
    end)
end

function Patrol.update(enemy, dt)
    enemy.velocity = enemy.move_speed * enemy.direction
end

function Patrol.exit(enemy)
    if enemy.patrol_timer then
        timer.cancel(enemy.patrol_timer)
        enemy.patrol_timer = nil
    end
end

return Patrol