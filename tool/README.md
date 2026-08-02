# Development Tools

This directory contains small local scripts for inspecting or preparing the
browser port. They are not part of the deployed static game.

## Scripts

For day-to-day verification, prefer the aggregate command:

```bash
npm run check
```

It runs syntax checks, the CSS selector sanity check, and the focused VM
self-checks below. Run an individual script only when narrowing down a failure.

| Script | Command | Purpose |
|--------|---------|---------|
| `startup_self_check.mjs` | `npm run check:startup` | Runs BrowserShell storage fallback and manager startup failure checks in one small VM harness. Use `node tool/startup_self_check.mjs browser-shell` or `node tool/startup_self_check.mjs manager` for a single suite. |
| `modloader_self_check.mjs` | `npm run check:modloader` | Runs the real `Modloader/mod_loader.js` inside a small browser-like VM harness and checks ASAR path normalization, offset/size validation, repeated `init()`, and interceptor semantic preservation. |
| `check_css.mjs` | `node tool/check_css.mjs` | Checks whether classes used directly in `index.html` have matching selectors in `Modloader/manager.css`. This is only a rough UI sanity check. |
| `pack.mjs` | `node tool/pack.mjs <input-dir> <output.asar>` | Packs a directory into a simple ASAR file for local ModLoader testing. It does not encrypt or sign the package. |
| `decrypt.js` | `node tool/decrypt.js <mod.asar> [output-dir]` | Offline helper for AI agents/maintainers to inspect encrypted `DC_ENC_v1` ASAR mods that contain the expected `.env` metadata. Use only on trusted local files. |

## Runtime Debug Entrypoints

These helpers exist in the browser runtime and are useful from DevTools:

- `TYRANO.debugMenu.show()` / `TYRANO.debugMenu.hide()` when the `dc_debug`
  mod has loaded and injected its bundled debug menu.
- `TYRANO.showDebugMenu()`, `TYRANO.hideDebugMenu()`,
  `TYRANO.reloadDebugMenu()`, and `TYRANO.updateGlobalDebugButton()` are also
  defined by that debug menu.
- `ModLoader.hasFile(path)`, `ModLoader.resolveURL(path)`,
  `ModLoader.getFileIndex()`, `ModLoader.getFileText(path)`, and
  `ModLoader.getFileJSON(path)` are useful for checking active mod overrides.
- `ModLoader.readAsarMeta(buffer)`, `ModLoader.readAsarFileText(buffer, path)`,
  and `ModLoader.readAsarFileJSON(buffer, path)` parse an ASAR buffer without
  mutating the active loader state.
- Set `window.__MOD_DEBUG__ = true` before `Modloader/mod_loader.js` loads to
  enable extra interceptor warning logs.

`BrowserShell/browser_api.js` also exposes Electron compatibility methods such
as `toggleDevTools`, `readSubDir`, `captureWindow`, and `registerHotKey`, but
those are browser no-ops kept for compatibility rather than real debug tools.

`data/others/debug_menu.js` is currently a legacy/reference copy. The core
localized scenario flow does not load it directly; the active debug menu entry
is packaged in `mods/dc_debug.asar`.
