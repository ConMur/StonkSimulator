local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GetStockData = ReplicatedStorage:WaitForChild("GetStockData")
local ReceivedChartData = require(script.Parent.Parent.Parent.Actions.ReceivedChartData)
local NavigateToStockChart = require(script.Parent.Parent.Parent.Actions.NavigateToStockChart)
local NavigateToShop = require(script.Parent.Parent.Parent.Actions.NavigateToShop)

return function(dispatch)
	return {
		navigateToStockChart = function()
			dispatch(NavigateToStockChart())
		end,
		
		navigateToShop = function()
			dispatch(NavigateToShop())
		end,
		
	 	getChartData = function()
			local chartData = GetStockData:InvokeServer()
			dispatch(ReceivedChartData(chartData))
        end,
	}
end