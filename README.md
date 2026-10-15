# Roblox game

Rojo-based Roblox project set up for Claude Code: code lives in `src/` as `.luau` files and syncs into Studio live.

## One-time setup (on your computer)

1. **Install Rokit** (toolchain manager): https://github.com/rojo-rbx/rokit#installation
2. In this folder:
   ```sh
   rokit install          # installs rojo, wally, luau-lsp, selene, stylua, lune at pinned versions
   rojo plugin install    # installs the Rojo plugin into Roblox Studio
   ```
3. **VS Code**: open the folder and accept the recommended extensions (Luau Language Server, Rojo, Selene, StyLua, Claude Code).
4. **Studio MCP**: keep your Roblox Studio MCP server configured in Claude Code (`claude mcp list` should show it connected).

## Daily workflow

1. Open your place in Studio.
2. Run `rojo serve` (or "Rojo: Open menu" → Start in VS Code), then click **Connect** in the Rojo plugin in Studio.
3. Start Claude Code in this folder (`claude` in the terminal, or the Claude Code panel in VS Code).
4. Claude edits `src/`, Rojo syncs to Studio, and `scripts/check.sh` verifies each change. Playtest in Studio, or have Claude do it through the Studio MCP.

## Commands

| Command | What it does |
|---|---|
| `scripts/check.sh` | StyLua check + Selene lint + luau-lsp type check |
| `scripts/check.sh --fix` | Same, formatting files first |
| `rojo serve` | Live-sync `src/` into Studio |
| `rojo build -o game.rbxl` | Build a place file |
| `wally install` | Install packages from `wally.toml` into `Packages/` |

On Windows, run `scripts/check.sh` from Git Bash (installed with Git, and used by Claude Code).

## Adding Wally packages

Add a dependency to `wally.toml`, run `wally install`, then map it in `default.project.json`:

```json
"ReplicatedStorage": {
  "Shared": { "$path": "src/shared" },
  "Packages": { "$path": "Packages" }
}
```

## Claude Code setup in this repo

- `CLAUDE.md`: project rules Claude follows (layout, conventions, how to verify).
- `.claude/settings.json`: pre-approves the check/build commands, keeps Claude out of `Packages/` and generated files, and auto-formats with StyLua after every edit.
- `.claude/skills/`: `verify`, `add-remote`, `add-service`, which load only when used.

Tips: `/clear` between unrelated tasks, give Claude exact file paths, use plan mode for large features, and keep MCP servers to the ones you use.
