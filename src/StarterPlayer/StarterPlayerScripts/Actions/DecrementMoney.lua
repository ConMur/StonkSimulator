local function DecrementMoney(money)
	return {
		type = "DecrementMoney",
		money = money,
	}
end

return DecrementMoney