local M = {}

---- 音效列表枚举 ----
M.sfx = {
    paddle_hit = 'main:/sounds#paddle_hit',
    score = 'main:/sounds#score',
    wall_hit = 'main:/sounds#wall_hit',
    music = 'main:/sounds#music'
}

---- 播放音效 ----
function M.play_sfx(id)
    sound.stop(M.sfx[id])
    sound.play(M.sfx[id])
end

---- 停止音效 ----
function M.stop_sfx(id)
    sound.stop(M.sfx[id])
end

return M