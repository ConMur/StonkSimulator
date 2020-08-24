local IncrementStocks = require(script.Parent.Actions.IncrementStocks)
local IncrementMoney = require(script.Parent.Actions.IncrementMoney)
local IncrementLambos = require(script.Parent.Actions.Item.IncrementLambos)
local IncrementHouses = require(script.Parent.Actions.Item.IncrementHouses)
local IncrementPlanets = require(script.Parent.Actions.Item.IncrementPlanets)

return function(dispatch)
	return {
		onStatsReceived = function(money, stocks, lambos, houses, planets)
			dispatch(IncrementMoney(money))
			dispatch(IncrementStocks(stocks))
			dispatch(IncrementLambos(lambos))
			dispatch(IncrementHouses(houses))
			dispatch(IncrementPlanets(planets))
		end,
	}
end