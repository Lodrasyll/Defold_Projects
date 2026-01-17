local Flow = {}

local current_coroutine = nil
local wait_timer = 0
local wait_for_signal = nil --记录当前的正在等待的信号名称

function Flow.start(func)
    -- 创建一个协程
    current_coroutine = coroutine.create(func)
    -- 开始运行协程，添加调试
    local ok, error = coroutine.resume(current_coroutine)
    if not ok then print('Coroutine Error: ', error) end
end

-- 内部使用的 resume 包装，增加安全性
local function safe_resume()
    if current_coroutine and coroutine.status(current_coroutine) ~= "dead" then
        local ok, err = coroutine.resume(current_coroutine)
        if not ok then print("Flow Resume Error:", err) end
    else
        current_coroutine = nil
    end
end

function Flow.wait(second)
   wait_timer = second
   -- 核心：在这里暂停函数，并将控制权交还给调度器
   coroutine.yield()
end

function Flow.stop()
    current_coroutine = nil
    wait_timer = 0
end

function Flow.update(dt)
    if not current_coroutine then return end

    if wait_timer > 0 then
        wait_timer = wait_timer - dt
        if wait_timer <= 0 then
            wait_timer = 0
            safe_resume()
        end

    -- elseif wait_for_signal == nil then
    --     -- 如果既不等等时间也不等信号，尝试运行
    --     safe_resume()
    end
end

-- 等待动画的信号
function Flow.wait_for_signal(signal_name)
    wait_for_signal = signal_name
    coroutine.yield()
end
-- 当动画结束时，由外部调用此函数
function Flow.signal(signal_name)
    if current_coroutine and wait_for_signal == signal_name then
        wait_for_signal = nil -- 清除信号灯
        safe_resume()
    else
        -- 这行能帮你发现信号丢失
        print("Flow 警告：收到信号 " .. signal_name .. " 但当前协程正在等待 " .. tostring(wait_for_signal))
    end
end

return Flow