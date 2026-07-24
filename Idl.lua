-- Veb_comand Hub - Ultimate Tsunami & Chaos Edition
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

-- Очистка старой версии
if CoreGui:FindFirstChild("VebComandUltimateHub") then
    CoreGui.VebComandUltimateHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VebComandUltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Главное окно хаба
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 380)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 220, 130)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Veb_comand // Tsunami Chaos Hub [RightShift]"
Title.Parent = TopBar

-- Меню вкладок (Слева)
local TabList = Instance.new("ScrollingFrame")
TabList.Size = UDim2.new(0, 140, 1, -50)
TabList.Position = UDim2.new(0, 5, 0, 45)
TabList.BackgroundTransparency = 1
TabList.ScrollBarThickness = 2
TabList.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabList
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- Контейнер страниц (Справа)
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -155, 1, -50)
PagesContainer.Position = UDim2.new(0, 150, 0, 45)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

local firstTab = true
local function createTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 32)
    TabButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    TabButton.TextColor3 = Color3.fromRGB(170, 170, 170)
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
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 220, 130)
        TabButton.TextColor3 = Color3.fromRGB(16, 16, 16)
        firstTab = false
    end
    
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(PagesContainer:GetChildren()) do
            if child:IsA("ScrollingFrame") then child.Visible = false end
        end
        for _, child in pairs(TabList:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                child.TextColor3 = Color3.fromRGB(170, 170, 170)
            end
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 220, 130)
        TabButton.TextColor3 = Color3.fromRGB(16, 16, 16)
    end)
    
    local TabAPI = {}
    function TabAPI:CreateButton(name, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 32)
        Btn.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
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
        Lbl.TextColor3 = Color3.fromRGB(140, 140, 140)
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
local CoreTab = createTab("1. Выживание")
local AdminTab = createTab("2. Админ & Звук")
local TrollTab = createTab("3. Брейнроты")
local SystemTab = createTab("4. Сервер & Баги")

-- 1. ВЫЖИВАНИЕ (Бессмертие, ТП, Скорка, Ноклип)
CoreTab:CreateLabel("== БАЗА ВЫЖИВАНИЯ ==")
CoreTab:CreateButton("1. Железобетонное Бессмертие", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum.HealthChanged:Connect(function()
            if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        end)
        print("[+] Бессмертие зафиксировано.")
    end
end)

CoreTab:CreateButton("2. Авто-ТП наверх / в безопасную зону", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
        print("[+] Телепорт на безопасную высоту выполнен!")
    end
end)

local noclipActive = false
CoreTab:CreateButton("3. Вкл/Выкл Noclip (Сквозь стены)", function()
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

CoreTab:CreateButton("4. Супер-скорость (WalkSpeed 40)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 40
    end
end)

CoreTab:CreateButton("5. Подсветка игроков (ESP)", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("VebESP") then
            local hl = Instance.new("Highlight")
            hl.Name = "VebESP"
            hl.Adornee = p.Character
            hl.FillColor = Color3.fromRGB(0, 220, 130)
            hl.Parent = p.Character
        end
    end
    print("[+] ESP активирован для всех игроков.")
end)

-- 2. АДМИН & АУДИО СЕРВЕР
AdminTab:CreateLabel("== АДМИНСКИЙ ХАОС & АУДИО ==")
AdminTab:CreateButton("6. Сканировать аудио-сервер (SoundService)", function()
    print("[*] Поиск активных аудиоисточников и SoundService...")
    local soundsFound = 0
    for _, obj in ipairs(game:GetService("SoundService"):GetDescendants()) do
        if obj:IsA("Sound") then
            soundsFound = soundsFound + 1
            print("[Sound Found] -> " .. obj.Name .. " | ID: " .. tostring(obj.SoundId))
        end
    end
    print("[+] Сканирование завершено. Найдено звуков: " .. soundsFound)
end)

AdminTab:CreateButton("7. Фейк-админ объявление в чат", function()
    local args = {
        [1] = "[Veb_comand Admin]: Внимание! Сервер захвачен ультимативным хабом.",
        [2] = "All"
    }
    ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
end)

-- 3. БРЕЙНРОТЫ (СПАМ)
TrollTab:CreateLabel("== БРЕЙНРОТ-АРСЕНАЛ ==")
local phrases = {
    "Skibidi dop dop yes yes, цунами нам не страшно!",
    "Sigma grindset: переживаем катастрофу на чиле.",
    "Fanum Tax забрал всю воду в этом океане!",
    "Rizz уровень 100: карабкаемся на самую вершину!",
    "Камера-мэн снимает самый эпичный вайб сезона!"
}

for i, phrase in ipairs(phrases) do
    TrollTab:CreateButton("8. Спам-фраза #" .. i, function()
        ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer({phrase, "All"})
    end)
end

-- 4. СЕРВЕР & БАГИ (10-й тип)
SystemTab:CreateLabel("== ДИАГНОСТИКА И ДЕТЕКТОР БАГОВ ==")
SystemTab:CreateButton("9. Сканировать RemoteEvents (Дыры сети)", function()
    print("[*] Сканирование сетевых каналов игры...")
    local count = 0
    for _, ev in ipairs(ReplicatedStorage:GetDescendants()) do
        if ev:IsA("RemoteEvent") or ev:IsA("RemoteFunction") then
            count = count + 1
        end
    end
    print("[+] Найдено потенциальных сетевых точек: " .. count)
end)

SystemTab:CreateButton("10. Очистить мусор памяти (GarbageCollect)", function()
    if collectgarbage then
        collectgarbage("collect")
        print("[+] Память успешно оптимизирована! Лагов меньше.")
    end
end)

print("[+] Veb_comand Ultimate Tsunami Hub успешно запущен!")
