local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local mapStateToProps = require(script.Parent.mapStateToProps)
local mapDispatchToProps = require(script.Parent.mapDispatchToProps)

local MainMenuScreen = Roact.PureComponent:extend("MainMenuScreen")

local START_TRADING_BUTTON_TEXT = "Start Trading!"
local BUTTON_PADDING = 20

function MainMenuScreen:init()
	self.onClickNewGame = function()
		if not self.props.chartData then
			self.props.getChartData()
		end
		self.props.navigateToStockChart()
	end
	
	self.onClickShopButton = function()
		self.props.navigateToShop()
	end
	
	self.getButtonWidth = function()
		local textWidth = TextService:GetTextSize(START_TRADING_BUTTON_TEXT, 40, Enum.Font.Highway, Vector2.new(10000, 0)).X
		return textWidth + 2*BUTTON_PADDING
	end
end

function MainMenuScreen:render()
	local buttonWidth = self.getButtonWidth()
	
	return Roact.createElement("ImageLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		Image = "rbxassetid://1192078826",
		ImageColor3 = Color3.fromRGB(30, 30, 30),
	}, {
		layout = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 10),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
		}),
		
		titleFrame = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0.5, 0),
			Font = Enum.Font.Highway,
			Text = "Stonk Simulator",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 100,
		}),
		
		buttonFrame = Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0.5, 0),
		}, {
			padding = Roact.createElement("UIPadding", {
				PaddingBottom = UDim.new(0, 10),	
			}),
			
			layout = Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
			}),
			
			newGameButton = Roact.createElement("TextButton", {
				BackgroundColor3 = Color3.fromRGB(255, 30, 30),
				LayoutOrder = 2,
				Font = Enum.Font.Highway,
				Size = UDim2.new(0, buttonWidth, 0.25, 0),
				Text = START_TRADING_BUTTON_TEXT,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 40,
				
				[Roact.Event.Activated] = self.onClickNewGame,
			}),
			
			shopButton = Roact.createElement("TextButton", {
				BackgroundColor3 =  Color3.fromRGB(0, 200, 255),
				LayoutOrder = 3,
				Font = Enum.Font.Highway,
				Size = UDim2.new(0, buttonWidth, 0.25, 0),
				Text = "Shop",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 40,
				
				[Roact.Event.Activated] = self.onClickShopButton,
			}),
		}),
	})
end

MainMenuScreen = RoactRodux.connect(mapStateToProps, mapDispatchToProps)(MainMenuScreen)

return MainMenuScreen