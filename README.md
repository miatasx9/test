# Roblox game — Claude workspace

Hybrid setup: the game's **scripts** live as `.luau` files in `src/` and Rojo syncs them into your existing place. Everything else (map, parts, UI, models) stays in Studio, and Claude reaches it through the Roblox Studio MCP.

## What's here
- `CLAUDE.md`: rules Claude follows every session.
- `docs/GAME_MAP.md`: compact index of scripts, remotes, data and assets, so Claude doesn't re-explore Studio each session.
- `.claude/skills/`:
  - `migrate-to-rojo`: one-time copy of your scripts from Studio into `src/`,
  - `map-game`: builds or refreshes the map,
  - `studio-change`: the locate → edit → check → playtest loop,
  - `add-remote`: adds a validated, rate-limited RemoteEvent,
  - `verify`: runs the checks.
- `.claude/settings.json`: pre-approves the check/build commands and auto-formats Luau after edits.
- `scripts/check.sh`: StyLua + Selene + luau-lsp type check.
- `rokit.toml`: pinned versions of rojo, wally, luau-lsp, selene, stylua, lune.

## One-time setup
1. Install Rokit: https://github.com/rojo-rbx/rokit#installation
2. In this folder: `rokit install`, then `rojo plugin install` (adds the Rojo plugin to Studio).
3. Save a backup of your place (File → Save to File As…).
4. Start `claude` here with Studio open and say **"run migrate-to-rojo"**.
5. When Claude says so: run `rojo serve`, click **Connect** in the Rojo plugin, **read the change preview** (it should show only script updates, nothing removed), then accept.
6. Say **"run map-game"**.

## Every session
1. Open your place in Studio.
2. `rojo serve`, then click Connect in the Rojo plugin.
3. `claude` in this folder.

Edit scripts that live in `src/` only as files, not in Studio; Rojo overwrites Studio from the files.

On Windows, run `scripts/check.sh` from Git Bash (installed with Git).
