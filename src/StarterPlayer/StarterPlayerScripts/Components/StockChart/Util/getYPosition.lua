local Constants = require(script.Parent.Constants)

local function getYPosition(stockValue, chartSize)
	local height = chartSize:getValue().Y
	
	local y = height - ((height / Constants.MaxValue) * stockValue)
	
	return y 
end

return getYPosition