local IndexService = {}

-- Services
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Requires
local RemoteManager = require(ReplicatedStorage.Utility.RemoteManager)
local PlayerDataHandler = require(ServerScriptService.Modules.Player.PlayerDataHandler)
local DevsEnum = require(ReplicatedStorage.Enums.DevsEnum)

-- Local Functions
local function getAllIndex(player: Player)
	if not player or not player.Parent then
		warn("Player not found")
		return nil
	end

	return PlayerDataHandler:Get(player, "index")
end

local function giveIndex(player: Player, itemName: string)
	-- Checks if the player exists and is on the server.
	if not player or not player.Parent then
		warn("Player not found")
		return
	end

	-- Validating the itemName Type
	if not typeof(itemName) == "string" then
		warn("The item name must be a string.")
		return
	end

	-- Validating the existence of the `dev` in the enum.
	if (not itemName) or not DevsEnum[itemName] then
		warn("Item not found")
		return
	end

	-- Update Database
	PlayerDataHandler:Update(player, "index", function(current)
		current[itemName] = true
		return current
	end)

	return true
end

local function initRemotes()
	RemoteManager:SetCallback("Index", function(player, data)
		if not data or not data.action then
			return {
				status = "error",
				message = "Invalid action",
			}
		end

		if data.action == "getAll" then
			return {
				status = "success",
				message = "Index retrieved",
				data = IndexService:GetAll(player),
			}
		end

		return {
			status = "error",
			message = "Action not found",
		}
	end)
end

-- Global Functions
function IndexService:GiveIndex(player: Player, itemName: string)
	return giveIndex(player, itemName)
end

function IndexService:GetAll(player: Player)
	return getAllIndex(player)
end

function IndexService:Init()
	initRemotes()
end

return IndexService
