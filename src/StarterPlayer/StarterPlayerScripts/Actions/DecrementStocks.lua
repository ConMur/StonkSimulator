local function DecrementStocks(stocks)
	return {
		type = "DecrementStocks",
		stocks = stocks,
	}
end

return DecrementStocks