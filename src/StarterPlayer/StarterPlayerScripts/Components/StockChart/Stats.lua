local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)

local Stats = Roact.PureComponent:extend("Stats")
Stats.defaultProps = {
	LayoutOrder = 1,
	Size = UDim2.new(0.5, 0, 1, 0),
	money = 0,
	stocks = 0,
}

function Stats:render()
	return Roact.createElement("Frame", {
		BackgroundTransparency = 1,
		LayoutOrder = self.props.LayoutOrder,
		Size = self.props.Size,
	}, {
		layout = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		
		moneyIndicator = Roact.createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			LayoutOrder = 1,
			Size = UDim2.new(1, 0, 0.5, 0),
		}, {			
			moneyLabel = Roact.createElement("TextLabel", {
				Font = Enum.Font.Highway,
				Text = string.format("Money: $%.2f", self.props.money),
				TextColor3 = Color3.fromRGB(255, 210, 0),
				TextSize = 20,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
			}),
		}),
		
		stocksIndicator = Roact.createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Size = UDim2.new(1, 0, 0.5, 0),
		}, {			
			stocksLabel = Roact.createElement("TextLabel", {
				AnchorPoint = Vector2.new(0, 0),
				Font = Enum.Font.Highway,
				Text = string.format("Stonks: %d", self.props.stocks),
				TextColor3 = Color3.fromRGB(255, 210, 0),
				TextSize = 20,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
			}),
		}),
	})
end

return Stats