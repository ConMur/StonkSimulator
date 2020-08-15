local Constants = require(script.Parent.Constants)

-- currentTime is a value between 1 and 50
local function getXPosition(currentTime, chartSize)	
	local size = chartSize:getValue()
	local width = size.X
	local height = size.Y
	
	local x = (width / Constants.MaxTime) * currentTime
	
	return x
end

return getXPosition
