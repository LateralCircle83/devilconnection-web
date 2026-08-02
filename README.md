# 恶魔连结（Devil Connection）浏览器移植版 — ModLoader Fork

> 基于 TyranoScript V5 引擎的视觉小说游戏《恶魔连结》的浏览器移植版本，集成浏览器端模组加载器。
>
> 原作为 Electron + Steamworks 桌面版，本 Fork 通过浏览器适配层使其可在普通浏览器中运行，并支持 DCML 规范的 `.asar` 模组加载。
>
> Fork 自 [lllhhh2282/devilconnection-web](https://github.com/lllhhh2282/devilconnection-web)（已归档），感谢原作者的移植工作。

---

## 在线体验

🔗 **https://lateralcircle83.github.io/devilconnection-web/**

> ⚠️ 游戏资源体积较大，首次加载可能较慢。

---

## 特性

- **浏览器原生运行** — 无需 Electron、Node.js，任意静态文件服务器即可
- **模组加载器** — 支持 DCML 规范 `.asar` 模组，资源透明映射
- **模组工坊** — 内置模组入口管理页面
- **配置界面** — 根据 `config.schema.json` 自动生成配置表单
- **本地加载** — 支持从本机临时加载 `.asar` 文件测试
- **简体中文汉化** — 内置全剧本翻译、汉化视频与 UI 资源
- **全平台** — 桌面端 + 手机端触屏适配

## 快速开始

```bash
npm install
npm run serve
# 浏览器打开 http://localhost:3000
```

启动后可在模组选择页勾选要加载的模组，点「开始游戏」进入。

## 目录结构

```
├── index.html              # 浏览器渲染入口（模组选择 + 启动）
├── Modloader/              # 模组加载系统
├── BrowserShell/           # 浏览器壳子 / 原 Electron preload 替代层
├── mods/                   # 模组目录（.asar 文件 + mods.json 索引）
├── tool/                   # 本地开发/自检脚本
├── data/                   # 游戏内容资源
├── tyrano/                 # TyranoScript 引擎
└── _electron_legacy/       # 旧 Electron 桌面封装（参考）
```

## 开发与自检

细节文档按所有权拆分，避免同一事实散落多处：

- [`Modloader/README.md`](Modloader/README.md)：模组加载器边界、约束与验证清单
- [`tool/README.md`](tool/README.md)：本地工具与 DevTools 调试入口
- [`AGENTS.md`](AGENTS.md)：给 AI agent 的项目结构、运行时事实与维护约定

```bash
npm run check
```

## 模组

模组规格遵循 [DCML Rebuild 规范](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader/blob/main/ModsUsage.md)。

## 模组加载方式

1. **服务端模组**：将 `.asar` 放入 `mods/` 目录，在 `mods/mods.json` 注册，页面刷新后出现在模组列表
2. **本地加载**：在模组选择页点「+ 加载本地 ASAR」，选择 `.asar` 文件临时加载（刷新后消失）

当前内置模组列表以 [`mods/mods.json`](mods/mods.json) 为准。模组加载器参考自 [DevilConnection_ModLoader (Rebuild)](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader)，模组开发请遵循 [DCML Rebuild 规范](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader/blob/main/ModsUsage.md)。加密模组（`DC_ENC_v1`）排查工具见 [`tool/README.md`](tool/README.md)。

## 许可证与声明

- 本项目为《恶魔连结》的浏览器移植版本。
- **请支持正版游戏**，通过 [Steam](https://store.steampowered.com/app/3054820/_/) 等正规渠道购买《恶魔连结》。
- `tyrano/` 目录包含 TyranoScript 引擎相关文件，`data/` 目录包含游戏原始资源与剧本。具体授权与使用范围请参考原作及引擎许可协议。
- 简体中文汉化资源来自古今狐白日语社《恶魔连结》Ver1.01 汉化补丁。
- 模组文件（`mods/*.asar`）版权归各自作者所有。
