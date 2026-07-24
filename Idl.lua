-- Veb_comand Hub - Clean & Ultimate Edition
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Очистка старой копии
if CoreGui:FindFirstChild("VebComandCleanHub") then
    CoreGui.VebComandCleanHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VebComandCleanHub"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Компактное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 280)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 6)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 220, 130)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Veb_comand // Core Control [RightShift]"
Title.Parent = TopBar

-- Контейнер для кнопок
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -45)
Container.Position = UDim2.new(0, 10, 0, 40)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
Container.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 8)

-- Функция создания чистых кнопок
local function createBtn(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 13
    Btn.Text = text
    Btn.Parent = Container
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
end

-- Скрытие по RightShift
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- НАСТРОЙКИ: БЕССМЕРТИЕ
createBtn("Активировать железобетонное Бессмертие", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        
        -- Фикс от обнуления уроном на клиенте
        hum.HealthChanged:Connect(function()
            if hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end)
        print("[+] Бессмертие зафиксировано.")
    end
end)

-- НАСТРОЙКИ: АВТО-ТП ПО ЗОНАМ
createBtn("Телепорт к ключевой зоне / объекту", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        -- Ищем возможные спавны или зоны на карте
        local target = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Zones") or workspace:FindFirstChildOfClass("Part")
        if target then
            local pos = target.Position or (target:IsA("Model") and target.PrimaryPart and target.PrimaryPart.Position)
            if pos then
                char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
                print("[+] Успешный прыжок к зоне!")
                return
            end
        end
        print("[-] Зона не найдена, прыжок на текущие координаты вверх")
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
    end
end)

-- БАЗА ДЛЯ СЕТЕВЫХ МАНИПУЛЯЦИЙ
createBtn("Сканировать сетевые каналы (RemoteEvents)", function()
    print("[*] Поиск доступных эвентов в ReplicatedStorage...")
    for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            print("[Found Remote] -> " .. obj.Name)
        end
    end
    print("[+] Сканирование завершено. Каналы готовы к перехвату.")
end)

print("[+] Ядро Veb_comand инициализировано.")
