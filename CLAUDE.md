# Roblox game — Claude instructions

Rojo project. **Code lives in `src/` on disk, not in Studio.** Edit files here; Rojo syncs them into Studio live (`rojo serve`). Never paste or edit scripts through the Studio MCP when a file in `src/` can be edited instead.

## Layout (see `default.project.json`)
- `src/server/` → `ServerScriptService.Server`. `init.server.luau` boots every module in `Services/` (Init, then Start).
- `src/client/` → `StarterPlayerScripts.Client`. `init.client.luau` boots every module in `Controllers/`.
- `src/shared/` → `ReplicatedStorage.Shared`. Shared modules; `Remotes.luau` owns every RemoteEvent.
- `Packages/` (Wally, git-ignored) — never read or edit; don't search it.

## Conventions
- Every file starts with `--!strict`. Fix type errors; don't cast to `any` to silence them (the loaders' `require` cast is the one exception).
- Services/Controllers are plain module tables with optional `Init()` (no yielding, no cross-service calls) and `Start()`.
- Server is authoritative. Every `OnServerEvent` handler validates argument types/ranges and rate-limits. Never trust the client.
- New remotes: add the name to `Remotes.Names`, get it with `Remotes.event(...)`. Don't create RemoteEvents anywhere else.
- Use `task.wait/spawn/delay`, never `wait/spawn/delay`. Use `GetService`, never `game.Workspace`-style access for services.
- PascalCase for modules/services, camelCase for locals/functions, UPPER_SNAKE for constants.
- Keep comments sparse; match surrounding style. Tabs, double quotes (StyLua enforces).

## Verify every change
Run `scripts/check.sh` (or `scripts/check.sh --fix` to format first). It runs StyLua, Selene and luau-lsp type checking. All must pass before you call work done.

## Studio MCP
Use the Studio MCP only for things that exist only in Studio: running code in a playtest, reading output, inspecting/placing instances in Workspace, inserting models. Keep `run_code` output small — print specific values, never whole `GetDescendants()` dumps.

## Assets
Art/audio/models come from ForgeGUI (or the Creator Store) as asset IDs. Store IDs as constants in a shared module (e.g. `src/shared/Assets.luau`), not scattered literals.
