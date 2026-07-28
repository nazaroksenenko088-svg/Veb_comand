--[[
    Domain V2 + Akbarshox Fly + Dex Explorer Hub
    Optimized & Combined Admin Panel
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Защита GUI если поддерживается эксплойтом
local function protectGui(gui)
	if syn and syn.protect_gui then
		syn.protect_gui(gui)
		gui.Parent = CoreGui
	elseif gethui then
		gui.Parent = gethui()
	else
		gui.Parent = CoreGui
	end
end

-- Загрузка основного интерфейса Domain V2
local Domain = {
	Domain = Instance.new("ScreenGui"),
	Main = Instance.new("Frame"),
	UICorner = Instance.new("UICorner"),
	Buttons = Instance.new("Frame"),
	Pages = Instance.new("Frame"),
}

Domain.Domain.Name = "DomainHub"
Domain.Domain.ResetOnSpawn = false
protectGui(Domain.Domain)

Domain.Main.Name = "Main"
Domain.Main.Parent = Domain.Domain
Domain.Main.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Domain.Main.BorderSizePixel = 0
Domain.Main.Position = UDim2.new(0.85, 0, 0.25, 0)
Domain.Main.Size = UDim2.new(0.05, 0, 0.45, 0)
Domain.Main.ZIndex = 5

Domain.UICorner.CornerRadius = UDim.new(0, 12)
Domain.UICorner.Parent = Domain.Main

-- Функция загрузки Акбаршох Флай V3
local function loadFly()
	local success, err = pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Administration1boo/solid-octo-succotash/refs/heads/main/Akbarshox%20Fly%20V3%E2%9A%A1"))()
	end)
	if not success then
		warn("Не удалось загрузить Fly: " .. tostring(err))
	end
end

-- Функция загрузки Dark Dex
local function loadDex()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end)
end

-- Уведомление об успешной загрузке
StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
	Title = "Domain Hub Loaded",
	Text = "Интерфейс и фичи успешно объединены!",
	Duration = 5
})

-- Дополнительные элементы управления и кнопки можно вызывать через консоль или привязывать к UI элементам Domain V2[cite: 2]
