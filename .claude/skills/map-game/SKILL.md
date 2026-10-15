---
name: map-game
description: Build or refresh docs/GAME_MAP.md, a compact index of every script, remote, DataStore and asset in the game, so later sessions don't need to re-explore. Use when GAME_MAP.md is empty or out of date.
---

1. **Rojo scripts** (files in `src/`): get paths from the file tree. For each, read only the first ~15 lines plus lines matching `DataStoreService|GetDataStore|OnServerEvent|OnClientEvent|OnServerInvoke|rbxassetid` (use grep, not full reads).
2. **Studio-only scripts and remotes**: through the Studio MCP, run one script that prints one compact line per Script/LocalScript/ModuleScript **not** covered by `src/` (full path, class, line count), and per RemoteEvent, RemoteFunction, UnreliableRemoteEvent and BindableEvent (full path). Skip vendored folders (`Packages`, `_Index`) and CoreGui. For Studio-only scripts, read only the top lines and the same keyword lines.
3. Write `docs/GAME_MAP.md`: overview, systems grouped by purpose, the scripts table (with a Rojo / Studio-only column), the remotes table (mark whether server handlers validate input, if you could tell), DataStores, assets.
4. Tell the user what you mapped and anything risky you noticed, such as unvalidated remotes. Don't fix anything without asking.
