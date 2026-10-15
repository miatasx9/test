# Roblox game — Claude workspace

The game itself lives in Roblox Studio. This repo gives Claude Code what it needs to work on it through the Roblox Studio MCP:

- `CLAUDE.md`: rules Claude follows every session (read the map first, keep MCP output small, server-authoritative code, ask before deleting).
- `docs/GAME_MAP.md`: a compact index of your place's scripts, remotes, DataStores and assets. Claude reads it instead of re-exploring Studio each session, which saves a lot of tokens.
- `.claude/skills/`:
  - `map-game`: builds or refreshes the map,
  - `studio-change`: the locate → edit → playtest → check output loop,
  - `add-remote`: adds a validated, rate-limited RemoteEvent.

## Setup
1. Clone this repo on your computer.
2. Open Studio with your place, with the Studio MCP connected as usual.
3. Run `claude` in this folder (or open it in VS Code with the Claude Code extension).
4. First time only, ask: **"Run map-game."** Then commit the result: `git add -A && git commit -m "Map game" && git push`.

From then on, start Claude in this folder whenever you work on the game. Commit `docs/GAME_MAP.md` when it changes.

## Tips
- `/clear` between unrelated tasks; one task per conversation.
- Name the system or script you mean ("the shop purchase handler"), not just "fix the bug".
- Use plan mode for big features.
- Save a backup (File → Save to File) before large changes.
