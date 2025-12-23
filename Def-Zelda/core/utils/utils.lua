local M = {}

function M.count_table(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

-- === 协程工具箱 ===
-- 设计这套工具箱的核心目的：把“异步”的回调地狱，变成“同步”的线性逻辑。

-- 接收一个函数 func（通常是你的 game_loop）
function M.run_async(func)
    -- 创建一个协程程序，独立于主程序之外
    -- 创建后协程程序处于挂起状态 suspended 
    local co = coroutine.create(func)

    -- [设计原理]：按下‘播放键’，开始执行func里的代码
    -- ok表示是否成功，error表示如果报错，展示报错的错误信息
    local ok, error = coroutine.resume(co)
    

    -- [设计原理]：安全检查，防止协程里报错了却不知道
    if not ok then print('Coroutine Error: ', error) end
end

-- 给game_loop创造一个可以‘暂停’的环境
function M.wait_seconds(seconds)
    -- 获取正在运行的那个协程
    local co = coroutine.running()

    -- [设计原理]：设置一个定时器，定在seconds秒后触发
    timer.delay(seconds, false, function ()
        coroutine.resume(co)
    end)

    -- [暂停键]：yield 是“让出控制权”。
    -- 程序执行到这里会立刻停止！Defold 引擎去处理别的事情（比如渲染画面）。
    -- 直到上面的 timer 回调执行 resume，这里才会解除冻结。
    coroutine.yield()
end

-- 群体暂停键,等待所有的动画播放完毕
-- 接收一个创建好的动画table
function M.animate_and_wait(animations)
    -- 防御性编程，如果列表为空，直接返回
    if #animations == 0 then return end

    -- 1. 记录当前协程，方便之后唤醒
    local co = coroutine.running()

    -- 2. 记录一共有多少个动画要播
    local total_animations = #animations

    -- 3. 计数器：查看目前播放完毕的数量
    local finished_animations = 0

    -- 4. 设计一个闭包，私有函数
    -- 这个函数会被传给每一个动画的complete_function
    local function on_complete()
        -- 每播完一个动画，计数加一
        finished_animations = finished_animations + 1

        -- 判断是否所有动画列表都播完了？
        if finished_animations >= total_animations then
            coroutine.resume(co)
        end
    end

    -- [批量启动]：使用ipairs迭代器遍历动画列表
    for _, anim in ipairs(animations) do
        -- go.animate 是 Defold 的 API，它是异步的（不阻塞）
        -- 我们把上面的 on_complete 传进去，告诉引擎：动画播完调一下这个函数
        -- 这里的 anim.id, anim.to 等属性，都是为了通用性设计的结构
        go.animate(anim.id, 'position', go.PLAYBACK_ONCE_FORWARD, anim.to, anim.easing, anim.duration, anim.delay, on_complete)
    end

    -- [暂停]：所有动画指令都发给引擎了，现在协程睡觉
    -- 等 on_complete 被调用最后一次时，会把这里叫醒
    coroutine.yield()
end

return M