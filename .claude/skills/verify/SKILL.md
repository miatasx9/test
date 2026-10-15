---
name: verify
description: Format, lint and type-check the Luau code (StyLua, Selene, luau-lsp). Use after any change to src/ and before saying work is done.
---

1. Run `scripts/check.sh --fix` from the repo root.
2. If it fails, fix the reported problems in `src/` (never by loosening `--!strict`, adding `any` casts, or disabling Selene lints) and run it again.
3. Report only the final result: "checks pass", or the remaining errors with file:line.

If a tool is missing, tell the user to run `rokit install`. If Selene says it can't build the Roblox standard library, it needs internet access once to download the API dump.
