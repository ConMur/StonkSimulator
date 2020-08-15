local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)

local MoneyReducer = Rodux.createReducer(0, {
	IncrementMoney = function(state, action)
		return state + action.money
	end,
	DecrementMoney = function(state, action)
		return state - action.money
	end
})

return MoneyReducer