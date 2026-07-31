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

## 2026-07-26（后续）

### 新增：资源拦截扩展
- `setAttribute`：VIDEO/SCRIPT 的 `src` 和 LINK 的 `href` 加入拦截
- `wireVideoInterceptor`：拦截 `video.src = url` 直接属性赋值
- `wireScriptInterceptor`：拦截 `script.src = url`
- `wireLinkInterceptor`：拦截 `link.href = url`
- `createElement`：video/script/link 创建时绑定对应拦截器
- 至此 mod_loader 支持拦截所有主流资源加载方式：img、video、audio、script、link、fetch、XHR、CSS

### 重构：引擎文件改为动态加载
- 移除 `index.html` 中全部引擎 `<script>` 标签，改为 `ModLoader.init()` 成功后通过 `loadEngine()` 顺序动态创建
- `wireScriptInterceptor` 可在引擎文件加载前就绪，模组可覆盖任意引擎 JS 文件
- 新增 `$.isElectron` 垫片（静态加载的 touchSwipe 在 libs.js 动态加载前需要此函数）
- `$.loadQueue` 拦截器增加守卫，防止引擎文件未加载时调用 undefined

### 修复：$.loadQueue 拦截器
- 引擎文件改为动态加载后，`$.loadQueue` 在拦截器安装时可能尚未定义
- 添加 `typeof _origLoadQueue === 'function'` 守卫，避免 `undefined.call()` 报错

## 2026-07-29

### 修复：file input 导致存档报错 InvalidStateError
- UI 改版后页面上存在 `<input type="file">`（ASAR 加载 + 存档导入）
- 引擎 `kag.menu.js:819` 的 `$('input').val(inputVal)` 遍历所有 input 恢复值
- 浏览器禁止程序化修改 file input 的值（只能清空），抛出 `InvalidStateError`
- 错误导致 `mpGauge.unwrap()` 等清理代码不执行，MP 包裹层残留在 DOM 中
- 修复：patch `$.fn.val` 跳过滤 `type=file` 的元素

### 修复：动态加载时序导致 file input 残留于 DOM
- 动态加载期间覆盖层尚未移除，file input 在存档时仍存在
- `finishStart()` 移除整个覆盖层后 file input 随之消失，问题彻底解决

### 修复：$.getScript 拦截盲区
- jQuery 在 `mod_loader.js` 执行前就缓存了 `document.createElement`
- `wireScriptInterceptor` 无法拦截 `$.getScript` 内部创建的 `<script>` 元素
- 引擎 `@loadjs` 标签走 `$.getScript`，模组无法替换加载的 JS 文件
- 修复：直接 hook `$.getScript` 顶层 API，用 `$.ajax({ cache: true })` 加载 blob URL
- 同时避免 jQuery 自动添加 `?_=timestamp` 破坏 data/blob URL 的问题

### 修复：createBlobURL 未处理 query string
- `createBlobURL` 直接拿带 `?v=timestamp` 的路径查 fileIndex，查不到
- 修复：在 `createBlobURL` 入口处剥离 query string

### 新增：虚拟成就系统模组
- 解密 `虚拟成就.asar` 并重打包为 `dc_achievement.asar`
- 替换原版 TyranoSteamworks（浏览器中为无操作空壳），提供 Steam 风格成就弹窗
- 成就通过 `[steam_achievement_activate name="XXX"]` 触发
- 图标存于 `data/image/steam/`

## 2026-07-31

### 修复：模组读取与 hook 兼容暗病
- `ModLoader.readFile()` 只返回目标 ASAR entry 的 `ArrayBuffer`，避免泄露整个底层 ASAR buffer
- `hook.js` 执行期间的 `window.electronAPI` 改为指向 `window.ModCompat.electronAPI`
- 为 `innerHTML` 拦截补充注释，说明只覆盖 setter 时原生 getter 会被保留

### 加固：ASAR parser 与模组初始化流程
- ASAR header 改为按头部 JSON 长度字段读取，不再扫描裸 `{}` 匹配
- 校验每个 entry 的 `offset/size` 为有限非负整数，并跳过越界条目
- 新增 `readAsarFileText()` / `readAsarFileJSON()` 公共读取方法
- 模组配置弹窗复用 `ModLoader` 的公共 ASAR parser，不再复制一套解析逻辑
- `wireInterceptors()` 增加一次性 guard，避免重复包裹全局拦截器
- `ModLoader.init()` 增加幂等保护和状态清理，避免重复初始化导致索引、hook、blob URL 污染

### 修复：存档导入与坏存档处理
- 存档 ZIP 导入等待所有 `.sav` 异步写入完成后再提示结果
- 导入完成后显式调用 `storage.flush()`，降低慢机器或立即关页时丢写入的风险
- JSON 校验失败时只隔离损坏 key，不再直接清空全部 IndexedDB / localStorage
- 损坏存档提示改为让用户选择是否清除全部存储

### 修复：标题循环 MediaSource 偶发 InvalidStateError
- 标题/背景循环视频追加 `SourceBuffer` 前检查 `updating` 状态
- 当浏览器仍在处理上一次 append/remove 时，延迟到 `updateend` 后再追加
- teardown 时标记 MediaSource 已结束，避免 pending append 在释放后继续写入

### 改进：本地 ASAR 模组导入行为
- 本地导入 ASAR 后重绘模组列表时保留当前勾选状态，避免已取消的内置模组被重新勾选
- 同 `id` 的本地 ASAR 在当前页面会话内替换列表中的旧条目，刷新后仍恢复内置模组列表
- `ModLoader.init()` 加载同 `id` 模组时优先使用本地导入 buffer，使本地 ASAR 可按同一套排序规则覆盖内置模组
- 模组配置按钮改为事件绑定并转义 `data-id`，避免模组名或 id 中的特殊字符破坏 inline handler

### 改进：模组资源路径归一化
- `ModLoader` 统一将同源绝对 URL、根路径 URL、相对路径归一为 ASAR 内相对路径
- 集中处理 `?query` / `#hash` 后缀，保留并扩展旧的 `?_=timestamp` 兼容
- `createBlobURL()` / `readFileData()` / `resolveURL()` 统一走 `normalizeAsarPath()`，移除拦截器内重复的 query stripping 和 `./data` fallback 分支
- 跨源 URL、`blob:`、`data:`、`javascript:` 不参与 ASAR 匹配，避免误拦截外部资源

### 修复：ASAR JSON 与存储清理细节
- ASAR header、`mods.json`、`config.schema.json` 等 JSON 解析前剥离 UTF-8 BOM，兼容带 BOM 的模组元数据
- `browser_api.js` 的 `storage.clear()` 返回 Promise，并等待 IndexedDB `clear()` 事务完成
- 全清存储前取消 pending flush timer，避免清理后旧 pending 写入再次落盘
- 坏存档提示中的“清除全部存储”改为等待清理完成后再提示用户
- 管理器的“清除全部存档”在提示完成前显式等待 `storage.flush()`

### 轻量缓解：字体加载 fallback 警告
- 为 `tyrano/css/font.css` 中的 `@font-face` 添加 `font-display: swap`
- 仅声明浏览器可先显示 fallback 字体、字体加载完成后再替换，不改变字体文件、预加载脚本或资源路径
- 格式化 `font.css`，方便后续继续评估 WOFF2 / 字体子集化 / 标题页 preload 精简
