# Roblox game — Claude instructions

Hybrid setup: **scripts live as files in `src/` and Rojo syncs them into Studio**. Everything else (map, parts, UI, models) and a few "Studio-only" scripts stay in Studio and are reached through the Roblox Studio MCP. `docs/GAME_MAP.md` says which is which.

## Start of every session
1. Read `docs/GAME_MAP.md` first. Use it instead of exploring the place.
2. If `src/` is empty, the game hasn't been migrated yet. Offer to run `migrate-to-rojo`, but only run it when the user agrees. Until then, work through the MCP.
3. If the map is still the empty template or clearly out of date, run `map-game`.

## Golden rule
- **Script in `src/` → edit the file. Never edit it through the MCP**: Rojo overwrites Studio from the files.
- Studio-only scripts and non-script objects → edit through the MCP.
- New scripts go in `src/` unless they must sit inside a part, model, tool or GUI.
- Rojo must be connected (`rojo serve` + Connect in the Studio plugin) for file edits to reach Studio. If a playtest doesn't reflect your change, check that first.

## Keep tokens down
- Search `src/` with grep/glob; it's far cheaper than the MCP.
- Through the MCP, go straight to the path you need; print only the values you need; never dump whole trees or `GetDescendants()`.
- Read a script once per task, and change only the lines that need changing.

## Verify every change
Run `scripts/check.sh` (StyLua, Selene, luau-lsp type check). Code you touched must pass. Older warnings recorded in GAME_MAP's "Known issues" are a baseline; don't fix them unless asked. Then playtest as in the `studio-change` skill.

## Code conventions
- Match the style of the surrounding code. New files start with `--!strict` where practical.
- Server is authoritative. Every `OnServerEvent` handler checks argument types and ranges and rate-limits per player (`add-remote` skill).
- Use `task.wait/spawn/delay`, never `wait/spawn/delay`. Get services with `game:GetService`.
- Script file suffixes: `.server.luau` Script, `.client.luau` LocalScript, `.luau` ModuleScript; a folder with `init.*.luau` is a script with children. Every subfolder of `src/` has an `init.meta.json` with `ignoreUnknownInstances: true` so Rojo never deletes non-script siblings; keep that when adding folders.

## Safety
- Ask before deleting, renaming or moving scripts or instances, and before large multi-script refactors.
- Git is the undo button: offer to commit after each working change.

## Assets
Art, audio and models come from ForgeGUI or the Creator Store as asset IDs. Record them in `docs/GAME_MAP.md` under Assets and keep them as constants in one module.
