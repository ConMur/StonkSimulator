local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Roact)
local player = Players.LocalPlayer

local AVATAR_IMAGE_SIZE = 48
local AVATAR_IMAGE_PADDING = 10

local Stats = Roact.PureComponent:extend("Stats")
Stats.defaultProps = {
	LayoutOrder = 1,
	Size = UDim2.new(0.5, 0, 1, 0),
	money = 0,
	stocks = 0,
}

function Stats:init()
	-- Fetch the thumbnail
	local userId = player.UserId
	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size48x48
	
	spawn(function()
		local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
		
		if isReady then
			self:setState({
				avatarImage = content
			})
		end
	end)
end

function Stats:render()
	return Roact.createElement("Frame", {
		BackgroundTransparency = 1,
		LayoutOrder = self.props.LayoutOrder,
		Size = self.props.Size,
	}, {
		layout = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		
		imageFrame = Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = 1,
			Size = UDim2.new(0, AVATAR_IMAGE_SIZE + AVATAR_IMAGE_PADDING, 1, 0),
		}, {
			layout = Roact.createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			
			avatarImage = Roact.createElement("ImageLabel", {
				BackgroundTransparency = 1,
				Image = self.state.avatarImage,
				Size = UDim2.new(0, AVATAR_IMAGE_SIZE, 0, AVATAR_IMAGE_SIZE),
			})
		}),
		
		indicatorFrame = Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = 2,
			Size = UDim2.new(1, -48, 1, 0),
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
				moneyLabel = Roact.createElement("TextButton", {
					AutoButtonColor = false,
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
		}),
	})
end

return Stats