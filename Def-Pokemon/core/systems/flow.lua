local Flow = {}

Flow.current_coroutine = nil
Flow.wait_timer = 0
Flow.wait_for_signal = nil --记录当前的正在等待的信号名称

function Flow.start(func)
    -- 创建一个协程
    Flow.current_coroutine = coroutine.create(func)
    -- 开始运行协程，添加调试
    local ok, error = coroutine.resume(Flow.current_coroutine)
    if not ok then print('Coroutine Error: ', error) end
end

function Flow.wait(second)
   wait_timer = second
   -- 核心：在这里暂停函数，并将控制权交还给调度器
   coroutine.yield()
end

function Flow.stop()
    Flow.current_coroutine = nil
    wait_timer = 0
end

function Flow.update(dt)
    if not Flow.current_coroutine then return end

    if wait_timer > 0 then
        wait_timer = wait_timer - dt
    elseif wait_for_signal == nil then
        if coroutine.status(Flow.current_coroutine) ~= "dead" then
            coroutine.resume(Flow.current_coroutine)
        else
            Flow.current_coroutine = nil
        end
    end
end

-- 等待动画的信号
function Flow.wait_for_signal(signal_name)
    wait_for_signal = signal_name
    coroutine.yield()
end
-- 当动画结束时，由外部调用此函数
function Flow.signal(signal_name)
    if Flow.current_coroutine and wait_for_signal == signal_name then
        wait_for_signal = nil
        coroutine.resume(Flow.current_coroutine)
    end
end

return Flow