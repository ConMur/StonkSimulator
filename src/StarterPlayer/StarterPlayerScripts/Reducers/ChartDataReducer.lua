local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)

local ChartDataReducer = Rodux.createReducer(nil, {
	ReceivedChartData = function(state, action)
		return action.chartData
	end,
	ResetChart = function(state, action)
		return nil
	end,
})

return ChartDataReducer