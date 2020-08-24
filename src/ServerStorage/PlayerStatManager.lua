-- Set up table to return to any script that requires this module script
local PlayerStatManager = {}

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local playerData = DataStoreService:GetDataStore("PlayerData")
local SendPlayerStats = ReplicatedStorage:WaitForChild("SendPlayerStats")
 
-- Table to hold player information for the current session
local sessionData = {}
 
local AUTOSAVE_INTERVAL = 60
 
-- Function that other scripts can call to change a player's stats
function PlayerStatManager:ChangeStat(player, statName, value)
	local playerUserId = "Player_" .. player.UserId
	local sessionDataType = typeof(sessionData[playerUserId][statName])
	local valueType = typeof(value)
	-- Allow nil values to be overwritten
	if sessionDataType ~= nil then
		assert(sessionDataType == valueType, "ChangeStat error: types do not match (" .. tostring(sessionDataType) .. " and " .. tostring(valueType) .. ")")
	end
	sessionData[playerUserId][statName] = value
end

-- Function that other scripts can call to examine a player's stats
function PlayerStatManager:GetStat(player, statName)
	local playerUserId = "Player_" .. player.UserId
	if sessionData[playerUserId] then
		return sessionData[playerUserId][statName]
	end
	return nil
end
 
-- Function to add player to the "sessionData" table
local function setupPlayerData(player)
	local playerUserId = "Player_" .. player.UserId
	local success, data = pcall(function()
		return playerData:GetAsync(playerUserId)
	end)
	
	if success then
		if data then
			-- Data exists for this player
			sessionData[playerUserId] = data
		else
			-- Data store is working, but no current data for this player
			sessionData[playerUserId] = {Money=100, Stocks=0, Lambos=0, Houses=0, Planets=0}
		end
		
		-- Send the data to the client
		SendPlayerStats:FireClient(player, 
			sessionData[playerUserId].Money or 0, 
			sessionData[playerUserId].Stocks or 0,
			sessionData[playerUserId].Lambos or 0, 
			sessionData[playerUserId].Houses or 0, 
			sessionData[playerUserId].Planets or 0)
	end
end

local function savePlayerData(playerUserId)
	if sessionData[playerUserId] then
		local tries = 0
		local success
		repeat
			success = pcall(function()
				playerData:SetAsync(playerUserId, sessionData[playerUserId])
			end)
			if not success then wait(1) end
		until tries == 3 or success
		if not success then
			warn("Cannot save data for player!")
		end
	end
end
 
-- Function to save player data on exit
local function saveOnExit(player)
	local playerUserId = "Player_" .. player.UserId
	savePlayerData(playerUserId)
end

-- Function to periodically save player data
local function autoSave()
	while wait(AUTOSAVE_INTERVAL) do
		for playerUserId, data in pairs(sessionData) do
			savePlayerData(playerUserId)
		end
	end
end

-- Start running "autoSave()" function in the background
spawn(autoSave)
 
-- Connect "setupPlayerData()" function to "PlayerAdded" event
game.Players.PlayerAdded:Connect(setupPlayerData)

-- Connect "saveOnExit()" function to "PlayerRemoving" event
game.Players.PlayerRemoving:Connect(saveOnExit)
 
return PlayerStatManager
