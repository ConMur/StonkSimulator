local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)
local ChartDataReducer = require(script.Parent.ChartDataReducer)
local ItemReducer = require(script.Parent.ItemReducer)
local MoneyReducer = require(script.Parent.MoneyReducer)
local StockReducer = require(script.Parent.StockReducer)
local ScreenReducer = require(script.Parent.ScreenReducer)

local StockAppReducer = Rodux.combineReducers({
	chartData = ChartDataReducer,
	money = MoneyReducer,
	stocks = StockReducer,
	items = ItemReducer,
	activeScreen = ScreenReducer,
})

return StockAppReducer