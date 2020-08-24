local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
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

-- Custom top bar
-- Hide the topbar
PlayerGui:SetTopbarTransparency(1)
 
-- Create a "Fake" replacement topbar with a ScreenGui and Frame
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
 
-- Move (0, 0) to the actual top left corner of the screen, instead of under the topbar
screenGui.IgnoreGuiInset = true
-- The topbar is 36 pixels tall, and spans the entire width of the screen
frame.Size = UDim2.new(1, 0, 0, 36) 
-- Style the topbar
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
 
frame.Parent = screenGui
screenGui.Parent = PlayerGui
	
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
	- leader board
	- Acheviements/ purchaces for money (eg. why do people want to make money in this game?)
]]
