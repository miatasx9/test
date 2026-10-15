---
name: studio-change
description: The standard loop for changing the game in Studio through the MCP: locate, read, edit, playtest, check output, update the map. Use for any feature or bug fix.
---

1. **Locate**: find the script(s) in `docs/GAME_MAP.md`. Only search the place if the map doesn't cover it.
2. **Read** only those scripts.
3. **Plan**: if the change touches more than about three scripts or moves or deletes anything, state the plan and ask first.
4. **Edit** through the MCP. Change only what's needed and preserve everything else in the script exactly.
5. **Playtest**: start a playtest through the MCP if it supports it (otherwise ask the user to press Play), then read the output. Check for errors and warnings from the scripts you touched. Stop the playtest when done.
6. **Fix** any errors and retest, at most three rounds before reporting back to the user.
7. **Update `docs/GAME_MAP.md`** if you added, moved or changed the purpose of any script, remote or asset.
8. **Report** in a few lines: what changed (script paths), test result, anything the user should check by hand.
