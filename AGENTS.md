# AGENTS.md — DevilConnection Browser Port

> This document is written for AI coding agents who have no prior knowledge of the project. It describes the actual structure, technology stack, runtime behavior, and development conventions observed in the source tree.

## Project overview

This repository is a **browser port of the visual novel *DevilConnection* (恶魔连结 / デビルコネクション)**. It is built on top of the **TyranoScript** visual novel engine (KAG format) and runs as a static HTML5 application in a web browser.

The repository name in `package.json` is `devil-connection-browser`. The original project used Electron + Steamworks; the current browser version replaces the native preload APIs with a browser shim so the same TyranoScript assets can run without Electron or Node.js.

Key facts:

- **No build step is required** to run the game in a browser.
- **No server-side component** exists.
- All game logic is written in TyranoScript scenario files (`.ks`) and vanilla JavaScript.
- The game is intended to be served as static files (`index.html`, `BrowserShell/`, `Modloader/`, `mods/`, `data/`, `tyrano/`).

## Technology stack

- **Frontend runtime**: HTML5, CSS, vanilla JavaScript (ES5-style IIFE modules), jQuery 3.6.0, jQuery UI, jQuery Migrate.
- **Visual novel engine**: TyranoScript (KAG script format, `*.ks`).
- **Audio**: Howler.js + HTML5 `<audio>` for autoplay policy handling.
- **Dialogs / overlays**: SweetAlert2, Remodal, Alertify.js (legacy).
- **Utilities**: JSZip, html2canvas, jsrender, LZString, jsQR, APNG support (`apng.js`, `blob.js`).
- **3D support (mostly unused)**: Three.js and its loaders (the config has `use3D=false`).
- **Text effects**: textillate, animate.css, lettering.js, touchSwipe.
- **Node usage**: local static serving, lightweight checks, and ASAR helper scripts; no bundler, transpiler, or test framework is present.
- **Legacy native shell**: `_electron_legacy/` contains the original Electron main/preload/Steam integration, but the current `index.html` does not load it.

## Key configuration files

| File | Purpose |
|------|---------|
| `package.json` | Project metadata. Defines `scripts.serve` and lightweight local checks such as `check`. |
| `index.html` | Entry point. Loads browser shell, shared libraries, ModLoader, and manager UI. Tyrano engine scripts are loaded dynamically after the user starts the game. |
| `data/system/Config.tjs` | TyranoScript game configuration (screen size, text speed, default volumes, save settings, etc.). Generated/managed by TyranoBuilder. |
| `data/system/KeyConfig.js` | Keyboard/mouse/gesture bindings for the game. |
| `tyrano/lang.js` | In-game text strings. The current file contains Simplified Chinese UI text (with some Japanese names) for this port. |
| `data/scenario/first.ks` | First scenario loaded by TyranoScript after initialization. It loads system macros and jumps to `title_screen.ks`. |
| `BrowserShell/browser_api.js` | Browser-only `window.api` shim (file system, storage, dialogs, fullscreen, etc.). |
| `BrowserShell/electron_latest.js` | Browser adaptation overrides for TyranoScript core behavior (save integration, patch disabling, `web`/`close` tags). |

## Directory layout

```
.
├── index.html              # Application entry point
├── package.json            # Minimal Node metadata / serve script
├── BrowserShell/           # Browser shell / Electron preload replacement
│   ├── browser_api.js      # Browser shim for Electron preload APIs
│   └── electron_latest.js  # Tyrano runtime browser patches
├── tool/                   # Local development and inspection scripts
│   ├── README.md           # Tool usage notes and runtime debug entrypoints
│   ├── modloader_self_check.mjs
│   ├── check_css.mjs
│   ├── pack.mjs
│   └── decrypt.js
├── favicon.ico
├── data/                   # Game assets and scripts
│   ├── bgimage/            # Background images
│   ├── fgimage/            # Foreground / character images
│   ├── image/              # UI / misc images
│   ├── sound/              # Sound effects
│   ├── bgm/                # Background music
│   ├── video/              # Movies
│   ├── others/             # Custom JavaScript, plugins, and game data
│   │   ├── plugin/         # TyranoBuilder-style plugins (init.ks + JS)
│   │   └── *.js            # Game-specific helpers (master_data, loading overlay, etc.)
│   ├── scenario/           # Main KAG scenario files
│   │   ├── system/         # System macros and auto-generated backups (`_*.ks`)
│   │   └── *.ks            # Story scripts
│   └── system/             # Tyrano system files (Config.tjs, KeyConfig.js)
├── tyrano/                 # TyranoScript engine
│   ├── tyrano.js           # Core bootstrap
│   ├── tyrano.base.js      # Base layer / screen scaling
│   ├── libs.js             # jQuery / utility extensions
│   ├── lang.js             # In-game strings
│   ├── libs/               # Third-party libraries
│   ├── plugins/kag/        # KAG engine plugin (kag.js, tags, parser, menu, etc.)
│   ├── css/                # Engine styles
│   └── images/             # Engine default images
└── _electron_legacy/       # Original Electron + Steamworks files (not used by browser build)
```

## Documentation ownership

- `README.md` is the human-facing project entrypoint. Keep it short and link to
  owner documents instead of duplicating tool lists, mod lists, or runtime API
  details.
- `AGENTS.md` is the agent-facing map of architecture, runtime facts, and
  maintenance conventions.
- `Modloader/README.md` owns ModLoader boundaries, invariants, and loader
  verification.
- `tool/README.md` owns local tool descriptions and DevTools debug entrypoints.
- `mods/mods.json` owns the current built-in mod list.

When changing a detail, update the owning document first and keep other files
as pointers unless they need a short warning for agent safety.

## Runtime architecture

1. The browser loads `index.html`.
2. `BrowserShell/browser_api.js` runs first and creates `window.api`, a browser-compatible replacement for the Electron preload API (storage, file dialogs, fullscreen, etc.).
3. Core libraries (jQuery, jQuery UI, Howler, SweetAlert2, etc.), `Modloader/mod_compat.js`, `Modloader/mod_loader.js`, and `Modloader/manager.js` are loaded.
4. The user chooses mods and clicks the manager start button. `ModLoader.init(selectedIds)` loads selected ASARs, wires resource interceptors, and executes mod hooks.
5. `Modloader/manager.js` dynamically loads Tyrano engine scripts in order, then loads `BrowserShell/electron_latest.js`.
6. `BrowserShell/electron_latest.js` patches Tyrano core methods for the browser:
   - Forces `configSave = 'webstorage'` so saves use the browser shim.
   - Disables patch application and web-patch checks.
   - Overrides the `web`, `close`, and `check_web_patch` KAG tags.
   - Hooks `TYRANO.init` so IndexedDB storage is ready before the game starts.
7. The manager overlay is removed, browser autoplay state is nudged/resumed, and `TYRANO.init()` is called.
8. `TYRANO.init()` loads the `kag` plugin, which reads `data/system/Config.tjs` and starts `data/scenario/first.ks`.
9. `first.ks` loads system macros (`system/tyrano.ks`, `system/builder.ks`, `system/chara_define.ks`), sets up the message window, loads plugins, and jumps to `title_screen.ks`.

### Save / storage system

- The browser version stores save data in **IndexedDB** (`tyrano_browser_storage` / `kv`) via `window.api.storage`.
- IndexedDB is loaded into memory at startup; writes are flushed asynchronously on a short timer and on `beforeunload` / `pagehide` / `visibilitychange`.
- Pending writes carry per-key revisions and are acknowledged only after the IndexedDB transaction completes. Failed transactions retain the batch for a later retry and show a one-time recovery warning; fire-and-forget flushes must always handle rejection.
- If IndexedDB is unavailable, it falls back to `localStorage`.
- On first run, existing `localStorage` save keys are migrated into IndexedDB.
- Save data is JSON-encoded and percent-encoded (matching the Steam/Electron `.sav` format). Readers also accept raw JSON, legacy `escape` encoding, and LZString-compressed variants, then normalize them to the active storage mode. A key is treated as corrupt only after every supported representation fails; corrupt keys are isolated/removed and the user is asked before clearing all storage.
- Manager save export, import, and clear operations are restricted to `DevilConnection_*` plus the standalone `NEO` progress key. They must not operate on `mod_config_*`, `_tyrano_browser_*`, or unrelated same-origin storage, including in the `localStorage` fallback.
- `window.api.decodeSaveData(raw)` is the shared side-effect-free decoder used by
  Tyrano runtime reads and manager ZIP imports.
- Manager save actions wait for `storage.ready`. ZIP imports validate all
  recognized entries and reject duplicate keys before overwriting; a failed
  flush restores the pre-import values through the same storage layer.

## Browser port layer

The two files that make the browser port possible are:

- **`BrowserShell/browser_api.js`**: Implements the `window.api` contract expected by the Tyrano engine. Includes file-system shims, save-file download (`saveFile`), dialog shims, fullscreen, and the IndexedDB-backed `storage` object.
- **`BrowserShell/electron_latest.js`**: Implements Tyrano runtime behavior that differs between Electron and the browser. It overrides `kag.init`, `checkUpdate`, `applyPatch`, and several KAG tags, and extends jQuery with browser-compatible storage helpers.

Both files are written as immediately-invoked function expressions (IIFE) so they can be loaded as plain `<script>` tags. They rely on globals such as `jQuery`, `TYRANO`, `Howler`, `Swal`, and `LZString`.

## Legacy Electron / Steam build

The `_electron_legacy/` directory contains the original native shell:

- `main.js` — Electron main process (obfuscated/minified). Handles window creation, IPC, file I/O, encryption, patch application, and Steamworks integration.
- `preload.js` — Exposes the native `window.api` to the renderer.
- `steam.js` — Initializes the Steamworks client with a hardcoded Steam App ID.

The current `index.html` does **not** reference these files. They are kept for reference or for producing a future Electron build.

## Build and run commands

```bash
# Serve the project as static files (uses `serve` via npx)
npm run serve
```

Because the project is static, any static file server works. For example:

```bash
npx serve .
# or
python3 -m http.server 3000
```

There is **no production build**, **no bundler**, and **no transpilation step**.

## Local tools

The source of truth for local scripts is `tool/README.md`. The most common
local verification command is:

```bash
npm run check
```

## Development conventions

### Scenario scripts (`.ks`)

- TyranoScript commands are written in KAG format: `[command param=value]` or `@command param=value`.
- Comments start with a semicolon: `; this is a comment`.
- Labels use `*label_name`.
- Macros are defined with `[macro name=...] ... [endmacro]` and are typically placed under `data/scenario/system/`.
- JavaScript embedded in a scenario uses `[iscript] ... [endscript]`.
- `data/scenario/system/_*.ks` files appear to be auto-generated backup / preview copies of the main scenario files.

### Custom plugins (`data/others/plugin/`)

- Most plugins contain an `init.ks` that defines KAG macros or loads a JS file, plus a `main.js` that registers custom tags on `TYRANO.kag.ftag.master_tag`.
- Some plugins also contain a `*.builder.js` file. These are TyranoBuilder component definitions written as CommonJS modules exporting a `plugin_setting` class.

### JavaScript style

- Engine and shim code uses ES5-style function declarations, `var`, and IIFEs.
- `let`/`const` appear only in newer shim code (`BrowserShell/browser_api.js`, `BrowserShell/electron_latest.js`).
- Global namespaces are heavily used: `TYRANO`, `TYRANO.kag`, `TYRANO.kag.ftag`, `TYRANO.kag.variable.sf/tf`, `jQuery` (`$`).
- File paths in the browser are resolved relative to `location.href` via `getBasePath()` in `BrowserShell/browser_api.js`.

### Assets

- Image/audio/video paths referenced from KAG are relative to `data/` (e.g. `storage="image/menu/op.png"` resolves to `data/image/menu/op.png`).
- Default media format is configured as `ogg` in `Config.tjs`.
- Screen design size is `1280x960` with `ScreenRatio=fix` and `ScreenCentering=true`.

## Testing / debugging

- There is **no automated test suite** (no Jest, Mocha, Vitest, Cypress, etc.).
- `npm run check` is the main lightweight local verification command. Use
  `npm run check:modloader` for a focused ModLoader regression loop.
- Manual testing is done by running the game in a browser and exercising the scenario flow.
- Runtime debug entrypoints are documented in `tool/README.md`.
- The root `data/others/debug_menu.js` is currently a legacy/reference copy; the
  active debug menu is packaged in `mods/dc_debug.asar`.
- ModLoader-specific invariants and verification steps are documented in
  `Modloader/README.md`.
- `BrowserShell/browser_api.js` keeps Electron debug-related methods such as
  `toggleDevTools`, `readSubDir`, `captureWindow`, and `registerHotKey` as
  browser no-ops for compatibility; do not rely on them for real debugging.
- `data/scenario/tester.ks` and files prefixed with `AAAA_` or `_AAAA_` appear to be debug / scratch scenarios.
- To inspect runtime state, use the browser DevTools and look at globals such as `TYRANO.kag.variable.sf`, `TYRANO.kag.stat`, and `TG`.

## Deployment

Deploy the following as static files:

```
index.html
favicon.ico
BrowserShell/
Modloader/
mods/
data/
tyrano/
```

Notes for deployment:

- The server must serve `.ks` files with a text MIME type (or the browser will still load them as text because they are fetched with `fetch` / `$.loadText`).
- Audio files (`.ogg`) must be served with the correct audio MIME type.
- The game does not require any backend API.
- Make sure autoplay policy is satisfied by the click-to-start overlay; do not remove `#tyrano_click_to_start`.

## Mod system (browser mod loader)

This fork adds a browser-based mod loader that supports DCML-compatible `.asar` mod packages.

### Mod specification reference

The mod format and development conventions follow the **DevilConnection ModLoader (DCML) Rebuild** specification:
- Full spec: https://github.com/Luoyu-Wangchai/DevilConnection_ModLoader/blob/main/ModsUsage.md
- Mods are `.asar` packages placed in `mods/` directory
- Each mod can contain `mods.json` (metadata), `hook.js` (runtime injection), `config.schema.json` (config UI), and `data/` (resource overrides)
- `hook.js` runs in the renderer context with `window.electronAPI` shimmed via `Modloader/mod_compat.js`
- Config is stored in `localStorage.mod_config_<id>`, mapped from `plugins/config/<id>.json` paths

### Key files

| File | Purpose |
|------|---------|
| `Modloader/mod_loader.js` | ASAR parser, file index, resource interception (fetch/XHR/img/CSS/Audio/loadText/loadQueue) |
| `Modloader/mod_compat.js` | Electron API shim for mod hook.js (`electronAPI`, `require('fs')`, `require('path')`, `Buffer`) |
| `mods/mods.json` | Mod index (id, name, file path) |
| `mods/*.asar` | Mod packages |

## Security considerations

- The game executes JavaScript from `[iscript]` blocks in scenario files and from arbitrary `.js` files loaded via `[loadjs]`. Treat all `.ks` and `.js` content as trusted.
- There is no Content Security Policy defined in `index.html`.
- `BrowserShell/browser_api.js` uses `fetch` to load binary/text resources and `document.createElement('a')` with `.download` for photo export. Paths are resolved relative to the page URL.
- Save data is stored in the client’s IndexedDB / localStorage. The browser shim validates JSON on read, isolates corrupt keys, and asks the user before clearing all storage.
- The original Electron build uses `shell.openExternal`, native dialogs, file I/O, and Steamworks; do not enable those paths in the browser build.
- Patch application (`applyPatch`) is explicitly disabled in the browser build to prevent arbitrary file extraction.
