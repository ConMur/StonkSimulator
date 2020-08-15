local ReplicatedStorage = game:GetService("ReplicatedStorage")

local getStockData = ReplicatedStorage:WaitForChild("GetStockData")

local NUM_DATA_POINTS = 51
local MAX_VALUE = 100
local MIN_VALUE = 0

local function stockData()
	local rand = Random.new(os.time())
	
	local lastValue = rand:NextInteger(MIN_VALUE, MAX_VALUE)
	local data = {lastValue}
	for i = 2,NUM_DATA_POINTS do
		-- Get a random value between -10 and 10 excluding 0
		local randomValue = rand:NextInteger(-10, 10)
		while randomValue == 0 do
			randomValue = rand:NextInteger(-10, 10)
		end
		
		local nextValue = lastValue + randomValue
		
		-- Cap the values between 0 and 100
		if nextValue > MAX_VALUE then
			nextValue = lastValue - (2 * randomValue)
		elseif nextValue < MIN_VALUE then
			nextValue = lastValue + - (2 * randomValue)
		end
		
		table.insert(data, nextValue)
		lastValue = nextValue
	end
	
	return data
end

getStockData.OnServerInvoke = stockData