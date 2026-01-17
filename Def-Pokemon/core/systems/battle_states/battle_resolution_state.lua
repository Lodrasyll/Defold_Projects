local Flow = require('core.systems.flow')
local M = {}

function M:on_enter(owner)
    Flow.start(function ()
        print('--- 回合结算开始 ---')

        -- 1.玩家攻击
        
        -- 2.触发GUI扣血信号

        -- 3.敌人攻击

        print('--- 回合结束 ----')

        -- 回合结束，弹出结算状态，回到下层菜单状态
        owner.stack:pop()
    end)
end

return M