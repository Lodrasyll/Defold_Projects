local Flow = require('core.systems.flow')
local states = {}

-- 1. 主菜单状态
states.ActionMenu = {
    on_enter = function(owner)
        print("UI显示：[战斗] [包包] [宝可梦] [逃跑]")
        -- msg.post("battle_screen#gui", "show_main_menu") -- 通知 GUI 显示菜单
    end,

    on_input = function(owner, action_id, action)
        -- 这里不需要写 UP/DOWN 了，Druid 在 GUI 里处理
        -- 返回 false，允许输入流向下传递给 GUI 系统
        return false
    end,

    on_exit = function(owner)
        -- 告诉 GUI：隐藏或禁用菜单
        msg.post("/monarch#level_3", "set_menu_active", { active = false })
    end
}

-- 2. 技能菜单状态
states.MoveMenu = {
    on_enter = function(owner)
        print("UI显示：技能列表")
    end,

    on_input = function(owner, action_id, action)
        if action_id == hash("back") and action.pressed then
            -- 核心：返回上一级
            owner.stack.pop()
            return true
        elseif action_id == hash("confirm") and action.pressed then
            -- 选择技能，准备进入结算流
            print("发动技能！进入 Flow...")
            -- 这里的逻辑我们下一阶段结合 Flow 来写
            return true
        end
    end
}

states.Resolution = {
    on_enter = function(owner)
        -- 核心：进入结算时，立刻让 GUI 菜单失效
        msg.post("/monarch#level_3", "set_menu_active", { active = false })

        Flow.start(function()
            -- owner 就是 battle_controller.script 的 self
            owner:execute_battle_flow()
        end)
    end,
    on_input = function(owner, action_id, action)
        -- 关键：在这里返回 true，拦截所有试图传给 GO 的输入
        return true
    end
}

return states
