local IndexScreen = {}

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local UIReferences = require(Players.LocalPlayer.PlayerScripts.Util.UIReferences)
local RemoteManager = require(ReplicatedStorage.Utility.RemoteManager)
local DevsEnum = require(ReplicatedStorage.Enums.DevsEnum)
local Trove = require(ReplicatedStorage.Packages.Trove)

-- Script Variables
local screen: Frame = nil
local devScrollingFrame: ScrollingFrame = nil

local trove = Trove.new()

local isBuilding: boolean = false

-------------------
-- Local Functions
-------------------
local function createReferences()
	screen = UIReferences:GetReference("INDEX_SCREEN")
	devScrollingFrame = UIReferences:GetReference("DEVS_SCROLLING_FRAME")
end

local function createDevItem(devName: string, devData)
	local itemTemplate = devScrollingFrame:FindFirstChild("ItemTemplate")

	if not itemTemplate then
		warn("ItemTemplate not found")
		return
	end

	local newItem = itemTemplate:Clone()

	local itemName = newItem:FindFirstChild("ItemName")
	local cashPerSec = newItem:FindFirstChild("CashPerSec")

	if not itemName then
		warn("ItemName not found in item:", devName)
		return
	end

	if not cashPerSec then
		warn("CashPerSec not found in item:", devName)
		return
	end

	newItem.Visible = true
	newItem.LayoutOrder = devData.Order
	newItem.Parent = devScrollingFrame

	trove:Add(newItem)

	local unlocked = DevsEnum[devName]

	itemName.Text = unlocked and devData.GUI.Label or "???"
	cashPerSec.Text = unlocked and ("$" .. devData.MoneyPerSecond) or "???"
end

local function buildScreen(data)
	local response = RemoteManager:InvokeServer("Index", {
		action = "getAll",
	})

	if response.status ~= "success" then
		return
	end

	trove:Clean()

	for devName, devData in DevsEnum do
		createDevItem(devName, devData)
	end
end

--------------------
-- Global Functions
--------------------
function IndexScreen:Init()
	createReferences()
end

function IndexScreen:Close()
	screen.Visible = false

	trove:Clean()
end

function IndexScreen:GetScreen()
	return screen
end

function IndexScreen:Open(data)
	if isBuilding then
		return
	end

	isBuilding = true
	screen.Visible = true

	local thread = task.spawn(function()
		local success, err = pcall(function()
			buildScreen(data)
		end)

		if not success then
			warn("Error When Build Screen:", err)
		end

		isBuilding = false
	end)

	trove:Add(thread)
end

return IndexScreen
