local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local StockChartScreen = require(script.Parent.Components.StockChart.StockChartScreen)
local MainMenuScreen = require(script.Parent.Components.MainMenu.MainMenuScreen)
local ShopScreen = require(script.Parent.Components.Shop.ShopScreen)
local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local SendPlayerStats = ReplicatedStorage:WaitForChild("SendPlayerStats")

local StockApp = Roact.PureComponent:extend("StockApp")

function StockApp:init()
	SendPlayerStats.OnClientEvent:Connect(self.props.onStatsReceived)
end

function StockApp:render()
	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0)
	}, {
		stockChart = self.props.activeScreen == "StockChartScreen" and Roact.createElement(StockChartScreen),
		mainMenu = self.props.activeScreen == "MainMenuScreen" and Roact.createElement(MainMenuScreen),
		shop = self.props.activeScreen == "ShopScreen" and Roact.createElement(ShopScreen),
	})
end

StockApp = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(StockApp)

return StockApp