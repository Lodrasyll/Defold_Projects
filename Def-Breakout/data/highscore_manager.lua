local M = {}

-- 1. 定义文件路径（常量）
local FILE_PATH = sys.get_save_file('Def-Breakout', 'highscore_data')

-- 2. 内存中的数据缓存
local scores_data = {}

-- 默认的高分榜结构
local function get_defult_scores()
    return {
        { name = "AAA", score = 10000 },
        { name = "AAA", score = 9000 },
        { name = "AAA", score = 8000 },
        { name = "AAA", score = 7000 },
        { name = "AAA", score = 1000 },
    } 
end

-- 3. 加载数据
function M.load()
    local data = sys.load(FILE_PATH)

    -- 检查文件是否存在或为空（第一次运行游戏时）
    if not next(data) then
        scores_data = get_defult_scores()
    else
        scores_data = data
    end

    return scores_data
end

-- 4. 保存数据
function M.save()
    -- sys.save 期望的是一个table
    local success = sys.save(FILE_PATH, scores_data)
    if not success then
        print('Error: Failed to save hightscore')
    end
end

-- 5. 尝试添加新分数（核心业务逻辑）
-- 如果分数够高进入榜单，返回true，否则返回false
function M.add_score(new_score, player_name)
    -- 插入新分数
    table.insert(scores_data, { score = new_score, name = player_name })

    -- 分数排序
    table.sort(scores_data, function (a, b)
        return a.score > b.score
    end)

    -- 只保留前10名
    while #scores_data > 10 do
        table.remove(scores_data) -- 移除最后一名
    end

    -- 数据变动了，立即保存
    M.save()
end

-- 6.获取当前排行榜（给排行榜UI使用）
function M.get_list()
    return scores_data
end

function M.is_new_highscore(new_score)
    -- 1. 安全检查：如果数据没有加载，先加载
    if not scores_data then M.load() end

    -- 2. 情况一：如果榜单未满
    if #scores_data < 10 then
        return true
    end

    -- 3. 情况二：如果榜单满了，比较最后一名
    local last_entry = scores_data[#scores_data]

    if new_score > last_entry.score then
        return true
    end

    return false
end

return M