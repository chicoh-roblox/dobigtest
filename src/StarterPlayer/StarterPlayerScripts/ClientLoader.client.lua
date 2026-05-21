-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Requires
local RemoteManager = require(ReplicatedStorage.Utility.RemoteManager)

type Response = {
	action: string,
	data: any,
}

type Module = {
	Init: (self: Module, data: any) -> (),
}

local function initModule(moduleScript: ModuleScript, data: any)
	local success, loadedModule = pcall(require, moduleScript)

	if not success then
		warn("Failed to require module:", moduleScript.Name, loadedModule)
		return
	end

	if typeof(loadedModule) ~= "table" then
		return
	end

	local module = loadedModule :: Module

	if typeof(module.Init) == "function" then
		module:Init(data)
	end
end

RemoteManager:ConnectEvent("PlayerLoaded", function(response: Response)
	if response.action ~= "PlayerLoaded" then
		return
	end

	local clientModules: Folder = script.Parent.ClientModules

	for _, child: Instance in clientModules:GetChildren() do
		if child:IsA("Folder") then
			for _, moduleScript: Instance in child:GetChildren() do
				if moduleScript:IsA("ModuleScript") then
					initModule(moduleScript, response.data)
				end
			end
		end

		if child:IsA("ModuleScript") then
			initModule(child, response.data)
		end
	end
end)
