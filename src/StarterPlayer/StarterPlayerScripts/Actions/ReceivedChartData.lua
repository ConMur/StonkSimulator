local function ReceivedChartData(chartData)
	return {
		type = "ReceivedChartData",
		chartData = chartData,
	}
end

return ReceivedChartData