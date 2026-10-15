---
name: studio-change
description: The standard loop for any feature or bug fix: locate, edit (files for Rojo scripts, MCP for Studio-only ones), verify, playtest, check output, update the map.
---

1. **Locate** the scripts in `docs/GAME_MAP.md`. Search `src/` with grep/glob before touching the MCP.
2. **Read** only those scripts. Rojo scripts: read the file. Studio-only scripts: read through the MCP.
3. **Plan**: if the change touches more than about three scripts or moves or deletes anything, state the plan and ask first.
4. **Edit.**
   - Rojo scripts: edit the file in `src/`. Never edit them through the MCP; Rojo would overwrite the change.
   - Studio-only scripts and non-script objects (parts, UI, models): edit through the MCP, changing only what's needed.
   - New scripts go in `src/` unless they have to live inside a part, model, tool or GUI.
5. **Verify**: run `scripts/check.sh`. Fix new errors in code you touched; don't go fixing old warnings elsewhere.
6. **Playtest** through the MCP if it supports it (otherwise ask the user to press Play; Rojo must be connected), then read the output and check for errors from the scripts you touched.
7. **Fix and retest**, at most three rounds before reporting back.
8. **Update `docs/GAME_MAP.md`** if you added, moved or changed the purpose of any script, remote or asset.
9. **Report** in a few lines: what changed, check and test results, anything to check by hand. Offer to commit.
