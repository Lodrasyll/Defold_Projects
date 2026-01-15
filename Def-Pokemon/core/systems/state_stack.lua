local StateStack = {}

function StateStack.push(self, state)
    table.insert(self.stack, state)
    state:on_enter()
end

function StateStack.pop(self)
    local state = table.remove(self.stack)
    state:on_exit()
end

function StateStack.update(self, dt)
    local top = self.stack[#self.stack]
    if top and top.update then
        top:update(dt)
    end
end


return StateStack