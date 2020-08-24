local NavigateToMainMenu = require(script.Parent.Parent.Parent.Actions.NavigateToMainMenu)
local DecrementMoney = require(script.Parent.Parent.Parent.Actions.DecrementMoney)
local IncrementLambos = require(script.Parent.Parent.Parent.Actions.Item.IncrementLambos)
local IncrementHouses = require(script.Parent.Parent.Parent.Actions.Item.IncrementHouses)
local IncrementPlanets = require(script.Parent.Parent.Parent.Actions.Item.IncrementPlanets)

return function(dispatch)
	return {
		navigateToMainMenu = function()
			dispatch(NavigateToMainMenu())
		end,
		
		buyLambo = function(price)
			dispatch(DecrementMoney(price))
			dispatch(IncrementLambos(1))
		end,
		
		buyHouse = function(price)
			dispatch(DecrementMoney(price))
			dispatch(IncrementHouses(1))
		end,
		
		buyPlanet = function(price)
			dispatch(DecrementMoney(price))
			dispatch(IncrementPlanets(1))
		end,
	}
end