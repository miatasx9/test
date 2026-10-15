---
name: map-game
description: Build or refresh docs/GAME_MAP.md, a compact index of every script, remote, DataStore and asset in the Studio place, so later sessions don't need to re-explore. Use when GAME_MAP.md is empty or out of date.
---

1. Using the Studio MCP, run one script that collects, for Workspace, ServerScriptService, ServerStorage, ReplicatedStorage, ReplicatedFirst, StarterPlayer, StarterGui and StarterPack:
   - every Script, LocalScript and ModuleScript: full path, class, line count,
   - every RemoteEvent, RemoteFunction, UnreliableRemoteEvent and BindableEvent: full path.
   Skip anything inside a folder named `Packages`, `_Index` or similar vendored libraries, and anything under CoreGui. Print one compact line per item.
2. For each script, read only the first ~15 lines plus any lines containing `DataStoreService`, `GetDataStore`, `OnServerEvent`, `OnClientEvent` or `rbxassetid`. Don't read whole sources.
3. Write `docs/GAME_MAP.md`: overview, systems grouped by purpose, a one-line purpose per script, the remotes table (mark whether server handlers validate input, if you could tell), DataStores, and asset IDs.
4. Tell the user what you mapped and anything risky you noticed, such as remotes with no validation. Don't fix things without asking.
