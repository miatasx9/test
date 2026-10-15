---
name: migrate-to-rojo
description: One-time copy of the game's existing scripts from Studio into src/ so Rojo manages them, without moving, duplicating or deleting anything in the place. Use only when the user asks to migrate and src/ is still empty.
---

Goal: every script in the main code containers exists as a file in `src/` at the same path and with the same name as in Studio. When Rojo connects, it then updates the existing scripts in place. Nothing else in the place changes.

## 0. Safety first
- Ask the user to save a backup (File → Save to File As… → `backup.rbxl`) and to confirm before you continue.
- Make sure Rojo is **not** connected in Studio during steps 1–4.

## 1. Inventory (through the Studio MCP, compact output)
In ServerScriptService, ServerStorage, ReplicatedStorage, ReplicatedFirst, StarterPlayer.StarterPlayerScripts and StarterPlayer.StarterCharacterScripts, list every Script, LocalScript and ModuleScript as one line each: full path, class, `RunContext` (for Scripts), `Enabled`/`Disabled`, line count.

**In scope:** scripts whose parents are those services, Folders, or other scripts.
**Out of scope (leave in Studio, list them in GAME_MAP as "Studio-only"):** scripts inside Workspace, StarterGui, StarterPack, Lighting, or inside Models/Parts/Tools/ScreenGuis anywhere. Those depend on the objects around them.

Stop and ask the user if you find:
- two siblings with the same name (Rojo can't tell them apart; one must be renamed),
- names containing `/ \ : * ? " < > |` or names starting with a dot.

## 2. Write the files
Path rule: `src/<Service>/<Folder>/.../<Name><suffix>` mirroring Studio exactly. Use `src/StarterPlayer/StarterPlayerScripts/...` for StarterPlayer containers.

| Studio | File |
|---|---|
| Script | `Name.server.luau` (if `RunContext` is Client, use `Name.client.luau`) |
| LocalScript | `Name.client.luau` |
| ModuleScript | `Name.luau` |
| Script/Module that has children | folder `Name/` with `init.server.luau` / `init.client.luau` / `init.luau` |

- Copy each `Source` exactly. Don't fix, reformat or "improve" anything during migration. Fetch long sources in chunks if the MCP truncates output, and check the line count matches.
- Disabled scripts: add `Name.meta.json` with `{"properties": {"Disabled": true}}`. Non-default `RunContext`: add it to the same meta file, e.g. `{"properties": {"RunContext": "Client"}}`.
- **Every directory** you create under `src/` (except the service roots) gets an `init.meta.json` containing `{"ignoreUnknownInstances": true}`. If the folder has an `init.*.luau`, put the same key in the folder's `init.meta.json`. This stops Rojo from deleting non-script things (RemoteEvents, values, configs) that live in the same folders.

## 3. Project file
Rewrite `default.project.json` so each service root you created is mapped with both keys, for example:
```json
"ServerScriptService": { "$path": "src/ServerScriptService", "$ignoreUnknownInstances": true }
```
For StarterPlayer, nest: `"StarterPlayer": { "$ignoreUnknownInstances": true, "StarterPlayerScripts": { "$path": "src/StarterPlayer/StarterPlayerScripts", "$ignoreUnknownInstances": true } }`.
Run `rojo sourcemap default.project.json` and compare the scripts it lists against your inventory. The counts and paths must match exactly.

## 4. Check and commit
- Run `scripts/check.sh`. Existing code will probably have warnings and some type errors. **Don't fix them now.** Save the summary in `docs/GAME_MAP.md` under "Known issues" as a baseline.
- `git add -A && git commit -m "Migrate scripts from Studio into Rojo"`.
- Then run `stylua src`, and commit separately as "Format scripts with StyLua", so the copy and the reformat are separate commits.

## 5. Connect (with the user)
Tell the user to:
1. run `rojo serve` (or let you start it in the background),
2. click **Connect** in the Rojo plugin in Studio,
3. **read the change preview Rojo shows before accepting.** It should only show script source updates (mostly whitespace from formatting). If it shows anything being **removed or added**, click Cancel and tell you what it listed.
4. accept, then playtest normally.

## 6. Finish
Update `docs/GAME_MAP.md`: mark each script "Rojo" (in `src/`) or "Studio-only". From now on, Rojo scripts are edited only as files.
