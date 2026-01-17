local Flow = require('ludobits.m.flow')
local M = {}

local battle_opening

function M:on_enter(owner)
    Flow.start(function ()
        print('状态：进入开场状态')

        Flow.wait(2) -- 播放开场动画的地方（将来替换）
        -- go.animate('/shadow_1', 'position', ..., function() Flow.signal('intro_done') end)
        -- Flow.wait_for_signal('intro_done')
        print("开场动画结束，切换到菜单")

        owner.stack:pop()
        local States = require('core.systems.battle_states.battle_states')
        owner.stack:push(States.ActionMenu)
    end)
end

battle_opening = function(self)
    -- shadow
    local player_shadow_target_pos = go.get_position('/shadow_1')
    go.set_position(vmath.vector3(-430, 273, 0), '/shadow_1')
    go.animate('/shadow_1', 'position', go.PLAYBACK_ONCE_FORWARD, player_shadow_target_pos, go.EASING_LINEAR, 1, 0,
        function()
            --pokemon
            go.set_position(vmath.vector3(-300, 456, 1), self.player_pokemon_id)
            go.animate(self.player_pokemon_id, 'position', go.PLAYBACK_ONCE_FORWARD, self.player_pokemon_pos,
                go.EASING_LINEAR, 1)
        end)

    -- shadow
    local opponent_shadow_target_pos = go.get_position('/shadow_2')
    go.set_position(vmath.vector3(2300, 744, 0), '/shadow_2')
    go.animate('/shadow_2', 'position', go.PLAYBACK_ONCE_FORWARD, opponent_shadow_target_pos, go.EASING_LINEAR, 1, 0,
        function()
            --pokemon
            go.set_position(vmath.vector3(2000, 861, 1), self.opponent_pokemon_id)
            go.animate(self.opponent_pokemon_id, 'position', go.PLAYBACK_ONCE_FORWARD, self.opponent_pokemon_pos,
                go.EASING_LINEAR, 1)
        end)
end

return M