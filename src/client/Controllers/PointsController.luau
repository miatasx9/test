--!strict
-- Example controller: listens for point updates from PointsService.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Remotes)

local PointsController = {}

local currentPoints = 0

function PointsController.getPoints(): number
	return currentPoints
end

function PointsController.requestPoints()
	Remotes.event(Remotes.Names.RequestPoints):FireServer()
end

function PointsController:Start()
	Remotes.event(Remotes.Names.PointsChanged).OnClientEvent:Connect(function(total: number)
		currentPoints = total
	end)
end

return PointsController
