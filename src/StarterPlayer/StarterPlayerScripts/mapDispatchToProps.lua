local IncrementStocks = require(script.Parent.Actions.IncrementStocks)
local IncrementMoney = require(script.Parent.Actions.IncrementMoney)

return function(dispatch)
	return {
		onStatsReceived = function(money, stocks)
			dispatch(IncrementMoney(money))
			dispatch(IncrementStocks(stocks))
		end,
	}
end