--[[
    Project: Polygon OS - Ultimate GUI Exploit Suite
]]--

local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Удаляем старое окно, если висело
if CoreGui:FindFirstChild("PolygonOS_GUI") then
    CoreGui.PolygonOS_GUI:Destroy()
end

-- Создаем красивый GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PolygonOS_GUI"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -130)
MainFrame.Size = UDim2.new(0, 400, 0, 260)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Font = Enum.Font.Code
Title.Text = "[ Polygon OS // GUI Edition ]"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -25, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.Code
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 11

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Консоль для логов
local Console = Instance.new("ScrollingFrame")
Console.Parent = MainFrame
Console.BackgroundTransparency = 1
Console.Position = UDim2.new(0, 10, 0, 40)
Console.Size = UDim2.new(1, -20, 0, 150)
Console.CanvasSize = UDim2.new(0, 0, 2, 0)
Console.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Console
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 3)

local function Log(text, color)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = Console
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.Font = Enum.Font.Code
    lbl.Text = "> " .. tostring(text)
    lbl.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

-- Кнопка активации эксплойта
local TriggerBtn = Instance.new("TextButton")
TriggerBtn.Parent = MainFrame
TriggerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
TriggerBtn.Position = UDim2.new(0, 10, 1, -45)
TriggerBtn.Size = UDim2.new(1, -20, 0, 35)

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = TriggerBtn

TriggerBtn.Font = Enum.Font.Code
TriggerBtn.Text = "ЗАПУСТИТЬ НАКРУТКУ ИВЕНТА"
TriggerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TriggerBtn.TextSize = 12

-- Логика взлома по нажатию кнопки
TriggerBtn.MouseButton1Click:Connect(function()
    Log("Инициализация принудительного триггера...", Color3.fromRGB(255, 255, 0))
    task.spawn(function()
        local count = 0
        for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                local name = v.Name:lower()
                if name:find("event") or name:find("reward") or name:find("block") or name:find("luck") or name:find("accept") then
                    pcall(function()
                        v:FireServer(true, 999999, "InfiniteReward", "All", 999)
                        v:FireServer("ClaimReward", true)
                        count = count + 1
                    end)
                end
            elseif v:IsA("RemoteFunction") then
                local name = v.Name:lower()
                if name:find("event") or name:find("data") or name:find("reward") or name:find("luck") then
                    pcall(function()
                        v:InvokeServer(true, 999999, "ForceTrigger")
                    end)
                end
            end
        end
        Log("Пакеты отправлены! Каналов задействовано: " .. count, Color3.fromRGB(0, 255, 128))
    end)
end)

Log("Polygon OS GUI успешно загружена.", Color3.fromRGB(0, 255, 150))
Log("Нажми кнопку ниже для активации.", Color3.fromRGB(200, 200, 200))
