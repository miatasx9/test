#!/usr/bin/env bash
# Format, lint and type-check everything in src/. Run from the repo root.
# Usage: scripts/check.sh          (check only)
#        scripts/check.sh --fix    (apply StyLua formatting first)
set -euo pipefail
cd "$(dirname "$0")/.."

TYPES_URL="https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.luau"
if [ ! -f globalTypes.d.luau ]; then
	echo "Downloading Roblox type definitions..."
	curl -sSfL -o globalTypes.d.luau "$TYPES_URL"
fi

if [ "${1:-}" = "--fix" ]; then
	stylua src
else
	stylua --check src
fi

selene src

rojo sourcemap default.project.json --output sourcemap.json
luau-lsp analyze \
	--platform=roblox \
	--sourcemap=sourcemap.json \
	--definitions=@roblox=globalTypes.d.luau \
	--ignore="Packages/**" \
	--ignore="ServerPackages/**" \
	src

echo "All checks passed."
