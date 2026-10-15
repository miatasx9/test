---
name: add-service
description: Scaffold a new server Service or client Controller module that the bootstrap loads automatically. Use when adding a new game system.
---

1. Server: create `src/server/Services/<Name>Service.luau`. Client: create `src/client/Controllers/<Name>Controller.luau`. The bootstrap loads it automatically — don't edit `init.*.luau`.
2. Shape:
   ```luau
   --!strict
   local <Name>Service = {}

   function <Name>Service:Init()
   	-- create remotes, set up state; no yielding, no calls into other services
   end

   function <Name>Service:Start()
   	-- connect events, start loops, call other services
   end

   return <Name>Service
   ```
3. To use another service, `require` it in `Start()` (or at the top if there's no cycle) via `script.Parent.<Other>`.
4. Put types other modules need in `src/shared/`, not in the service.
5. Run the `verify` skill.
