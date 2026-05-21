local RebirthService = {}

-- Services
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Requires
local RemoteManager = require(ReplicatedStorage.Utility.RemoteManager)
local PlayerDataHandler = require(ServerScriptService.Modules.Player.PlayerDataHandler)
local RebirthsEnum = require(ReplicatedStorage.Enums.RebirthsEnum)

-- Local Functions
local function giveAllAwards(player: Player, rebirth)
	for _, award in rebirth.Awards do
		if award.Type == "FLOOR" then
			PlayerDataHandler:Update(player, "maxFloor", function(current)
				current = current + 1
				return current
			end)
		end

		if award.Type == "CASH" then
			PlayerDataHandler:Update(player, "cash", function(current)
				current = current + award.Amount
				return current
			end)
		end

		if award.Type == "CASH_MULTIPLIER" then
			PlayerDataHandler:Update(player, "cashMultiplier", function(current)
				current = current + award.Amount
				return current
			end)
		end
	end
end

local function hasAllRequeriments(player: Player, rebirth)
	local currentCash = PlayerDataHandler:Get(player, "cash")

	for _, requirement in rebirth.Requirements do
		if requirement.Type == "CASH" then
			if not currentCash < requirement.Amount then
				return false
			end
		end
	end

	return true
end

local function giveRebirth(player: Player)
	-- Looking for the next rebirth
	local currentRebirthNumber = PlayerDataHandler:Get(player, "rebirthLevel")
	local nextRebirth = RebirthsEnum[currentRebirthNumber + 1]

	if nextRebirth then
		-- Check all the requirements for rebirth.
		-- Param: RebirthEnum
		local hasAllRequeriments = hasAllRequeriments(player, nextRebirth)

		if hasAllRequeriments then
			-- Update DataBase
			PlayerDataHandler:Update(player, "rebirthLevel", function(current)
				return current + 1
			end)

			-- Give the Awards to the player.
			-- Param: RebirthEnum
			giveAllAwards(player, nextRebirth)

			return true
		end
	end

	return false
end

local function initRemotes()
	RemoteManager:SetCallback("Rebirth", function(player, data)
		if not data or not data.action then
			return {
				status = "error",
				message = "Invalid action",
			}
		end

		if data.action == "GetCurrentRebirth" then
			return {
				status = "success",
				message = "Current Rebirth retrieved",
				data = RebirthService:GetCurrentRebirth(player),
			}
		end

		return {
			status = "error",
			message = "Action not found",
		}
	end)
end

-- Global Functions

function RebirthService:GetCurrentRebirth(player: Player)
	return PlayerDataHandler:Get(player, "rebirthLevel")
end

function RebirthService:GiveRebirth(player: Player)
	return giveRebirth(player)
end

function RebirthService:Init()
	initRemotes()
end

return RebirthService
