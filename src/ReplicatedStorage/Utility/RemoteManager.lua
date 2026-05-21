local RemoteManager = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local IS_SERVER = RunService:IsServer()

local REMOTES_FOLDER_NAME = "Remotes"

local remotesFolder = ReplicatedStorage:FindFirstChild(REMOTES_FOLDER_NAME)

if not remotesFolder then
	remotesFolder = Instance.new("Folder")
	remotesFolder.Name = REMOTES_FOLDER_NAME
	remotesFolder.Parent = ReplicatedStorage
end

local function getOrCreateRemote(remoteType: "RemoteEvent" | "RemoteFunction", remoteName: string)
	local remote = remotesFolder:FindFirstChild(remoteName)

	if remote then
		return remote
	end

	if not IS_SERVER then
		warn(`[{remoteName}] Remote Not Found`)
		return nil
	end

	remote = Instance.new(remoteType)
	remote.Name = remoteName
	remote.Parent = remotesFolder

	return remote
end

-- =========================
-- RemoteEvent
-- =========================

function RemoteManager:GetEvent(remoteName: string): RemoteEvent?
	return getOrCreateRemote("RemoteEvent", remoteName)
end

function RemoteManager:FireClient(remoteName: string, player: Player, ...)
	local remote = self:GetEvent(remoteName)

	if not remote then
		return
	end

	remote:FireClient(player, ...)
end

function RemoteManager:FireAllClients(remoteName: string, ...)
	local remote = self:GetEvent(remoteName)

	if not remote then
		return
	end

	remote:FireAllClients(...)
end

function RemoteManager:FireServer(remoteName: string, ...)
	if IS_SERVER then
		return
	end

	local remote = self:GetEvent(remoteName)

	if not remote then
		return
	end

	remote:FireServer(...)
end

function RemoteManager:ConnectEvent(remoteName: string, callback: (...any) -> ())
	local remote = self:GetEvent(remoteName)

	if not remote then
		return
	end

	if IS_SERVER then
		return remote.OnServerEvent:Connect(callback)
	end

	return remote.OnClientEvent:Connect(callback)
end

-- =========================
-- RemoteFunction
-- =========================

function RemoteManager:GetFunction(remoteName: string): RemoteFunction?
	return getOrCreateRemote("RemoteFunction", remoteName)
end

function RemoteManager:InvokeServer(remoteName: string, ...)
	if IS_SERVER then
		return
	end

	local remote = self:GetFunction(remoteName)

	if not remote then
		return
	end

	return remote:InvokeServer(...)
end

function RemoteManager:InvokeClient(remoteName: string, player: Player, ...)
	local remote = self:GetFunction(remoteName)

	if not remote then
		return
	end

	return remote:InvokeClient(player, ...)
end

function RemoteManager:SetCallback(remoteName: string, callback: (...any) -> ...any)
	local remote = self:GetFunction(remoteName)

	if not remote then
		return
	end

	if IS_SERVER then
		remote.OnServerInvoke = callback
		return
	end

	remote.OnClientInvoke = callback
end

return RemoteManager
