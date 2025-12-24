local Patrol = {}
local ENEMY_PREFIXES = {
    [hash('ghost')] = 'ghost',
    [hash('slime')] = 'slime',
    [hash('skeleton')] = 'skeleton'
}

local function get_direction_string(direction)
    if math.abs(direction.x) > math.abs(direction.y) then
        return (direction.x > 0) and 'right' or 'left'
    else
        return (direction.y > 0) and 'up' or 'down'
    end
end

local function play_enemy_anim(enemy)
    local perfix = ENEMY_PREFIXES[enemy.enemy_type]
    if not perfix then
        print('ERROR: Unknow enemy type hash: ' .. tostring(enemy.enemy_type))
    end
    local suffix = get_direction_string(enemy.direction)
    local anim_name = perfix .. '_' .. suffix
    if enemy.current_anim ~= anim_name then
        sprite.play_flipbook('#sprite', anim_name)
        enemy.current_anim = anim_name
    end
end

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
    play_enemy_anim(enemy)
    local patrol_duration = math.random(2, 5)
    enemy.patrol_timer = timer.delay(patrol_duration, false, function ()
        if enemy.fsm:can('stop') then
            enemy.fsm:stop()
        end
    end)
end

function Patrol.update(enemy, dt)
    enemy.velocity = enemy.move_speed * enemy.direction
    play_enemy_anim(enemy)
end

function Patrol.exit(enemy)
    if enemy.patrol_timer then
        timer.cancel(enemy.patrol_timer)
        enemy.patrol_timer = nil
    end
    enemy.velocity = vmath.vector3()
end

return Patrol