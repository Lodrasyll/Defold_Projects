# /src/data —— 游戏数据与配置
所有游戏参数、文本、本地化内容，支持热更新与策划配置。

## /configs/ —— 结构化游戏数据（推荐 JSON 格式）
items.json —— 道具属性（ID、图标、效果、价格）
enemies.json —— 敌人属性（血量、速度、掉落）
levels.json —— 关卡元数据（解锁条件、背景音乐、目标）

## /runtime/ —— 运行时生成数据（存档、缓存、临时状态）
player_progress.dat —— 玩家进度、成就状态、设置

## /localization/ —— 多语言文本
en.json, zh.json —— 键值对文本（如 "button_start": "开始游戏"）
i18n_manager.script —— 语言切换、文本动态加载