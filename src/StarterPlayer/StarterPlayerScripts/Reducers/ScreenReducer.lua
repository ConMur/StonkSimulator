local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)

local ScreenReducer = Rodux.createReducer("MainMenuScreen", {
	NavigateToMainMenu = function(state, action)
		return action.screenName
	end,
	NavigateToStockChart = function(state, action)
		return action.screenName
	end,
	NavigateToShop = function(state, action)
		return action.screenName
	end
})

return ScreenReducer