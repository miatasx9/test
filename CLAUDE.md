# Roblox game — Claude instructions

The game lives **in Roblox Studio**, not in this repo. Read and change it through the Roblox Studio MCP. This repo holds only Claude's notes and workflows for the game.

## Start of every session
1. Read `docs/GAME_MAP.md` first. It says where every system and script lives. Use it instead of exploring the place tree.
2. If it's still the empty template, or clearly out of date, run the `map-game` skill before doing anything else.

## Keep MCP output small (this is where tokens go)
- Go straight to the script you need using the path in `GAME_MAP.md`. Don't list whole services or dump `GetDescendants()`.
- When running code, print only the specific values you need. Truncate long sources and lists.
- Read a script's source once per task. Don't re-read it after every small edit unless something else may have changed it.
- Only change the parts of a script that need changing; keep the rest exactly as it was.

## Making changes
Follow the `studio-change` skill: locate, read, edit, playtest, check output, then update `GAME_MAP.md` if anything moved or was added.
- Don't delete or rename scripts, or move instances, without asking first.
- Ask before large refactors that touch many scripts.

## Code conventions
- New scripts start with `--!strict` where practical. Match the style of the scripts around them.
- Server is authoritative. Every `OnServerEvent` handler checks argument types and ranges and rate-limits per player. Never trust values the client sends.
- Use `task.wait/spawn/delay`, never `wait/spawn/delay`. Get services with `game:GetService`.
- New remotes go where the game already keeps its remotes (see `GAME_MAP.md`). Use the `add-remote` skill.

## Assets
Art, audio and models come from ForgeGUI or the Creator Store as asset IDs. Record IDs in `GAME_MAP.md` under Assets, and keep them as constants in one module rather than scattered literals.

## Safety
The user keeps backups (File → Save to File). Before a risky multi-script change, remind them to save a backup copy first.
