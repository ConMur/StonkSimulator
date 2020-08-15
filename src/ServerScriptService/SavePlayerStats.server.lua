local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local UpdatePlayerStats = ReplicatedStorage:WaitForChild("UpdatePlayerStats")
local PlayerStatManager = require(ServerStorage:WaitForChild("PlayerStatManager"))

local function onSaveStats(player, money, stocks)
	PlayerStatManager:ChangeStat(player, "Money", money)
	PlayerStatManager:ChangeStat(player, "Stocks", stocks)
end

UpdatePlayerStats.OnServerEvent:Connect(onSaveStats)