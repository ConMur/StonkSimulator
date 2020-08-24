local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local UpdateItemCounts = ReplicatedStorage:WaitForChild("UpdateItemCounts")

local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local Stats = require(script.Parent.Parent.Parent.Util.Stats)

local ShopScreen = Roact.PureComponent:extend("ShopScreen")
ShopScreen.defaultProps = {
	lambos = 0,
	houses = 0,
	planets = 0,
}

local TEN_STONKS_PRODUCT_ID = 1076048570
local STATS_FRAME_HEIGHT = 58

local LAMBO_PRICE = 100000
local HOUSE_PRICE = 10000000
local PLANET_PRICE = 1000000000

function ShopScreen:init()
	self.onGoBack = function()
		self.props.navigateToMainMenu()
	end
	
	self.onBuyLambo = function()
		if self.props.money >= LAMBO_PRICE then
			UpdateItemCounts:FireServer(self.props.lambos + 1, self.props.houses, self.props.planets)
			self.props.buyLambo(LAMBO_PRICE)
		end
	end
	
	self.onBuyHouse = function()
		if self.props.money >= HOUSE_PRICE then
			UpdateItemCounts:FireServer(self.props.lambos, self.props.houses + 1, self.props.planets)
			self.props.buyHouse(HOUSE_PRICE)
		end
	end
	
	self.onBuyPlanet = function()
		if self.props.money >= PLANET_PRICE then
			UpdateItemCounts:FireServer(self.props.lambos, self.props.houses, self.props.planets + 1)
			self.props.buyPlanet(PLANET_PRICE)
		end
	end
	
	self.onBuyStock = function()
		local player = Players.LocalPlayer
		MarketplaceService:PromptProductPurchase(player, TEN_STONKS_PRODUCT_ID)
	end
end

function ShopScreen:render()
	return Roact.createElement("ImageLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://1192078826",
		ImageColor3 = Color3.fromRGB(30, 30, 30),
	}, {
		layout = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
		
		shopFrame = Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 1, -STATS_FRAME_HEIGHT),
		}, {
			layout = Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			
			titleFrame = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 0.2, 0),
			}, {
				layout = Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 10),
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
			
				title = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					LayoutOrder = 1,
					Size = UDim2.new(1, 0, 0.5, 0),
					Font = Enum.Font.Highway,
					Text = "Shop",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 70,
				}),
			}),
			
			shopContents = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0.6, 0),
			}, {
				layout = Roact.createElement("UIGridLayout", {
					CellPadding = UDim2.new(0, 10, 0, 10),
					CellSize = UDim2.new(0.5, -10, 0.5, -10),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
				
				buyLamboImage = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://25320186",
					LayoutOrder = 1,
				}, {
					buyLamboButton = Roact.createElement("TextButton", {
						BackgroundTransparency = 0.5,
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						Font = Enum.Font.Highway,
						Size = UDim2.new(1, 0, 1, 0),
						Text = string.format("Buy lambo for $100,000\nNumber Owned: %d", self.props.lambos),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 20,
						
						[Roact.Event.Activated] = self.onBuyLambo,
					}),
				}),
				
				buyHouseImage = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://179469787",
					LayoutOrder = 2,
				}, {
					buyHouseButton = Roact.createElement("TextButton", {
						BackgroundTransparency = 0.5,
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						Font = Enum.Font.Highway,
						Size = UDim2.new(1, 0, 1, 0),
						Text = string.format("Buy house for $10,000,000\nNumber Owned: %d", self.props.houses),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 20,
						
						[Roact.Event.Activated] = self.onBuyHouse,
					}),
				}),
				
				buyPlanetImage = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://2013469",
					LayoutOrder = 3,
				}, {
					buyPlanetButton = Roact.createElement("TextButton", {
						BackgroundTransparency = 0.5,
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						Font = Enum.Font.Highway,
						Size = UDim2.new(1, 0, 1, 0),
						Text = string.format("Buy the planet for $1,000,000,000\nNumber Owned: %d", self.props.planets),
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 20,
						
						[Roact.Event.Activated] = self.onBuyPlanet,
					}),
				}),
				
				buyMoneyImage = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://45478730",
					LayoutOrder = 4,
				}, {
					buyMoneyButton = Roact.createElement("TextButton", {
						BackgroundTransparency = 0.5,
						BackgroundColor3 = Color3.fromRGB(30, 30, 30),
						Font = Enum.Font.Highway,
						Size = UDim2.new(1, 0, 1, 0),
						Text = "Buy 10 Stonks for R$100",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 20,
						
						[Roact.Event.Activated] = self.onBuyStock,
					}),
				}),
			}),
			
			navFrame = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				Size = UDim2.new(1, 0, 0.2, 0),
			}, {
				layout = Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				}),
				
				goBackButton = Roact.createElement("TextButton", {
					BackgroundColor3 = Color3.fromRGB(255, 30, 30),
					Font = Enum.Font.Highway,
					LayoutOrder = 1,
					Size = UDim2.new(0.3, 0, 0.75, 0),
					Text = "Main Menu",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 40,
					
					[Roact.Event.Activated] = self.onGoBack,
				}),
			}),
		}),
		
		statsFrame = Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, STATS_FRAME_HEIGHT),
		}, {
			layout = Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			
			stats = Roact.createElement(Stats, {
				LayoutOrder = 1,
				Size = UDim2.new(1, 0, 1, 0),
				money = self.props.money,
				stocks = self.props.stocks,
			}),
		})
	})
end

ShopScreen = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(ShopScreen)

return ShopScreen