local M = { name = "ActionMenu" }

function M:on_enter(owner)
    print('主菜单：fight攻击，run逃跑')
end

function M:on_input(owner, action_id, action)
    if action_id == hash('key_up') and action.pressed then
        local States = require("core.systems.battle_states.battle_states")
        owner.stack:push(States.Resolution)
        return true
    end
    return false
end

function M:on_exit(owner)
    print("【主菜单】退出")
end

return M