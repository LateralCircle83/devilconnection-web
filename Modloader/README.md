# ModLoader maintenance notes

This directory contains the browser DCML compatibility layer. Keep changes small
and place new compatibility code at the boundary that owns it.

## Load order

`index.html` loads the browser shell first, then the mod layer:

1. `BrowserShell/browser_api.js` creates the browser `window.api` shim.
2. `Modloader/mod_compat.js` creates `window.ModCompat` for DCML hooks.
3. `Modloader/mod_loader.js` parses ASAR files, indexes overrides, installs
   resource interceptors, and exposes `window.ModLoader`.
4. `Modloader/Sortable.min.js` and `Modloader/markdown_viewer.js` provide
   local UI helpers for mod ordering and README rendering.
5. `Modloader/manager.js` renders the selection/config UI and calls
   `ModLoader.init(selectedIds)`.
6. The Tyrano engine scripts and `BrowserShell/electron_latest.js` are loaded
   after the user starts the game.

## File boundaries

`mod_loader.js`

- Owns ASAR parsing, file indexing, path normalization, resource interception,
  hook execution, and the public `window.ModLoader` API.
- Does not render UI, persist mod selection, or implement generic Electron APIs.

`mod_compat.js`

- Owns the minimal Electron preload / Node compatibility surface used by
  `hook.js`: `electronAPI`, `require('fs')`, `require('path')`, `Buffer`, and
  `process`.
- Maps DCML config paths such as `plugins/config/<id>.json` to
  `localStorage.mod_config_<id>`.
- Is not a general filesystem implementation; add only APIs that real mods need.

`manager.js`

- Owns the browser UI for selecting, importing, ordering, configuring, and
  importing/exporting mod-related data.
- Does not parse ASAR internals except through `ModLoader` helper APIs.
- Local imported ASAR files are intentionally session-only.

`markdown_viewer.js`

- Owns the manager About page's local README Markdown rendering helper.
- Escapes raw HTML from Markdown input and supports only the project README's
  basic Markdown patterns.
- Does not fetch remote Markdown or participate in game startup.

`BrowserShell/browser_api.js`

- Owns the browser replacement for the original Electron preload `window.api`.
- Storage, dialogs, fullscreen, and browser file download/upload helpers belong
  here.

`BrowserShell/electron_latest.js`

- Owns Tyrano runtime patches that are needed after the engine is loaded.
- Engine behavior overrides belong here, not in `BrowserShell/browser_api.js`.

## Invariants

- Resource interceptors must be installed once. Repeated `init()` calls should
  not wrap browser APIs again.
- ASAR header and file entries must be validated before indexing:
  finite non-negative integer `offset` / `size`, and `offset + size` inside the
  data section.
- Resource lookup uses normalized same-origin paths. Query strings and hashes
  are stripped before ASAR matching.
- Local imported mods with the same id intentionally override built-in mods for
  the current session.
- Cross-origin, `blob:`, `data:`, and `javascript:` URLs should not be claimed
  by ASAR path matching.
- Public APIs that report per-mod metadata must inspect that mod's own ASAR or
  local buffer. Do not infer per-mod flags from the merged `fileIndex`.
- Resource interceptors replace only the resolved URL. They must preserve the
  rest of each browser API call, such as XHR `async` / credentials arguments and
  `fetch()` `init` / `Request` options, CSS `setProperty` priority, callback
  timing, and wrapper prototype behavior.

## Debug helpers

Runtime debug entrypoints are documented in `../tool/README.md`. Keep the full
helper list there so DevTools usage notes have one owner.

## Verification checklist

For loader changes, at minimum run:

```bash
npm run check
```

For a tighter edit loop while working only on the loader, `npm run check:modloader`
runs the focused ModLoader VM harness.

Then manually test:

- Start with no mods selected.
- Start with built-in mods selected.
- Import a local ASAR, reorder it, and start.
- Confirm resource overrides work for same-origin absolute URLs and query/hash
  cache-busted URLs.
- Open a DCML hook mod that reads `window.electronAPI`.
