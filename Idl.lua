-- ==========================================
-- DOMAIN HUB: OPEN-SOURCE LOADER ARCHITECTURE
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Инициализация глобального окружения для модулей (как в лучших открытых либах)
getgenv().DomainHub = {
    Version = "3.0",
    Settings = {
        FlySpeed = 50,
        AnimSpeed = 1,
        TargetPlayer = ""
    },
    Modules = {}
}

local Hub = getgenv().DomainHub

-- Утилита создания элементов
local function Create(className, properties, parent)
    local element = Instance.new(className)
    for i, v in pairs(properties) do
        element[i] = v
    end
    if parent then element.Parent = parent end
    return element
end

-- Безопасный вызов (защита от краша планшета)
local function SafeExecute(name, func)
    local success, err = pcall(func)
    if not success then
        warn("❌ [Domain Hub Error] " .. tostring(name) .. ": " .. tostring(err))
    else
        print("✅ [Domain Hub] Loaded: " .. tostring(name))
    end
end

-- Создание главного окна
local ScreenGui = Create("ScreenGui", {Name = "DomainHubOpenSource", ResetOnSpawn = false})
if syn and syn.protect_gui then syn.protect_gui(ScreenGui) end
ScreenGui.Parent = CoreGui

local Main = Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
    Size = UDim2.new(0, 500, 0, 320),
    Position = UDim2.new(0.5, -250, 0.5, -160)
}, ScreenGui)
Create("UICorner", {CornerRadius = UDim.new(0, 8)}, Main)

-- Меню категорий (Слева)
local CategoryContainer = Create("ScrollingFrame", {
    Size = UDim2.new(0.28, 0, 1, 0),
    BackgroundTransparency = 1,
    CanvasSize = UDim2.new(0, 0, 1.5, 0)
}, Main)

-- Рабочая зона (Справа)
local WorkspaceArea = Create("Frame", {
    Size = UDim2.new(0.72, 0, 1, 0),
    Position = UDim2.new(0.28, 0, 0, 0),
    BackgroundTransparency = 1
}, Main)

local function MakeCategory(name)
    local page = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
        CanvasSize = UDim2.new(0, 0, 2, 0)
    }, WorkspaceArea)
    
    local btn = Create("TextButton", {
        Size = UDim2.new(0.9, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = name,
        Font = Enum.Font.SourceSansBold
    }, CategoryContainer)
    Create("UICorner", {CornerRadius = UDim.new(0, 6)}, btn)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(WorkspaceArea:GetChildren()) do
            p.Visible = false
        end
        page.Visible = true
    end)
    
    return page
end

-- Категории хаба
local TabMain = MakeCategory("Главная")
local TabScripts = MakeCategory("Скрипты & Читы")
local TabConfig = MakeCategory("Тонкие настройки")
TabMain.Visible = true

-- Функция добавления кнопок
local function AddAction(page, text, callback)
    local btn = Create("TextButton", {
        Size = UDim2.new(0.9, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = text,
        Font = Enum.Font.SourceSansBold
    }, page)
    Create("UICorner", {CornerRadius = UDim.new(0, 6)}, btn)
    btn.MouseButton1Click:Connect(function()
        SafeExecute(text, callback)
    end)
end

-- Функция добавления тонкой настройки (инпут для изменения параметров)
local function AddConfigInput(page, labelText, settingKey)
    Create("TextLabel", {
        Size = UDim2.new(0.9, 0, 0, 20),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(180, 180, 180),
        Text = labelText,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.SourceSans
    }, page)
    
    local box = Create("TextBox", {
        Size = UDim2.new(0.9, 0, 0, 30),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = tostring(Hub.Settings[settingKey]),
        Font = Enum.Font.SourceSansBold
    }, page)
    Create("UICorner", {CornerRadius = UDim.new(0, 6)}, box)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text) or box.Text
        Hub.Settings[settingKey] = val
        print("⚙️ Обновлен параметр " .. settingKey .. " -> " .. tostring(val))
    end)
end

-- ==========================================
-- ИНТЕГРАЦИЯ БАЗЫ СКРИПТОВ ПОД ОПЕНСОРС ЛОГИКУ
-- ==========================================

-- 1. Fly[cite: 29]
AddAction(TabScripts, "Запустить Fly V3", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Administration1boo/solid-octo-succotash/refs/heads/main/Akbarshox%20Fly%20V3%E2%9A%A1"))()
end)

-- 2. Анимация[cite: 31] с привязкой к настройке скорости
AddAction(TabScripts, "Запустить ID Анимацию", function()
    local Char = Player.Character or Player.CharacterAdded:Wait()
    local Hum = Char:FindFirstChildOfClass("Humanoid")
    local Anim = Instance.new("Animation")
    Anim.AnimationId = "rbxassetid://72042024"
    local track = Hum:WaitForChild("Animator"):LoadAnimation(Anim)
    track:AdjustSpeed(Hub.Settings.AnimSpeed) -- Тонкая настройка из конфига!
    track:Play()
end)

-- 3. Bang Script[cite: 30]
AddAction(TabScripts, "Запустить Bang Script", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/4gh9/Bang-Script-Gui/main/bang%20gui.lua'))()
end)

-- Наполняем вкладку настроек
AddConfigInput(TabConfig, "Скорость анимации:", "AnimSpeed")
AddConfigInput(TabConfig, "Скорость полета (Fly):", "FlySpeed")
