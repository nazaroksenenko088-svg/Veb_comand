-- Veb_comand Hub - Ultimate OOO & Server Vulnerability Scanner Edition
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Очистка старой версии
if CoreGui:FindFirstChild("VebOOOPanelHub") then
    CoreGui.VebOOOPanelHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VebOOOPanelHub"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Главное окно OOO-панели
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 440)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Шапка OOO Panel
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 140)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Veb_comand // [OOO PANEL + SERVER EXPLOIT CORE]"
Title.Parent = TopBar

-- Меню вкладок (Слева)
local TabList = Instance.new("ScrollingFrame")
TabList.Size = UDim2.new(0, 150, 1, -55)
TabList.Position = UDim2.new(0, 5, 0, 50)
TabList.BackgroundTransparency = 1
TabList.ScrollBarThickness = 2
TabList.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabList
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- Контейнер страниц (Справа)
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -165, 1, -55)
PagesContainer.Position = UDim2.new(0, 160, 0, 50)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

local firstTab = true
local function createTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 34)
    TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    TabButton.TextColor3 = Color3.fromRGB(160, 160, 160)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 12
    TabButton.Text = tabName
    TabButton.Parent = TabList
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabButton
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3
    Page.Visible = firstTab
    Page.Parent = PagesContainer
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 6)
    
    if firstTab then
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
        TabButton.TextColor3 = Color3.fromRGB(12, 12, 12)
        firstTab = false
    end
    
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(PagesContainer:GetChildren()) do
            if child:IsA("ScrollingFrame") then child.Visible = false end
        end
        for _, child in pairs(TabList:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                child.TextColor3 = Color3.fromRGB(160, 160, 160)
            end
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
        TabButton.TextColor3 = Color3.fromRGB(12, 12, 12)
    end)
    
    local TabAPI = {}
    function TabAPI:CreateButton(name, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 34)
        Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12
        Btn.Text = name
        Btn.Parent = Page
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 5)
        Corner.Parent = Btn
        
        Btn.MouseButton1Click:Connect(callback)
    end
    
    function TabAPI:CreateLabel(text)
        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1, -10, 0, 24)
        Lbl.BackgroundTransparency = 1
        Lbl.TextColor3 = Color3.fromRGB(130, 130, 130)
        Lbl.Font = Enum.Font.GothamMedium
        Lbl.TextSize = 11
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.Text = text
        Lbl.Parent = Page
        return Lbl
    end
    
    return TabAPI
end

-- Скрытие по RightShift
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ВКЛАДКИ
local OOOTab = createTab("⚙️ OOO Панель & Сервер")
local SurvivalTab = createTab("🌊 Выживание & ТП")
local TrollTab = createTab("🤖 Брейнроты")
local AudioTab = createTab("🎵 Аудио & Сеть")

-- 1. OOO ПАНЕЛЬ & СЕРВЕРНЫЕ УЯЗВИМОСТИ
OOOTab:CreateLabel("== АНАЛИЗ СЕРВЕРНЫХ ДЫР ==")
local ServerStatusLbl = OOOTab:CreateLabel("Статус сервера: Ожидание скана...")

OOOTab:CreateButton("Глубокий скан серверных RemoteEvents", function()
    print("[OOO EXPLOIT] Запуск глубокого аудита репликации...")
    local vulnerableCount = 0
    
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            -- Проверяем имя на наличие административных или триггерных ключевых слов
            local nameLower = obj.Name:lower()
            if nameLower:find("admin") or nameLower:find("kick") or nameLower:find("ban") or nameLower:find("sunami") or nameLower:find("wave") or nameLower:find("spawn") or nameLower:find("admin") then
                vulnerableCount = vulnerableCount + 1
                print("[!] ПОТЕНЦИАЛЬНАЯ ДЫРА НА СЕРВЕРЕ -> " .. obj:GetFullName())
            end
        end
    end
    
    ServerStatusLbl.Text = "Найдено уязвимых эвентов: " .. vulnerableCount
    print("[OOO EXPLOIT] Сканирование завершено. Проверь F9 (Console).")
end)

OOOTab:CreateButton("Тест бэкдора: Фейк-запрос прав Owner", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 50
        char.Humanoid.JumpPower = 130
        print("[OOO PANEL] Эмуляция прав Owner применена локально.")
    end
end)

-- 2. ВЫЖИВАНИЕ & ТП
SurvivalTab:CreateLabel("== ТОП-10 КОМПЛЕКТАЦИЯ ==")
SurvivalTab:CreateButton("1. Бессмертие (GodMode)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum.HealthChanged:Connect(function()
            if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end)
        print("[+] Бессмертие активировано.")
    end
end)

SurvivalTab:CreateButton("2. Авто-ТП наверх от цунами", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 130, 0)
        print("[+] Телепорт на крышу выполнен.")
    end
end)

local noclipActive = false
SurvivalTab:CreateButton("3. Вкл/Выкл Noclip (Сквозь стены)", function()
    noclipActive = not noclipActive
    print("[*] Noclip:", noclipActive)
end)
RunService.Stepped:Connect(function()
    if noclipActive and LocalPlayer.Character then
        for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

SurvivalTab:CreateButton("4. Подсветка игроков (ESP)", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("VebESP") then
            local hl = Instance.new("Highlight")
            hl.Name = "VebESP"
            hl.Adornee = p.Character
            hl.FillColor = Color3.fromRGB(0, 255, 140)
            hl.Parent = p.Character
        end
    end
    print("[+] ESP активирован.")
end)

-- 3. БРЕЙНРОТЫ
TrollTab:CreateLabel("== АРСЕНАЛ БРЕЙНРОТОВ ==")
local brainrotSpam = {
    "Skibidi dop dop yes yes, цунами под контролем Veb_comand!",
    "Sigma grindset: переживаем любую катастрофу без проблем.",
    "Fanum Tax забрал всю воду, шторм отменяется!",
    "Rizz уровень 100: захватываем сервер на чиле.",
    "Камера-мэн фиксирует победу сигм в Escape Tsunami!"
}

for i, phrase in ipairs(brainrotSpam) do
    TrollTab:CreateButton("Спам мем #" .. i, function()
        ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer({phrase, "All"})
    end)
end

-- 4. АУДИО & СЕТЬ
AudioTab:CreateLabel("== АУДИО И СЕТЕВЫЕ ДЫРЫ ==")
AudioTab:CreateButton("Сканировать SoundService (Аудио-сервер)", function()
    print("[*] Сканирование звуков сервера...")
    local count = 0
    for _, snd in ipairs(game:GetService("SoundService"):GetDescendants()) do
        if snd:IsA("Sound") then
            count = count + 1
            print("[Sound] " .. snd.Name .. " | ID: " .. tostring(snd.SoundId))
        end
    end
    print("[+] Аудио-сканирование завершено. Найдено источников: " .. count)
end)

AudioTab:CreateButton("Дамп всех RemoteEvents в консоль (F9)", function()
    print("[*] Полный дамп сетевых каналов...")
    for _, ev in ipairs(ReplicatedStorage:GetDescendants()) do
        if ev:IsA("RemoteEvent") or ev:IsA("RemoteFunction") then
            print("[Event] -> " .. ev:GetFullName())
        end
    end
    print("[+] Дамп завершен.")
end)

print("[+] Veb_comand OOO Panel + Server Exploit Core успешно загружена!")
