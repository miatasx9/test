---
name: add-remote
description: Add a new client↔server RemoteEvent with server-side validation and rate limiting. Use when a feature needs the client and server to talk.
---

1. Add the name to `Remotes.Names` in `src/shared/Remotes.luau` (PascalCase, verb-first for client→server requests, e.g. `RequestPurchase`; past tense for server→client notifications, e.g. `PurchaseCompleted`).
2. In the owning service's `Init()`, connect `Remotes.event(Remotes.Names.X).OnServerEvent`.
3. The handler must, in order:
   - rate-limit per player (see `PointsService` for the pattern, clean up in `PlayerRemoving`),
   - check every argument's `typeof` and range/length; return silently on bad input,
   - re-check game state server-side (ownership, currency, distance, cooldowns) — never trust values the client computed.
4. Client side: fire or listen through `Remotes.event(...)` from a controller.
5. Run the `verify` skill.
