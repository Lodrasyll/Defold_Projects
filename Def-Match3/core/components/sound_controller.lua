local M = {}

-- 给声音分组，方便管理
M.GROUP_MUSIC = 'music'
M.GROUP_SFX = 'sfx'

-- 给声音设置表加入设置字段
local settings = {
    sfx_volume = 1.0,
    music_volume = 1.0,
    master_volume = 1.0,
    gating = {}
}

-- 门控时间窗口
local GATE_WINDOW = 0.2

function M.init()
    
end

-- 播放音乐
function M.play(sound_name, group)
    -- 门控检查，获取时间
    local now = socket.gettime()
    -- 判断设置表中是否有以sound_name为键的值， 以及新时间减去上次播放时间是否小于门控时间窗口
    -- 是则直接返回不播放，否则(利用重复判断短路，直接执行下一段代码）将新时间写入名为sound_name的键的值
    if settings.gating[sound_name] and now - settings.gating[sound_name] < GATE_WINDOW then
        return
    end
    settings.gating[sound_name] = now

    -- 设置声音音量
    local group_volume = (group == M.GROUP_MUSIC) and settings.music_volume or settings.sfx_volume
    local final_gain = settings.master_volume * group_volume

    -- 获取声音url并播放
    local url = msg.url('main', '/sounds', sound_name)
    sound.play(url, { gain = final_gain })
end

-- 停止音乐
function M.stop(sound_name, group)
    local url = msg.url('main', 'sound_manager', sound_name)
    sound.play(url)
end

-- 设置音量接口
function M.set_volume(gruop, value)
    if gruop == M.GROUP_MUSIC then
        settings.music_volume = value
    elseif gruop == M.GROUP_SFX then
        settings.sfx_volume = value
    end
end

return M