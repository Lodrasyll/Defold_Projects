## /src/core —— 引擎核心层（跨项目复用）
**存放与具体游戏逻辑无关的通用系统、组件、工具。目标是“可移植到其他 Defold 项目”。**
- `/systems/`：全局系统（输入、存档、成就、事件总线等）
  - `input_system.script` + `input_config.lua` —— 输入映射与设备适配
  - `save_system.script` —— 存档读写、云同步接口
  - `achievement_system.script` —— 成就触发与上报
  - `1event_bus.script` —— 轻量级发布订阅系统（解耦通信）
- `/components/`：可挂载的行为脚本（无资源依赖）
  - `health.script` —— 生命值管理
  - `movement.script` —— 移动控制（支持平台、俯视角等）
  - `inventory.script` —— 物品栏逻辑
  - `state_machine.script` —— 通用状态机（用于敌人/AI）
- `/utils/`：工具函数库
  - `math_utils.lua` —— 向量、插值、随机工具
  - `string_utils.lua` —— 字符串格式化、本地化预处理
  - `table_utils.lua` —— 表深度拷贝、合并、查找