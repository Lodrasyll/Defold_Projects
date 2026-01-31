# /src/scenes —— 游戏场景与关卡
每个子目录代表一个可独立加载的场景（通过 Collection Proxy）。

- main_menu/
	- menu.collection —— 场景根集合
	- menu_controller.script —— 场景生命周期与 UI 逻辑
	- menu.gui —— 主菜单界面
	- /assets/ —— 场景私有资源（背景、音效等，就近管理）

- level_1/
	- level_1.collection
	- level_controller.script —— 关卡逻辑、胜利条件、事件触发
	- /environment/ —— 地图、瓦片、静态物件
		- tileset.tilesource, level_map.tilemap
	- /props/ —— 可交互场景物件（宝箱、门、机关）

- /shared/ —— 多场景共享功能模块
	- camera/ —— 通用相机控制（跟随、震动、边界限制）
	- lighting/ —— 全局光照、昼夜循环、特效控制
✅ 加载策略：每个场景应能独立加载/卸载，资源尽量私有化避免耦合。