local function IncrementStocks(stocks)
	return {
		type = "IncrementStocks",
		stocks = stocks,
	}
end

return IncrementStocks