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
├── mod_loader.js           # 模组加载器（ASAR 解析、资源拦截、DCML API）
├── mod_compat.js           # Electron API 兼容层（fs/path/Buffer/electronAPI）
├── browser_api.js          # 浏览器版 API shim
├── electron_latest.js      # 浏览器适配层
│
├── mods/                   # 模组目录（.asar 文件 + mods.json 索引）
├── data/                   # 游戏内容资源
├── tyrano/                 # TyranoScript 引擎
└── _electron_legacy/       # 旧 Electron 桌面封装（参考）
```

## 模组

模组规格遵循 [DCML Rebuild 规范](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader/blob/main/ModsUsage.md)。

### 内置模组

| 模组 | 说明 | 来源 |
|------|------|------|
| 库啪哒呀小剧场 (`dc_theatre`) | AI 驱动的即兴对话剧场 | [Luoyu-Wangchai/DevilConnection_Theatre](https://github.com/Luoyu-Wangchai/DevilConnection_Theatre) |
| 库皮亚交互增强 (`dc_kupya_plus`) | 后日谈库皮亚新增台词与书架互动 | [Luoyu-Wangchai/DevilConnection_KupyaPlus](https://github.com/Luoyu-Wangchai/DevilConnection_KupyaPlus) |
| 更多二世多艾露 (`dc_doeru_plus`) | 二世多艾露专属剧情 | [Luoyu-Wangchai/DevilConnection_DoeruPlus](https://github.com/Luoyu-Wangchai/DevilConnection_DoeruPlus) |
| DC Toolbox (`dc_toolbox`) | 游戏内调试工具（数值编辑、收藏解锁、变速等） | DCML 社区 |
| 模组工坊 (`dc_modworkshop`) | 模组入口统一管理界面 | DCML 内置 |

## 模组加载方式

1. **服务端模组**：将 `.asar` 放入 `mods/` 目录，在 `mods/mods.json` 注册，页面刷新后出现在模组列表
2. **本地加载**：在模组选择页点「+ 加载本地 ASAR」，选择 `.asar` 文件临时加载（刷新后消失）

模组加载器参考自 [DevilConnection_ModLoader (Rebuild)](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader)，模组开发请遵循 [DCML Rebuild 规范](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader/blob/main/ModsUsage.md)。加密模组（`DC_ENC_v1`）可用 `解密/decrypt.js` 解密。

## 许可证与声明

- 本项目为《恶魔连结》的浏览器移植版本。
- **请支持正版游戏**，通过 [Steam](https://store.steampowered.com/app/3054820/_/) 等正规渠道购买《恶魔连结》。
- `tyrano/` 目录包含 TyranoScript 引擎相关文件，`data/` 目录包含游戏原始资源与剧本。具体授权与使用范围请参考原作及引擎许可协议。
- 简体中文汉化资源来自古今狐白日语社《恶魔连结》Ver1.01 汉化补丁。
- 模组文件（`mods/*.asar`）版权归各自作者所有。
