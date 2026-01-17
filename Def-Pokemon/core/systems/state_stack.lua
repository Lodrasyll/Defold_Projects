local M = {}

function M.create(owner)
    local self = {
        stack = {},
        owner = owner -- 这个 owner 通常是调用它的战斗脚本(self)
    }

    -- 压入新状态
    function self.push(state)
        table.insert(self.stack, state)
        if state.on_enter then state.on_enter(self.owner) end
    end

    -- 弹出状态
    function self.pop()
        local top = table.remove(self.stack)
        if top and top.on_exit then top.on_exit(self.owner) end
        return top
    end

    -- 仅更新最顶层的状态
    function self.update(dt)
        local top = self.stack[#self.stack]
        if top and top.on_update then top.on_update(self.owner, dt) end
    end

    -- 仅处理最顶层状态的输入
    function self.on_input(action_id, action)
        local top = self.stack[#self.stack]
        if top and top.on_input then
            -- 如果状态处理了输入并返回 true，则不再向下传递
            return top.on_input(self.owner, action_id, action)
        end
        return false
    end

    return self
end

return M
