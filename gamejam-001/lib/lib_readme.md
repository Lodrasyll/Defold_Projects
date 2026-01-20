##/src/lib —— 库与工具脚本
## /editor-scripts/ —— 优化Defold引擎工作流程的编辑器脚本

## /thirdparty/ —— 第三方库（禁止修改源码）
- animx/ —— 高级动画控制库
- lume.lua —— Lua 工具函数库（过滤、映射、延迟调用等）

## /internal/ —— 项目内工具脚本（可被游戏逻辑 require，如数据校验、资源预处理器）
- validate_items.lua —— 校验 items.json 是否符合 schema
- export_atlas.lua —— 自动打包 texture source 为 .atlas（注意：此处应为 Lua，非 Python，
因需被游戏脚本调用）