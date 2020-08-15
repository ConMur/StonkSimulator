local function getCurrentStockValue(currentTime, chartData)
	local segmentNum = math.floor(currentTime) + 1
	local y1 = chartData[segmentNum]
	local y2 = chartData[segmentNum + 1]
	
	if y2 == nil then
		return y1	
	end
	
	-- y = mx + b
	local slope = y2 - y1
	local dist = currentTime - (segmentNum - 1)
	local value = slope * dist + y1

	return value
end

return getCurrentStockValue
