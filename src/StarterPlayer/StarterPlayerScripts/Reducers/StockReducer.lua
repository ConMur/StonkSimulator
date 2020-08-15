local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)

local StockReducer = Rodux.createReducer(0, {
	IncrementStocks = function(state, action)
		return state + action.stocks
	end,
	DecrementStocks = function(state, action)
		return state - action.stocks
	end
})

return StockReducer