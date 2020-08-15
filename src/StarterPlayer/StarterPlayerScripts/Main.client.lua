local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScripts:WaitForChild("PlayerModule"))

local Roact = require(ReplicatedStorage.Roact)
local Rodux = require(ReplicatedStorage.Rodux)
local RoactRodux = require(ReplicatedStorage.RoactRodux)

local StockApp = require(PlayerScripts:WaitForChild("StockApp"))
local StockAppReducer = require(script.Parent.Reducers.StockAppReducer)
local AudioPlayer = require(script.Parent.Util.AudioPlayer)

-- Hide mobile jump + move UI
local Controls = PlayerModule:GetControls()
Controls:Disable()

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	
AudioPlayer.preloadAudio({
	["Money_Sound"] = 131886985
})

local store = Rodux.Store.new(StockAppReducer, {})

local app = Roact.createElement(RoactRodux.StoreProvider, {
	store = store,
}, {
	Main = Roact.createElement("ScreenGui", {}, {
		StockApp = Roact.createElement(StockApp)
	})
})

Roact.mount(app, LocalPlayer.PlayerGui)

--[[
	TODO:
	- Daily money grants on login
	- Acheviements/ purchaces for money (eg. why do people want to make money in this game?)
]]
