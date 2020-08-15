local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Roact)
local Constants = require(script.Parent.Util.Constants)

local StockChart = Roact.PureComponent:extend("StockChart")


StockChart.defaultProps = {
	lineThickness = 2,
}

function StockChart:init()
	self.state = {
		width = 0,
		height = 0,
	}
	
	self.createLine = function(startPoint, endPoint)
		local size = UDim2.new(0, ((endPoint.X - startPoint.X) ^ 2 + (endPoint.Y - startPoint.Y) ^ 2) ^ 0.5, 0, self.props.lineThickness) 
		local position = UDim2.new(0, (startPoint.X + endPoint.X) / 2, 0, (startPoint.Y + endPoint.Y) / 2) 
		local rotation = math.atan2(endPoint.Y - startPoint.Y, endPoint.X - startPoint.X) * (180 / math.pi)

		local line = Roact.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(200, 200, 200),
			Position = position,
			Rotation = rotation,
			Size = size,
		})
		
		return line
	end
	
	self.createLines = function()
		if #self.props.chartData == 0 then
			return
		end
		
		local lines = {}
		local xDelta = self.state.width / (#self.props.chartData - 1)
		local yDelta = self.state.height / Constants.MaxValue
		local currentX = 0
		
		for i = 1,(#self.props.chartData - 1) do
			local startPoint = Vector2.new(currentX, self.state.height - (self.props.chartData[i] * yDelta))
			local endPoint = Vector2.new(currentX + xDelta, self.state.height - (self.props.chartData[i + 1] * yDelta))
			
			table.insert(lines, self.createLine(startPoint, endPoint))
			
			currentX = currentX + xDelta
		end
		
		return Roact.createFragment(lines)
	end
	
	self.onSizeChanged = function(rbx)
		self.props.updateChartSize(rbx.AbsoluteSize)
		
		self:setState({
			width = rbx.AbsoluteSize.X,
			height = rbx.AbsoluteSize.Y,
		})
	end
end

function StockChart:render()
	return Roact.createElement("Frame", {
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		Size = UDim2.new(1, 0, 1, 0),
		
		[Roact.Change.AbsoluteSize] = self.onSizeChanged,
	}, {
		lines = self.createLines(),
	})
end

return StockChart