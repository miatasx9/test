--!strict
-- Client entry point. Same Init/Start lifecycle as the server, for every
-- ModuleScript in Controllers.

type Controller = {
	Init: ((self: any) -> ())?,
	Start: ((self: any) -> ())?,
}

local controllers: { [string]: Controller } = {}

for _, child in script.Controllers:GetChildren() do
	if child:IsA("ModuleScript") then
		controllers[child.Name] = (require :: any)(child)
	end
end

for _, controller in controllers do
	local init = controller.Init
	if init then
		init(controller)
	end
end

for _, controller in controllers do
	local start = controller.Start
	if start then
		task.spawn(function()
			start(controller)
		end)
	end
end
