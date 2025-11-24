local M = {}

-- 定义声音的类型，方便管理音量
M.GROUP_SFX =  'sfx'
M.GROUP_MUSIC = 'music'

local settings = {
    sfx_volume = 1.0,
    music_volume = 1.0,
    master_volume = 1.0,
    gating = {}         -- 用于门控的表
}

-- 门控时间窗口(秒): 在这个时间内，同一声音不能播放第二次
local GATE_WINDOW = 0.1

-- 初始化函数，通常在 sound_manager.script 的 init 里调用
function M.init()
    -- 可以在这里加载存档的音量设置

end

-- 核心播放函数
function M.play(sound_name, group)
    -- 门控检查 (Gating Check)
    local now = socket.gettime()
    if settings.gating[sound_name] and now - settings.gating[sound_name] < GATE_WINDOW then
        return
    end
    settings.gating[sound_name] = now -- 更新该声音的最后播放时间

    -- 计算最终音量
    local group_volume = (group == M.GROUP_MUSIC) and settings.music_volume or settings.sfx_volume
    local final_gain = settings.master_volume * group_volume

    -- 发送消息给具体的组件播放
    local url = msg.url('main', '/sound_manager', sound_name)
    sound.play(url, { gain = final_gain })
end

-- 停止音乐
function M.stop(sound_name)
    local url = msg.url('main', '/sound_manager', sound_name)
    sound.stop(url)
end

-- 设置音量接口
function M.set_volume(group, value)
    if group == M.GROUP_MUSIC then
        settings.music_volume = value
    elseif group == M.GROUP_SFX then
        settings.sfx_volume = value
    end
end

return M