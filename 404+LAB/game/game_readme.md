# /src/game —— 当前游戏专属逻辑
基于 core/ 构建的具体游戏内容，包含实体模板、管理器、配置绑定等。

## /entities/：可复用游戏对象模板（.go + 脚本 + 资源）
- player/ —— 玩家对象完整封装
	- player.go —— 游戏对象结构
	- player.script —— 控制器逻辑（组合 core/components）
	- player.anim —— 动画状态机
	- player.atlas —— 专属图集（可选就近存放）
- enemies/ —— 敌人类型模板
	- enemy_basic/, enemy_boss/ —— 各自独立目录，便于扩展

## /managers/：游戏全局控制器（非 Defold 系统）
- scene_manager.script —— 场景切换、加载状态管理
- enemy_manager.script —— 敌人生成、池化、事件分发
- item_manager.script —— 物品数据库、掉落逻辑、背包同步
✅ 设计原则：每个实体目录应自包含（资源+逻辑+配置），支持拖入任意场景复用。