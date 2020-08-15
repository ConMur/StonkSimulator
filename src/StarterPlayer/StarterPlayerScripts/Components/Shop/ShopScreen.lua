local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local ShopScreen = Roact.PureComponent:extend("ShopScreen")

local TEN_STONKS_PRODUCT_ID = 1076048570

function ShopScreen:init()
	self.onGoBack = function()
		self.props.navigateToMainMenu()
	end
	
	self.onBuyStock = function()
		local player = Players.LocalPlayer
		MarketplaceService:PromptProductPurchase(player, TEN_STONKS_PRODUCT_ID)
	end
end

function ShopScreen:render()
	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
	}, {
		layout = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
		
		buyLamboButton = Roact.createElement("TextButton", {
			LayoutOrder = 1,
			Size = UDim2.new(0, 100, 0, 50),
			Text = "Buy lambo for $100,000"
		}),
		
		buyHouseButton = Roact.createElement("TextButton", {
			LayoutOrder = 2,
			Size = UDim2.new(0, 100, 0, 50),
			Text = "Buy house for $10,000,000"
		}),
		
		buyEarthButton = Roact.createElement("TextButton", {
			LayoutOrder = 3,
			Size = UDim2.new(0, 100, 0, 50),
			Text = "Buy the planet for $1,000,000,000"
		}),
		
		buyMoneyButton = Roact.createElement("TextButton", {
			LayoutOrder = 4,
			Size = UDim2.new(0, 100, 0, 50),
			Text = "Buy 10 stocks for R$100",
			
			[Roact.Event.Activated] = self.onBuyStock,
		}),
		
		goBackButton = Roact.createElement("TextButton", {
			LayoutOrder = 5,
			Size = UDim2.new(0, 100, 0, 50),
			Text = "Go back to the main menu",
			
			[Roact.Event.Activated] = self.onGoBack,
		}),
	})
end

ShopScreen = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(ShopScreen)

return ShopScreen