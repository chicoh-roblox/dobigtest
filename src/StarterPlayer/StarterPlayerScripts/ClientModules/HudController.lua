local HudController = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Requires
local UIReferences = require(Players.LocalPlayer.PlayerScripts.Util.UIReferences)
local UIStateManager = require(Players.LocalPlayer.PlayerScripts.ClientModules.UIStateManager)
local Trove = require(ReplicatedStorage.Packages.Trove)

-- Script Variables
local trove = Trove.new()

local openIndexButton: TextButton? = nil
local openRebirthButton: TextButton? = nil

--------------------
-- LOCAL SCRIPT
--------------------
local function initButtonListener()
	if not openIndexButton then
		warn("ERROR: Open Index Button not found")
		return
	end

	if not openRebirthButton then
		warn("ERROR: Open Rebirth Button not found")
		return
	end

	trove:Connect(openIndexButton.MouseButton1Click, function()
		UIStateManager:Open("INDEX", {})
	end)

	trove:Connect(openRebirthButton.MouseButton1Click, function()
		UIStateManager:Open("REBIRTH", {})
	end)
end

local function createReferences()
	openIndexButton = UIReferences:GetReference("OPEN_INDEX_BUTTON_HUD")
	openRebirthButton = UIReferences:GetReference("OPEN_REBIRTH_BUTTON_HUD")
end

--------------------
-- GLOBAL FUNCTIONS
--------------------
function HudController:Init()
	createReferences()
	initButtonListener()
end

function HudController:Destroy()
	trove:Clean()
end

return HudController
