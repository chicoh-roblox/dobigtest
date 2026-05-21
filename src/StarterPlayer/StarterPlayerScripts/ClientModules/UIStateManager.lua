local UIStateManager = {}

-- Roblox Services
local Players = game:GetService("Players")

-- Script Variables
local clientModules = Players.LocalPlayer.PlayerScripts.ClientModules

local screens = {}
local loadedScreens = {}
local originalSizeScreen = {}

local currentScreen = ""

local SCREEN_MODULES = {
	INDEX = function()
		return require(clientModules.Screens.IndexScreen)
	end,

	REBIRTH = function()
		return require(clientModules.Screens.RebirthScreen)
	end,
}

-- Script Main Functions
local function getScreenModule(screenName: string)
	if loadedScreens[screenName] then
		return loadedScreens[screenName]
	end

	local loader = SCREEN_MODULES[screenName]

	if not loader then
		warn(`Screen "{screenName}" not found`)
		return
	end

	local module = loader()

	loadedScreens[screenName] = module
	screens[screenName] = module

	return module
end

local function configureScreen(screenName: string)
	local screen = getScreenModule(screenName)

	if not screen then
		return
	end

	if not originalSizeScreen[screenName] then
		originalSizeScreen[screenName] = screen:GetScreen().Size
	end
end

local function openScreen(screenName: string, screenToOpenModule, data: {})
	if typeof(screenToOpenModule) ~= "table" then
		warn("[UIStateManager] Invalid screen module:", screenName)
		return
	end

	if typeof(screenToOpenModule.Open) ~= "function" then
		warn("[UIStateManager] Invalid Open function:", screenName)
		return
	end

	local success, err = pcall(function()
		screenToOpenModule:Open(data)
	end)

	if not success then
		warn("[UIStateManager] Failed to open screen:", screenName, err)
		return
	end

	currentScreen = screenName
end

-------- ---------- --------
-- PUBLIC FUNCTIONS
-------- --------- ---------

function UIStateManager:Open(screenName: string, data: { [string]: any })
	local screenToOpen = getScreenModule(screenName)

	if not screenToOpen then
		warn(("SCREEN NOT FOUND: %s"):format(screenName))
		return
	end

	local isCurrentScreen = screenName == currentScreen

	for name, screen in screens do
		if name ~= screenName then
			screen:Close()
		end
	end

	if isCurrentScreen then
		UIStateManager:Close(screenName)
		currentScreen = ""
		return
	end

	configureScreen(screenName)
	openScreen(screenName, screenToOpen, data)
end

function UIStateManager:Close(screenName: string)
	currentScreen = ""

	if screenName and screens[screenName] then
		screens[screenName]:Close()
	end
end

return UIStateManager
