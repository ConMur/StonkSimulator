local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local UpdatePlayerStats = ReplicatedStorage:WaitForChild("UpdatePlayerStats")

local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)
local Stats = require(script.Parent.Parent.Parent.Util.Stats)
local StockChart = require(script.Parent.StockChart)
local ValueIndicator = require(script.Parent.ValueIndicator)

local getXPosition = require(script.Parent.Util.getXPosition)
local getYPosition = require(script.Parent.Util.getYPosition)
local getCurrentStockValue = require(script.Parent.Util.getCurrentStockValue)
local Constants = require(script.Parent.Util.Constants)
local AudioPlayer = require(script.Parent.Parent.Parent.Util.AudioPlayer)

local INFO_FRAME_SIZE = 58

local StockChartScreen = Roact.PureComponent:extend("StockChartScreen")
StockChartScreen.defaultProps = {
	buttonText = "Click me to start a new game!"
}

function StockChartScreen:init()
	self.state = {
		currentStockValue = 0,
		currentTime = 0,
		active = true,
	}
	
	self.buyStock = function()
		if self.props.money >= self.state.currentStockValue then
			AudioPlayer.playAudio("Money_Sound")
			self.props.incrementStocks(1)
			self.props.decrementMoney(self.state.currentStockValue)
		end
	end
	
	self.sellStock = function()
		if self.props.stocks > 0 then
			AudioPlayer.playAudio("Money_Sound")
			self.props.decrementStocks(1)
			self.props.incrementMoney(self.state.currentStockValue)
		end
	end
	
	self.reset = function()
		self.props.resetChart()
		self:setState({
			currentStockValue = 0,
			currentTime = 0,
			active = false,
		})
		UpdatePlayerStats:FireServer(self.props.money, self.props.stocks)
		self.props.navigateToMainMenu()
	end
	
	self.onStep = function(timeElapsed, deltaTime)
		if self.state.active and self.props.chartData then
			if self.state.currentTime >= Constants.MaxTime then
					self.reset()
			else
				local newTime = math.min(self.state.currentTime + deltaTime, Constants.MaxTime)
				
				self:setState({
					currentTime = newTime,
					currentStockValue = getCurrentStockValue(newTime, self.props.chartData)
				})
			end
		end
	end
	
	self.chartSize, self.updateChartSize = Roact.createBinding(Vector2.new(0, 0))
	
	RunService.Stepped:Connect(self.onStep)
end

function StockChartScreen:render()
	local xPosition = getXPosition(self.state.currentTime, self.chartSize)
	
	return Roact.createElement("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
	}, {		
		layout = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		
		chartFrame = Roact.createElement("Frame", {
			BackgroundColor3 = Color3.new(100, 0, 100),
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 1, -INFO_FRAME_SIZE),
		}, {
			chart = self.props.chartData and Roact.createElement(StockChart, {
				ZIndex = 1,
				chartData = self.props.chartData,
				updateChartSize = self.updateChartSize,
			}),
			
			hidingFrame = self.props.chartData and Roact.createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(30, 30, 30),
				Size = UDim2.new(0, self.chartSize:getValue().X - xPosition, 1, -2),
				Position = UDim2.fromOffset(xPosition, 1),			
				ZIndex = 2,
			}),
			
			currentValueIndicator = self.props.chartData and Roact.createElement(ValueIndicator, {
				x = xPosition,
				y = getYPosition(self.state.currentStockValue, self.chartSize),
			}),
		}),
		
		infoFrame = Roact.createElement("Frame", {
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0, INFO_FRAME_SIZE),
		}, {
			layout = Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			
			stats = Roact.createElement(Stats, {
				LayoutOrder = 1,
				Size = UDim2.new(0.5, 0, 1, 0),
				money = self.props.money,
				stocks = self.props.stocks,
			}),
			
			buyButton = Roact.createElement("TextButton", {
				BackgroundColor3 = Color3.fromRGB(255, 30, 30),
				LayoutOrder = 2,
				Font = Enum.Font.Highway,
				Size = UDim2.new(0.25, 0, 1, 0),
				Text = string.format("Buy for %.2f", self.state.currentStockValue),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 20,
				
				[Roact.Event.Activated] = self.buyStock,
			}),
			
			sellButton = Roact.createElement("TextButton", {
				BackgroundColor3 = Color3.fromRGB(0, 200, 255),
				BorderSizePixel = 0,
				LayoutOrder = 3,
				Font = Enum.Font.Highway,
				Size = UDim2.new(0.25, 0, 1, 0),
				Text = string.format("Sell for %.2f", self.state.currentStockValue),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 20,
				
				[Roact.Event.Activated] = self.sellStock,
			}),
		})
		
	})
end

function StockChartScreen:didUpdate(previousProps, previousState)
	if previousProps.chartData ~= self.props.chartData and not previousState.active then
		self:setState({
			active = true,
		})
	end
end

StockChartScreen = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(StockChartScreen)

return StockChartScreen