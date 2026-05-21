-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Requeires
local RemoteManager = require(ReplicatedStorage.Utility.RemoteManager)
local PlayerDataHandler = require(ServerScriptService.Modules.Player.PlayerDataHandler)

-- Variables
local folder = ServerScriptService.Modules

-- Initializer Player Data
PlayerDataHandler:Init()
RemoteManager:GetEvent("Level")
RemoteManager:GetEvent("PlayerLoaded")
RemoteManager:GetFunction("Player")

-- Starting All Modules
for _, module in folder:GetChildren() do
	if module.Name == "Player" then
		continue
	end

	local loadedModule = require(module)

	if typeof(loadedModule) == "table" and loadedModule.Init then
		loadedModule:Init()
	end
end
