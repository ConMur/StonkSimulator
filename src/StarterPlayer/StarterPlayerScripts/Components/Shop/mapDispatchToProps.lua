local NavigateToMainMenu = require(script.Parent.Parent.Parent.Actions.NavigateToMainMenu)

return function(dispatch)
	return {
		navigateToMainMenu = function()
			dispatch(NavigateToMainMenu())
		end,
	}
end