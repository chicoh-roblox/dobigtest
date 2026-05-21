local RebirthScreen = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local UIReferences = require(Players.LocalPlayer.PlayerScripts.Util.UIReferences)
local RemoteManager = require(ReplicatedStorage.Utility.RemoteManager)

-- Script Variables
local screen: Frame = nil
local isBuilding: boolean = false

-------------------
-- Local Functions
-------------------
local function createReferences()
	screen = UIReferences:GetReference("REBIRTH_SCREEN")
end

local function buildScreen(data)
	local response = RemoteManager:InvokeServer("Rebirth", {
		action = "GetCurrentRebirth",
	})

	if not (response and response.status == "success") then
		return
	end

	print(response.data)
end

--------------------
-- Global Functions
--------------------
function RebirthScreen:Init()
	createReferences()
end

function RebirthScreen:Close()
	screen.Visible = false
end

function RebirthScreen:GetScreen()
	return screen
end

function RebirthScreen:Open(data)
	if isBuilding then
		return
	end

	isBuilding = true
	screen.Visible = true

	task.spawn(function()
		local success, err = pcall(function()
			buildScreen(data)
		end)

		if not success then
			warn("Error When Build Screen:", err)
		end

		isBuilding = false
	end)
end

return RebirthScreen
