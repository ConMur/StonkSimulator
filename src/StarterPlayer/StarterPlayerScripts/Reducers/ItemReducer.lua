local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Rodux)

local initialState = {
	lambos = 0,
	houses = 0,
	planets = 0,
}

local ItemReducer = Rodux.createReducer(initialState, {
	IncrementLambos = function(state, action)
		return {
			lambos = state.lambos + action.lambos,
			houses = state.houses,
			planets = state.planets,
		}
	end,
	IncrementHouses = function(state, action)
		return {
			lambos = state.lambos,
			houses = state.houses + action.houses,
			planets = state.planets,
		}
	end,
	IncrementPlanets = function(state, action)
		return {
			lambos = state.lambos,
			houses = state.houses,
			planets = state.planets + action.planets,
		}
	end
})

return ItemReducer