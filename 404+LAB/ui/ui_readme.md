# /src/ui —— 用户界面系统
完全基于 Defold GUI 系统构建，支持组件化、数据驱动。

## /widgets/ —— 原子级 UI 控件（可嵌套复用）
- health_bar/
- health_bar.gui —— 血条视觉结构
- health_bar.script —— 绑定角色生命值，自动更新
- dialog_box/
支持文字滚动、选项分支、头像显示
## /screens/ —— 完整功能界面（可独立加载）
- - pause_menu/ —— 暂停界面，含继续/设置/退出
- - settings/ —— 音量、画质、控制设置，支持保存

✅ 最佳实践：每个 .gui 文件必须配套 .script 实现逻辑与数据绑定，避免在场景控制器中直接操作
GUI 节点。