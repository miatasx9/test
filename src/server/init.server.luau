--!strict
-- Server entry point. Loads every ModuleScript in Services, calls Init() on
-- all of them, then Start() on all of them. Init must not yield or depend on
-- other services; Start may.

type Service = {
	Init: ((self: any) -> ())?,
	Start: ((self: any) -> ())?,
}

local services: { [string]: Service } = {}

for _, child in script.Services:GetChildren() do
	if child:IsA("ModuleScript") then
		services[child.Name] = (require :: any)(child)
	end
end

for name, service in services do
	local init = service.Init
	if init then
		debug.setmemorycategory(name)
		init(service)
	end
end

for name, service in services do
	local start = service.Start
	if start then
		task.spawn(function()
			debug.setmemorycategory(name)
			start(service)
		end)
	end
end
