---
name: add-remote
description: Add a new client↔server RemoteEvent with server-side validation and rate limiting. Use when a feature needs the client and server to talk.
---

1. Check `docs/GAME_MAP.md` for where this game keeps its remotes and follow that pattern. If there's no pattern yet, use a `Remotes` folder in ReplicatedStorage.
2. Name it PascalCase: verb-first for client→server requests (`RequestPurchase`), past tense for server→client notifications (`PurchaseCompleted`).
3. The server handler must, in order:
   - rate-limit per player, and clear that player's entry on `Players.PlayerRemoving`,
   - check every argument's `typeof` and its range or length, and return silently on bad input,
   - re-check game state on the server (ownership, currency, distance, cooldowns). Never trust values the client computed.
4. Playtest and check the output as in `studio-change`.
5. Add the remote to the Remotes table in `docs/GAME_MAP.md`.
