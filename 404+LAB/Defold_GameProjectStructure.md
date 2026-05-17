# Defold 项目结构说明（工业级规范）

**项目根目录 = `/src`** —— 所有游戏运行时内容必须位于此目录内。
**工程辅助内容（文档、构建、工具）与 `/src` 同级** —— 便于自动化、协作、部署。

## 最终推荐结构（Defold 项目）

```text
/your_project_root
│
├── /src                        // 👈 所有游戏内容主体（Defold 项目根目录指向这里）
│   ├── /assets
│   │   ├── /audio
│   │   │   ├── sfx/
│   │   │   └── music/
│   │   ├── /fonts
│   │   └── /textures
│   │       ├── source/         // 👈 原始设计稿（不参与构建）
│   │       └── generated/      // 👈 构建脚本导出的图集/纹理（参与构建）
│   │
│   ├── /core
│   │   ├── /systems
│   │   ├── /components
│   │   └── /utils
│   │
│   ├── /game
│   │   ├── /entities
│   │   └── /managers
│   │
│   ├── /scenes
│   │   ├── main_menu/
│   │   ├── level_1/
│   │   └── /shared
│   │
│   ├── /ui
│   │   ├── /widgets
│   │   └── /screens
│   │
│   ├── /data
│   │   ├── configs/
│   │   ├── runtime/
│   │   └── localization/
│   │
│   ├── /lib
│   │   ├── thirdparty/         // 👈 第三方库（禁止修改）
│   │   └── internal/           // 👈 项目内工具脚本（可被游戏逻辑 require）
│   │
│   ├── main.collection
│   ├── main.script
│   └── game.project            // 👈 Defold 项目配置文件（必须位于 /src 根）
│
├── /docs                       // 👈 与 src 同级，存放设计文档
│   ├── ART_STYLE_GUIDE.md
│   ├── NAMING_CONVENTIONS.md
│   └── ARCHITECTURE.md
│
├── /build                      // 👈 构建输出、临时文件（应加入 .gitignore）
│   ├── bundle/
│   └── temp/
│
├── /tools                      // 👈 工程自动化脚本（非游戏运行时，非 Defold 加载）
│   ├── texture_packer.py
│   ├── localization_sync.js
│   └── ci_deploy.sh
│
├── /scripts                    // 👈 可选：项目级脚本（启动、打包、部署）
│   ├── build_android.sh
│   └── run_dev_server.js
│
├── .gitignore
├── README.md
└── LICENSE
```

## Defold 项目设置说明

在 Defold 编辑器中：

1. 打开项目时，**项目根目录应指向** `/src`。
2. `game.project` 文件必须位于 `/src` 根目录。
3. 所有资源引用路径（如 `go.set("#sprite", "texture0", "/assets/textures/player.png")`）仍以 `/src` 为根。

✅ 示例：`/src/assets/audio/sfx/jump.wav` → 在代码中引用为 `"/assets/audio/sfx/jump.wav"`

## 目录职责说明

| 目录 | 职责说明 |
| --- | --- |
| `/src` | 游戏全部源码、资源、配置、脚本。Defold 项目根目录。 |
| `/docs` | 设计文档、规范、架构图、命名约定。非游戏运行时内容。 |
| `/build` | 构建产物（APK/IPA/WebBundle）、临时文件、缓存。应加入 `.gitignore`。 |
| `/tools` | 工程辅助脚本：批量处理资源、同步翻译、自动化测试等（**非游戏运行时加载**）。 |
| `/scripts` | 项目启动、打包、部署脚本（可选，大型项目推荐）。 |

## 示例 `.gitignore` 片段（推荐）

```gitignore
# Build outputs
/build/
/src/.internal/
/src/build/

# Defold temp/cache
/src/.defold/
/src/cache/

# OS files
.DS_Store
Thumbs.db

# Local config (Defold 自动生成)
/src/game.project.local
/src/editor.layout
```

## 一、`/src` —— 游戏源码与资源主体（Defold 项目根）

所有游戏逻辑、资源、配置、脚本、场景等运行时内容都必须放在此目录下。Defold 编辑器打开项目时，应指向 `/src`。

### 1. `/src/assets` —— 原始与导出资源

存放所有游戏资源文件，按类型分类，便于美术/音效协作。

*   `/audio/`
    *   `sfx/`：音效（按钮点击、跳跃、爆炸等）
    *   `music/`：背景音乐（BGM）
*   `/fonts/`
    *   `.font` + `.ttf` 文件，用于 GUI 文本渲染
*   `/textures/`
    *   `source/`：原始设计稿（PSD、AI、SVG 等，**不参与构建**）
    *   `generated/`：构建脚本导出的图集/纹理（如 `.png`, `.atlas`），**参与构建**

✅ **规范建议：**资源命名使用 `snake_case`，如 `player_idle.png`, `button_primary.font`

### 2. `/src/core` —— 引擎核心层（跨项目复用）

存放与具体游戏逻辑无关的通用系统、组件、工具。目标是“可移植到其他 Defold 项目”。

*   `/systems/`：全局系统（输入、存档、成就、事件总线等）
    *   `input_system.script` + `input_config.lua` —— 输入映射与设备适配
    *   `save_system.script` —— 存档读写、云同步接口
    *   `achievement_system.script` —— 成就触发与上报
    *   `event_bus.script` —— 轻量级发布订阅系统（解耦通信）
*   `/components/`：可挂载的行为脚本（无资源依赖）
    *   `health.script` —— 生命值管理
    *   `movement.script` —— 移动控制（支持平台、俯视角等）
    *   `inventory.script` —— 物品栏逻辑
    *   `state_machine.script` —— 通用状态机（用于敌人/AI）
*   `/utils/`：工具函数库
    *   `math_utils.lua` —— 向量、插值、随机工具
    *   `string_utils.lua` —— 字符串格式化、本地化预处理
    *   `table_utils.lua` —— 表深度拷贝、合并、查找

✅ **复用原则：**此目录内容应避免引用 `/game` 或 `/scenes` 中的具体资源或逻辑。

### 3. `/src/game` —— 当前游戏专属逻辑

基于 `core/` 构建的具体游戏内容，包含实体模板、管理器、配置绑定等。

*   `/entities/`：可复用游戏对象模板（`.go` + 脚本 + 资源）
    *   `player/` —— 玩家对象完整封装
        *   `player.go` —— 游戏对象结构
        *   `player.script` —— 控制器逻辑（组合 core/components）
        *   `player.anim` —— 动画状态机
        *   `player.atlas` —— 专属图集（可选就近存放）
    *   `enemies/` —— 敌人类型模板
        *   `enemy_basic/`, `enemy_boss/` —— 各自独立目录，便于扩展
*   `/managers/`：游戏全局控制器（非 Defold 系统）
    *   `scene_manager.script` —— 场景切换、加载状态管理
    *   `enemy_manager.script` —— 敌人生成、池化、事件分发
    *   `item_manager.script` —— 物品数据库、掉落逻辑、背包同步

✅ **设计原则：**每个实体目录应自包含（资源+逻辑+配置），支持拖入任意场景复用。

### 4. `/src/scenes` —— 游戏场景与关卡

每个子目录代表一个可独立加载的场景（通过 Collection Proxy）。

*   `main_menu/`
    *   `menu.collection` —— 场景根集合
    *   `menu_controller.script` —— 场景生命周期与 UI 逻辑
    *   `menu.gui` —— 主菜单界面
    *   `/assets/` —— 场景私有资源（背景、音效等，就近管理）
*   `level_1/`
    *   `level_1.collection`
    *   `level_controller.script` —— 关卡逻辑、胜利条件、事件触发
    *   `/environment/` —— 地图、瓦片、静态物件
        *   `tileset.tilesource`, `level_map.tilemap`
    *   `/props/` —— 可交互场景物件（宝箱、门、机关）
*   `/shared/` —— 多场景共享功能模块
    *   `camera/` —— 通用相机控制（跟随、震动、边界限制）
    *   `lighting/` —— 全局光照、昼夜循环、特效控制

✅ **加载策略：**每个场景应能独立加载/卸载，资源尽量私有化避免耦合。

### 5. `/src/ui` —— 用户界面系统

完全基于 Defold GUI 系统构建，支持组件化、数据驱动。

*   `/widgets/` —— 原子级 UI 控件（可嵌套复用）
    *   `health_bar/`
        *   `health_bar.gui` —— 血条视觉结构
        *   `health_bar.script` —— 绑定角色生命值，自动更新
    *   `dialog_box/`
        *   支持文字滚动、选项分支、头像显示
*   `/screens/` —— 完整功能界面（可独立加载）
    *   `pause_menu/` —— 暂停界面，含继续/设置/退出
    *   `settings/` —— 音量、画质、控制设置，支持保存

✅ **最佳实践：**每个 `.gui` 文件必须配套 `.script` 实现逻辑与数据绑定，避免在场景控制器中直接操作 GUI 节点。

### 6. `/src/data` —— 游戏数据与配置

所有游戏参数、文本、本地化内容，支持热更新与策划配置。

*   `/configs/` —— 结构化游戏数据（推荐 JSON 格式）
    *   `items.json` —— 道具属性（ID、图标、效果、价格）
    *   `enemies.json` —— 敌人属性（血量、速度、掉落）
    *   `levels.json` —— 关卡元数据（解锁条件、背景音乐、目标）
*   `/runtime/` —— 运行时生成数据（存档、缓存、临时状态）
    *   `player_progress.dat` —— 玩家进度、成就状态、设置
*   `/localization/` —— 多语言文本
    *   `en.json`, `zh.json` —— 键值对文本（如 `"button_start": "开始游戏"`）
    *   `i18n_manager.script` —— 语言切换、文本动态加载

### 7. `/src/lib` —— 库与工具脚本

*   `/thirdparty/` —— 第三方库（**禁止修改源码**）
    *   `animx/` —— 高级动画控制库
    *   `lume.lua` —— Lua 工具函数库（过滤、映射、延迟调用等）
*   `/internal/` —— 项目内工具脚本（可被游戏逻辑 `require`，如数据校验、资源预处理器）
    *   `validate_items.lua` —— 校验 `items.json` 是否符合 schema
    *   `export_atlas.lua` —— 自动打包 texture source 为 `.atlas`（**注意：此处应为 Lua，非 Python，因需被游戏脚本调用**）

### 8. 根文件（位于 `/src/`）

*   `main.collection` —— 游戏启动入口集合（通常只包含 `main.script` 和初始场景代理）
*   `main.script` —— 初始化游戏系统、加载第一个场景
*   `game.project` —— Defold 项目配置文件（必须位于 `/src/` 根目录）

## 二、工程辅助目录（与 `/src` 同级）

### 1. `/docs` —— 项目文档

*   `STRUCTURE.md` —— 本文件，目录结构说明
*   `ART_STYLE_GUIDE.md` —— 美术资源规范（分辨率、配色、格式）
*   `NAMING_CONVENTIONS.md` —— 命名规则（脚本、GO、图集、音效等）
*   `ARCHITECTURE.md` —— 系统架构图、通信流程、状态机设计
*   `RELEASE_NOTES.md` —— 版本更新日志

✅ 建议使用 Markdown + 图床，便于团队查阅和版本控制。

### 2. `/build` —— 构建产物与临时文件

*   `/bundle/` —— Defold 打包输出（APK/IPA/Web/Bundle）
*   `/temp/` —— 临时构建缓存、中间文件
*   `/symbols/` —— （可选）崩溃符号表，用于线上错误追踪

🚫 此目录应加入 `.gitignore`，不提交到版本库。

### 3. `/tools` —— 工程自动化脚本（非游戏运行时）

*   `texture_packer.py` —— 批量处理 PSD → PNG → Atlas
*   `localization_sync.js` —— 从翻译平台拉取最新语言包到 `/src/data/localization/`
*   `ci_deploy.sh` —— 自动化构建 + 上传测试包到分发平台
*   `asset_lint.py` —— 检查资源命名、格式、大小是否合规

✅ 可配合 GitHub Actions / GitLab CI 实现自动化流水线。

### 4. `/scripts` —— 项目级运行脚本（可选）

*   `build_android.sh` —— 一键构建安卓包
*   `run_dev_server.js` —— 启动本地资源服务器（用于热更测试）
*   `export_docs.sh` —— 生成文档网站或 PDF

💡 适合大型项目或需要多环境部署的团队。

## 三、根目录文件说明

*   `.gitignore` —— 忽略构建产物、临时文件、本地配置
*   `README.md` —— 项目简介、快速启动指南、依赖说明
*   `LICENSE` —— 开源协议（如 MIT、Apache）
*   `CHANGELOG.md` —— （可选）版本变更历史

## 四、协作与开发建议

| 角色 | 主要操作目录 | 注意事项 |
| --- | --- | --- |
| 程序员 | `/src/core`, `/src/game`, `/src/scenes` | 避免硬编码，多用配置驱动 |
| 美术 | `/src/assets/textures`,<br>`/src/scenes/*/assets` | 命名规范，提供 source 和 generated |
| 音效 | `/src/assets/audio` | 格式统一（OGG/WAV），带前缀如 `sfx_`, `bgm_` |
| 策划 | `/src/data/configs`, `/docs` | 使用 Excel → JSON 工具，避免手写 JSON |
| QA / DevOps | `/build`, `/tools`, `/scripts` | 编写自动化测试和部署脚本 |

## 五、推荐工作流

1. **开发时**：Defold 编辑器打开 `/src`
2. **构建时**：从项目根目录执行 `/tools/build_android.sh`
3. **提交前**：运行 `/tools/asset_lint.py` + `/tools/validate_configs.py`
4. **发布时**：CI 自动打包 → 上传 → 生成 Release Note