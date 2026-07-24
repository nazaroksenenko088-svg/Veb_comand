-- Veb_comand Hub - GitHub Ready Edition
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Очистка старой версии перед запуском
if CoreGui:FindFirstChild("VebComandHub") then
    CoreGui.VebComandHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VebComandHub"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Шапка окна
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
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
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Veb_comand Hub // GitHub Version"
Title.Parent = TopBar

-- Кнопка закрытия/скрытия на клавишу RightShift
local ToggleHint = Instance.new("TextLabel")
ToggleHint.Size = UDim2.new(0, 150, 1, 0)
ToggleHint.Position = UDim2.new(1, -165, 0, 0)
ToggleHint.BackgroundTransparency = 1
ToggleHint.TextColor3 = Color3.fromRGB(120, 120, 120)
ToggleHint.Font = Enum.Font.Gotham
ToggleHint.TextSize = 12
ToggleHint.TextXAlignment = Enum.TextXAlignment.Right
ToggleHint.Text = "[RightShift] Скрыть"
ToggleHint.Parent = TopBar

-- Контейнер для вкладок (Слева)
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

-- Контейнер для страниц (Справа)
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -155, 1, -50)
PagesContainer.Position = UDim2.new(0, 150, 0, 45)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

local firstTab = true
local function createTab(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 32)
    TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 13
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
    PageLayout.Padding = UDim.new(0, 8)
    
    if firstTab then
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 220, 130)
        TabButton.TextColor3 = Color3.fromRGB(18, 18, 18)
        firstTab = false
    end
    
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(PagesContainer:GetChildren()) do
            if child:IsA("ScrollingFrame") then child.Visible = false end
        end
        for _, child in pairs(TabList:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                child.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 220, 130)
        TabButton.TextColor3 = Color3.fromRGB(18, 18, 18)
    end)
    
    local TabAPI = {}
    function TabAPI:CreateButton(name, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -10, 0, 35)
        Btn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 13
        Btn.Text = name
        Btn.Parent = Page
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = Btn
        
        Btn.MouseButton1Click:Connect(callback)
    end
    
    return TabAPI
end

-- Скрытие по RightShift
UserInputService.InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- НАПОЛНЕНИЕ ХАБА ФУНКЦИЯМИ
local ExploitTab = createTab("Эксплойты")
local UtilsTab = createTab("Утилиты")

ExploitTab:CreateButton("Запустить умный перехватчик", function()
    print("[*] Перехватчик активирован из GUI.")
    -- Сюда подключаем логику сниффера эвентов
end)

UtilsTab:CreateButton("Ресет персонажа", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

print("[+] Veb_comand Hub успешно загружен и готов для GitHub!")
