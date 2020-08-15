local ResetChart = require(script.Parent.Parent.Parent.Actions.ResetChart)
local NavigateToMainMenu = require(script.Parent.Parent.Parent.Actions.NavigateToMainMenu)
local IncrementStocks = require(script.Parent.Parent.Parent.Actions.IncrementStocks)
local DecrementStocks = require(script.Parent.Parent.Parent.Actions.DecrementStocks)
local IncrementMoney = require(script.Parent.Parent.Parent.Actions.IncrementMoney)
local DecrementMoney = require(script.Parent.Parent.Parent.Actions.DecrementMoney)

return function(dispatch)
    -- mapDispatchToProps only runs once, so create functions here!
    return {		
		resetChart = function()
			dispatch(ResetChart())
		end,
		
		navigateToMainMenu = function()
			dispatch(NavigateToMainMenu())
		end,
		
		incrementStocks = function(amount)
			dispatch(IncrementStocks(amount))
		end,
		
		decrementStocks = function(amount)
			dispatch(DecrementStocks(amount))
		end,
		
		incrementMoney = function(amount)
			dispatch(IncrementMoney(amount))
		end,
		
		decrementMoney = function(amount)
			dispatch(DecrementMoney(amount))
		end,
    }
end