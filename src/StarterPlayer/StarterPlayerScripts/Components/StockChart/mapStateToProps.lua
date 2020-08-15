return function(state, props)
    -- mapStateToProps is run every time the store's state updates.
    -- It's also run whenever the component receives new props.
	
	return {
		chartData = state.chartData,
		money = state.money,
		stocks = state.stocks,
	}
end