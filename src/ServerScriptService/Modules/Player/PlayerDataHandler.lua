local PlayerDataHandler = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Requires
local Utility = ReplicatedStorage.Utility
local RemoteManager = require(Utility.RemoteManager)
local ProfileService = require(ServerScriptService.libs.ProfileService)

-- script variables
local cachedJoinTimestamps = {}
local Profiles = {}
local dataTemplate = {
	totalPlaytime = 0,
	index = {},
	rebirthLevel = 0,
	cash = 0,
	cashMultiplier = 1,
	maxFloor = 1,
}

local ProfileStore = ProfileService.GetProfileStore("PlayerProfile", dataTemplate)

-- =========================
-- LOCAL FUNCTIONS
-- =========================
local function playerAdded(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)

	if profile then
		profile:AddUserId(player.UserId)
		profile:Reconcile()

		profile:ListenToRelease(function()
			Profiles[player] = nil

			player:Kick()
		end)

		if not player:IsDescendantOf(Players) then
			profile:Release()
			return
		end

		Profiles[player] = profile

		RemoteManager:FireClient("PlayerLoaded", player, {
			action = "PlayerLoaded",
			status = "success",
			message = "Player data loaded",
			data = profile.Data,
		})
	else
		player:Kick()
	end
end

local function getProfile(player)
	local startTime = os.time()

	while not Profiles[player] and os.time() - startTime < 30 do
		task.wait()
	end

	assert(Profiles[player], "Profile not found for player " .. player.Name)

	return Profiles[player]
end

-- =========================
-- GLOBAL FUNCTIONS
-- =========================

function PlayerDataHandler:Wipe(player)
	local success = ProfileStore:WipeProfileAsync("Player_" .. player.UserId)

	if success then
		player:Kick()
	end
end

function PlayerDataHandler:Get(player, key)
	local profile = getProfile(player)

	return profile.Data[key]
end

function PlayerDataHandler:Set(player, key, value)
	local profile = getProfile(player)

	assert(type(value) == type(profile.Data[key]), "Value type mismatch for key " .. key)

	profile.Data[key] = value
end

function PlayerDataHandler:Update(player, key, callback)
	local oldData = self:Get(player, key)

	local newData = callback(oldData)

	self:Set(player, key, newData)
end

function PlayerDataHandler:GetAll(player)
	local profile = getProfile(player)

	return profile.Data
end

function PlayerDataHandler:Init()
	RemoteManager:SetCallback("Player", function(player, data)
		if data.action == "getPlayerData" then
			local playerData = PlayerDataHandler:GetAll(player)

			return {
				status = "success",
				message = "Player data retrieved",
				playerData = playerData,
			}
		end
	end)

	for _, player in Players:GetPlayers() do
		task.spawn(playerAdded, player)
	end

	Players.PlayerAdded:Connect(function(player)
		cachedJoinTimestamps[player] = os.time()

		playerAdded(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		local joinTimestamp = cachedJoinTimestamps[player] or os.time()

		local leaveTimestamp = os.time()

		local playtime = leaveTimestamp - joinTimestamp

		PlayerDataHandler:Update(player, "totalPlaytime", function(currentPlaytime)
			return currentPlaytime + playtime
		end)

		if Profiles[player] then
			Profiles[player]:Release()
		end
	end)
end

return PlayerDataHandler
