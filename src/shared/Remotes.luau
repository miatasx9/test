--!strict
-- Single source of truth for RemoteEvents. The server creates them on first
-- access; the client waits for them. Add every remote name to `Names`.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FOLDER_NAME = "Remotes"
local WAIT_TIMEOUT = 10

local Remotes = {}

Remotes.Names = table.freeze({
	RequestPoints = "RequestPoints",
	PointsChanged = "PointsChanged",
})

local function getFolder(): Folder
	if RunService:IsServer() then
		local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
		if not folder then
			local newFolder = Instance.new("Folder")
			newFolder.Name = FOLDER_NAME
			newFolder.Parent = ReplicatedStorage
			return newFolder
		end
		return folder :: Folder
	end
	local folder = ReplicatedStorage:WaitForChild(FOLDER_NAME, WAIT_TIMEOUT)
	assert(folder, `Remotes folder missing after {WAIT_TIMEOUT}s`)
	return folder :: Folder
end

function Remotes.event(name: string): RemoteEvent
	local folder = getFolder()
	if RunService:IsServer() then
		local existing = folder:FindFirstChild(name)
		if existing then
			return existing :: RemoteEvent
		end
		local remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = folder
		return remote
	end
	local remote = folder:WaitForChild(name, WAIT_TIMEOUT)
	assert(remote, `RemoteEvent "{name}" missing after {WAIT_TIMEOUT}s`)
	return remote :: RemoteEvent
end

return Remotes
