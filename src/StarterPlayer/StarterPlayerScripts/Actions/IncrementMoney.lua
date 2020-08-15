local function IncrementMoney(money)
	return {
		type = "IncrementMoney",
		money = money,
	}
end

return IncrementMoney