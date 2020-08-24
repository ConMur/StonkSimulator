local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local UpdateItemCounts = ReplicatedStorage:WaitForChild("UpdateItemCounts")
local PlayerStatManager = require(ServerStorage:WaitForChild("PlayerStatManager"))

local function onUpdateCounts(player, lambos, houses, planets)
	PlayerStatManager:ChangeStat(player, "Lambos", lambos)
	PlayerStatManager:ChangeStat(player, "Houses", houses)
	PlayerStatManager:ChangeStat(player, "Planets", planets)
end

UpdateItemCounts.OnServerEvent:Connect(onUpdateCounts)