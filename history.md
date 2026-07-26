# 开发日志

## 2026-07-22

### 新增：模组加载器 (`mod_loader.js`)
- ASAR 文件解析（兼容 DCML 格式）
- 文件索引建立，路径映射
- 拦截 `$.loadText` / `$.loadQueue`，透明重定向到 ASAR 内资源
- `hook.js` 注入执行
- 模组选择 UI（替代原有的"点击开始"页面）

### 新增：Electron API 兼容层 (`mod_compat.js`)
- `electronAPI` / `require('fs')` / `require('path')` shim
- `existsSync` / `readFileSync` / `writeFileSync` 映射到 `localStorage`

### 新增：模组配置 UI
- 模组列表的 `⚙ 配置` 按钮
- 支持 ASAR 内 `config.schema.json` 读取
- 根据 schema 动态渲染表单（文本框、开关、密码框等）
- 配置保存到 `localStorage`

### 修复：`prefetchScenarios` 动态表达式误 fetch
- `kag.js` — 跳过以 `&`（运行时表达式）和 `%`（宏参数）开头的 storage 值
- 避免未求值的模板字面量（如 `` &`${f.backStorage}.ks` ``）被当作 URL 请求

### 修复：`prefetchScenarios` 预加载 404 噪声
- `kag.js` — 改用 `fetch` 直接加载，404 时静默忽略
- 避免缺失的 `replay.ks` 等文件不断刷控制台错误

### 修复：`apng.js` `close()` 错误
- `apng.js:5` — `close()` 在 Web Worker 中正常，但被当作普通脚本加载时调用 `window.close()` 触发浏览器安全警告
- 用 `typeof importScripts` 隔离 Worker 代码块

### 新增：资源拦截
- `$.loadText`：直接从 ASAR 读取文本数据，绕过 blob URL 创建+fetch 的多余路径
- `fetch()` + `XMLHttpRequest`：全局 HTTP 拦截，通杀所有文件类型
  - 修复：`fetch` override 中误将 blob URL 字符串做响应体，导致 `prefetchScenarios` 缓存脏数据
- `<img src>`：截获属性赋值、setAttribute、innerHTML、createElement、new Image()
- CSS `background-image`：截获 `$.fn.css()` + `CSSStyleDeclaration.setProperty()`
- `new Audio(url)`：截获 Audio 构造函数
- 执行顺序调为先挂拦截器、后执行 hook.js，确保模组创建的资源被捕获

### 修复：配置按钮 `esc is not defined`
- `esc` 函数移到 `DOMContentLoaded` 外部，全局可访问

### 修复：`fetch` override 响应体错误
- `new Response(blobUrl)` 把 blob URL 字符串当响应体，导致预缓存写入脏数据
- 改为 `_origFetch(blobUrl)` 正确获取 blob 的实际内容

### 修复：多模组加载时只有最后一个 hook.js 被执行
- 原因是 `fileIndex` 中同路径互相覆盖，`readFileData('hook.js')` 只返回最后一个
- 改为遍历每个 ASAR 自己的文件列表独立执行 hook.js
- 数据文件仍保持后加载优先覆盖规则
- 改用 `http-server` 替代 `serve` 包解决 Windows 兼容问题

### 修复：配置按钮总是弹出最后一个模组的对话框
- `ModLoader.getFileJSON('config.schema.json')` 读取合并索引，永远返回最后一个
- 改为每个模组独立抓自己的 ASAR 解析 schema
- 本地模组从已加载的文件索引读取

### 新增：本地 ASAR 文件加载
- 模组选择页新增「+ 加载本地 ASAR」按钮
- 通过浏览器文件选择器读取 `.asar` 文件，实时解析并加入模组列表
- 支持 hook.js 执行和资源拦截（和正常模组一致）
- 页面刷新后消失（仅内存中生效），适合临时测试

### 重构：ASAR 解析逻辑
- 提取 `parseAndIndex(buffer)` 方法，供 `loadAsar`（远程）和本地加载共用

### 模组打包
- 将 `dc_theatre` 解包目录重新打包为 `dc_theatre.asar`（1.39 MB）

## 2026-07-25

### 改进：Remodal 对话框随游戏画面等比缩放
- `libs.js` — 打开弹窗前将 `.remodal` 用 `.remodal-scaled` 包裹，应用 `transform: scale(base_scale)`，使弹窗与游戏画面同比例缩放
- 居中方式从 `vertical-align:middle` 改为 `position:absolute; left:50%; top:50%; translate(-50%,-50%)`，避免布局盒子与缩放视觉的中心错位
- 弹窗打开时 `.remodal-wrapper` 高度设为 `window.innerHeight`，关闭时还原，解决移动端浏览器地址栏导致的居中偏移
- 缩放层在 `closed` 事件（关闭动画完成后）自动 unwrap，不影响下次打开

### 改进：mod_loader 空 catch 增加调试日志
- 为 `wireInterceptors` 中 8 处拦截器 patch 添加 `window.__MOD_DEBUG__` 保护的调试日志
- `parseAndIndex` 元数据解析失败和 `setModConfig` 写入失败时输出 `console.warn`

## 2026-07-26

### 新增：简体中文汉化资源
- 替换 `data/scenario/` 全部 100+ 个剧本文件为简体中文翻译版
- 替换 `data/scenario/system/` 全部系统剧本为简体中文翻译版
- 替换 `data/video/*.mp4`（7 个）为汉化版标题/开场/结局视频
- 替换 `data/bgimage/`、`data/fgimage/`、`data/image/` 相关汉化媒体资源
- 替换 `data/others/` 中文字体及适配 JS 插件
- 替换 `tyrano/lang.js` 汉化文本串
- 替换 `logo.png` 汉化版 Logo
- 汉化来源：古今狐白日语社《恶魔连结》Ver1.01 汉化补丁

### 适配：汉化资源配置调整
- `data/system/Config.tjs`：保留移植版 `configSave=webstorage`（汉化合集原为 `file`）
- `data/scenario/title_screen.ks`：补回 `TYRANO.hideLoadingOverlay()` 调用（汉化合集遗漏）
- 引擎文件 `kag.tag.js`、`kag.menu.js`、`tyrano.css` 等保持原版不变（汉化合集去除了预加载保护，移植版更稳定）

### 模组加载器
- 模组加载器参考自 [DevilConnection_ModLoader (Rebuild)](https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader)
- 支持正版游戏《恶魔连结》(DevilConnection)，请通过 Steam 等正规渠道购买游戏
