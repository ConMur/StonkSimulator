local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local PlayerStatManager = require(ServerStorage:WaitForChild("PlayerStatManager"))

local SendPlayerStats = ReplicatedStorage:WaitForChild("SendPlayerStats")

-- Data store for tracking purchases that were successfully processed
local purchaseHistoryStore = DataStoreService:GetDataStore("PurchaseHistory")
 
-- Table setup containing product IDs and functions for handling purchases
local productFunctions = {}
-- ProductId 1076048570 for 10 stonks
productFunctions[1076048570] = function(receipt, player)
	-- Update the server's stats for this player
	local numStocks = PlayerStatManager:GetStat(player, "Stocks")
	PlayerStatManager:ChangeStat(player, "Stocks", numStocks + 10)
	-- Update the player about their stocks
	SendPlayerStats:FireClient(player, 0, 10)
end
 
-- The core 'ProcessReceipt' callback function
local function processReceipt(receiptInfo)
	-- Determine if the product was already granted by checking the data store  
	local playerProductKey = receiptInfo.PlayerId .. "_" .. receiptInfo.PurchaseId
	local purchased = false
	local success, errorMessage = pcall(function()
		purchased = purchaseHistoryStore:GetAsync(playerProductKey)
	end)
	-- If purchase was recorded, the product was already granted
	if success and purchased then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	elseif not success then
		error("Data store error:" .. errorMessage)
	end
 
	-- Find the player who made the purchase in the server
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		-- The player probably left the game
		-- If they come back, the callback will be called again
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	-- Look up handler function from 'productFunctions' table above
	local handler = productFunctions[receiptInfo.ProductId]
 
	-- Call the handler function and catch any errors
	local success, result = pcall(handler, receiptInfo, player)
	if not success or not result then
		warn("Error occurred while processing a product purchase")
		print("\nProductId:", receiptInfo.ProductId)
		print("\nPlayer:", player)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
 
	-- Record transaction in data store so it isn't granted again
	local success, errorMessage = pcall(function()
		purchaseHistoryStore:SetAsync(playerProductKey, true)
	end)
	if not success then
		error("Cannot save purchase data: " .. errorMessage)
	end
 
	-- IMPORTANT: Tell Roblox that the game successfully handled the purchase
	return Enum.ProductPurchaseDecision.PurchaseGranted
end
 
-- Set the callback; this can only be done once by one script on the server! 
MarketplaceService.ProcessReceipt = processReceipt

