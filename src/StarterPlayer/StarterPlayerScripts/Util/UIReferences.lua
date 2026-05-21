local UIReferences = {}
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

function UIReferences:WaitForDescendants(root, ...)
	local names = { ... }
	local current = root

	for _, name in ipairs(names) do
		current = current:WaitForChild(name)

		while not current do
			current = current:WaitForChild(name)
		end
	end

	return current
end

function UIReferences:GetReference(referenceName: string)
	local playerGui = player:WaitForChild("PlayerGui")

	UIReferences:WaitForDescendants(player, "PlayerGui")

	local taggedObjects = CollectionService:GetTagged(referenceName)

	if #taggedObjects > 2 then
		warn("More than one object found with the tag:", referenceName)
		return
	end

	for _, obj in ipairs(taggedObjects) do
		if obj:IsDescendantOf(playerGui) then
			return obj
		end
	end

	local thread = coroutine.running()
	local connection

	connection = CollectionService:GetInstanceAddedSignal(referenceName):Connect(function(obj)
		if obj:IsDescendantOf(playerGui) then
			connection:Disconnect()
			coroutine.resume(thread, obj)
		end
	end)

	return coroutine.yield()
end

return UIReferences
