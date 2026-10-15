--!strict
-- Example service: server-authoritative points with a validated, rate-limited
-- remote. Delete or replace once you have real systems.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Remotes)

local COOLDOWN_SECONDS = 1
local POINTS_PER_REQUEST = 1

local PointsService = {}

local points: { [Player]: number } = {}
local lastRequest: { [Player]: number } = {}

local pointsChanged: RemoteEvent

function PointsService.getPoints(player: Player): number
	return points[player] or 0
end

function PointsService.addPoints(player: Player, amount: number)
	local total = PointsService.getPoints(player) + amount
	points[player] = total
	pointsChanged:FireClient(player, total)
end

local function onRequestPoints(player: Player)
	local now = os.clock()
	local last = lastRequest[player]
	if last and now - last < COOLDOWN_SECONDS then
		return
	end
	lastRequest[player] = now
	PointsService.addPoints(player, POINTS_PER_REQUEST)
end

function PointsService:Init()
	pointsChanged = Remotes.event(Remotes.Names.PointsChanged)
	Remotes.event(Remotes.Names.RequestPoints).OnServerEvent:Connect(onRequestPoints)
end

function PointsService:Start()
	Players.PlayerRemoving:Connect(function(player)
		points[player] = nil
		lastRequest[player] = nil
	end)
end

return PointsService
