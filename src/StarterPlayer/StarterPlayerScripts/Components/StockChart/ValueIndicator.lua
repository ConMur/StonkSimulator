local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)

local ValueIndicator = Roact.PureComponent:extend("ValueIndicator")

ValueIndicator.defaultProps = {
	x = 0,
	y = 0,
	Color = Color3.new(0, 100, 0),
	Size = UDim2.fromOffset(10, 10),
	ZIndex = 5,
}

function ValueIndicator:render()
	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = self.props.Color,
		Size = self.props.Size,
		Position = UDim2.fromOffset(self.props.x, self.props.y),
		ZIndex = self.props.ZIndex,
	})
end

return ValueIndicator