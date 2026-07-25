-- =====================================================================
-- ULTIMATE BERSERK & BODY HORROR SUITE: Clones, Mutation & Alien Burst
-- Target Executor: Delta X / Custom Environments
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

-- 1. Инфраструктура (Страшные анимации + VapeVoidware + Ringta)
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Scary-animation-76752", true))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"))()
    end)
end)

-- 2. Графический интерфейс управления (GUI Hub)
local guiParent = gethui and gethui() or game:GetService("CoreGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BodyHorrorHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = guiParent

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 240, 0, 340)
mainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(180, 0, 0)
stroke.Thickness = 2
stroke.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "HORROR & CLONE SUITE"
title.TextColor3 = Color3.fromRGB(255, 40, 40)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local function createBtn(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(35, 10, 10)
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.Text = name
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(120, 10, 10) or Color3.fromRGB(35, 10, 10)
        callback(active)
    end)
end

local function createActionBtn(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(80, 10, 10)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- Переменные состояний
local flightEnabled = false
local eyesEnabled = true
local steamEnabled = true

createBtn("Полет: ВЫКЛ / ВКЛ", 45, function(state) flightEnabled = state end)
createBtn("Глаза-аура: ВКЛ / ВЫКЛ", 90, function(state) eyesEnabled = state end)
createBtn("Пар Титана: ВКЛ / ВЫКЛ", 135, function(state) steamEnabled = state end)

-- Функция: Спавн армии клонов со страшными звуками
createActionBtn("СЗУВАТЬ: Армия Клонов (Скримы)", 185, function()
    local character = LocalPlayer.Character
    if not character then return end
    
    for i = 1, 4 do
        task.spawn(function()
            local clone = character:Clone()
            clone.Name = "BerserkClone_" .. i
            clone:PivotTo(character.PrimaryPart.CFrame * CFrame.new(math.random(-6, 6), 0, math.random(-6, 6)))
            
            -- Убираем скрипты из клона, оставляем визуал
            for _, child in ipairs(clone:GetDescendants()) do
                if child:IsA("Script") or child:IsA("LocalScript") then
                    child:Destroy()
                elseif child:IsA("Highlight") then
                    child.FillColor = Color3.fromRGB(50, 0, 0)
                end
            end
            
            clone.Parent = Workspace
            
            -- Зловещий крик для каждого клона
            local scream = Instance.new("Sound")
            scream.SoundId = "rbxassetid://9069605280" -- Жуткий монструозный рев
            scream.Volume = 2
            scream.Parent = clone.PrimaryPart or clone:FindFirstChild("HumanoidRootPart")
            scream:Play()
            
            task.delay(15, function()
                if clone then clone:Destroy() end
            end)
        end)
    end
end)

-- Функция: Эффект "Чужой из груди" + Мутация в тварь
createActionBtn("МУТАЦИЯ: Выход Чужого из Груди", 235, function()
    local character = LocalPlayer.Character
    if not character then return end
    local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
    if not torso then return end

    -- Звук разрыва плоти и скрим
    local horrorSound = Instance.new("Sound")
    horrorSound.SoundId = "rbxassetid://9114221372" -- Звук скримера/разрыва
    horrorSound.Volume = 3
    horrorSound.Parent = torso
    horrorSound:Play()

    -- Создание прорывающейся твари (Чужого/шипа) из груди
    local chestBurst = Instance.new("Part")
    chestBurst.Name = "AlienChestBurster"
    chestBurst.Size = Vector3.new(0.8, 1.8, 0.8)
    chestBurst.Shape = Enum.PartType.Cylinder
    chestBurst.BrickColor = BrickColor.new("Really black")
    chestBurst.Material = Enum.Material.Neon
    chestBurst.CanCollide = false
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = torso
    weld.Part1 = chestBurst
    weld.Parent = chestBurst
    
    chestBurst.CFrame = torso.CFrame * CFrame.new(0, 0.2, -0.8) * CFrame.Angles(math.rad(90), 0, 0)
    chestBurst.Parent = character

    -- Кровавые частицы из груди
    local bloodAttach = Instance.new("Attachment", torso)
    local bloodParticles = Instance.new("ParticleEmitter")
    bloodParticles.Color = ColorSequence.new(Color3.fromRGB(150, 0, 0), Color3.fromRGB(50, 0, 0))
    bloodParticles.Size = NumberSequence.new(0.5, 2.0)
    bloodParticles.Transparency = NumberSequence.new(0.1, 1.0)
    bloodParticles.Lifetime = NumberRange.new(0.5, 1.0)
    bloodParticles.Rate = 120
    bloodParticles.Speed = NumberRange.new(5, 12)
    bloodParticles.Parent = bloodAttach

    -- Трансформация формы персонажа (деформация / ломание тела)
    task.delay(1.5, function()
        bloodParticles.Enabled = false
        if chestBurst then
            chestBurst.BrickColor = BrickColor.new("Bright red")
        end
    end)
end)

-- 3. Основной движок эффектов и полета
local function applyMasterSuite()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")
    local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")

    local face = head:FindFirstChildOfClass("Decal")
    if face then
        face.Texture = "rbxassetid://70747551"
    end

    if not character:FindFirstChild("PsychopathHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "PsychopathHighlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(100, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.35
        highlight.OutlineTransparency = 0
        highlight.Parent = character
    end

    local attachment = rootPart:FindFirstChild("TitanAttachment") or Instance.new("Attachment", rootPart)
    attachment.Name = "TitanAttachment"
    
    local particles = attachment:FindFirstChild("TitanSteam") or Instance.new("ParticleEmitter")
    particles.Name = "TitanSteam"
    particles.Color = ColorSequence.new(Color3.fromRGB(240, 240, 240), Color3.fromRGB(160, 160, 160))
    particles.Size = NumberSequence.new(1.5, 4.0)
    particles.Transparency = NumberSequence.new(0.3, 1.0)
    particles.Lifetime = NumberRange.new(0.6, 1.2)
    particles.Rate = 50
    particles.Speed = NumberRange.new(6, 14)
    particles.Parent = attachment

    if rightHand and not character:FindFirstChild("GutsArmManifest") then
        local gutsArmPart = Instance.new("Part")
        gutsArmPart.Name = "GutsArmManifest"
        gutsArmPart.Size = Vector3.new(0.5, 1.1, 0.5)
        gutsArmPart.BrickColor = BrickColor.new("Really black")
        gutsArmPart.Material = Enum.Material.Neon
        gutsArmPart.CanCollide = false
        gutsArmPart.Transparency = 0.15

        local wConstraint = Instance.new("WeldConstraint")
        wConstraint.Part0 = rightHand
        wConstraint.Part1 = gutsArmPart
        wConstraint.Parent = gutsArmPart
        
        gutsArmPart.CFrame = rightHand.CFrame * CFrame.new(0, -0.3, 0)
        gutsArmPart.Parent = character
    end

    local eyesFolder = character:FindFirstChild("AuraEyesFolder") or Instance.new("Folder", character)
    eyesFolder.Name = "AuraEyesFolder"
    eyesFolder:ClearAllChildren()

    local eyeParts = {}
    for i = 1, 8 do
        local eye = Instance.new("Part")
        eye.Name = "PsychopathEye_" .. i
        eye.Size = Vector3.new(0.35, 0.35, 0.35)
        eye.Shape = Enum.PartType.Ball
        eye.Material = Enum.Material.Neon
        eye.BrickColor = BrickColor.new("Bright red")
        eye.CanCollide = false
        eye.Parent = eyesFolder
        table.insert(eyeParts, eye)
    end

    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not character or not humanoid or humanoid.Health <= 0 then
            if connection then connection:Disconnect() end
            if eyesFolder then eyesFolder:Destroy() end
            return
        end

        local timeVal = tick()
        
        particles.Enabled = steamEnabled
        eyesFolder.Parent = eyesEnabled and character or nil

        if rootPart then
            if flightEnabled then
                humanoid.PlatformStand = true
                local moveDir = humanoid.MoveDirection
                local flySpeed = 50
                
                local velocity = Vector3.new(0, 0, 0)
                if moveDir.Magnitude > 0 then
                    velocity = moveDir * flySpeed
                end
                rootPart.AssemblyLinearVelocity = velocity + Vector3.new(0, 1.5, 0)
            else
                humanoid.PlatformStand = false
            end

            if eyesEnabled then
                for index, eyePart in ipairs(eyeParts) do
                    local angle = (timeVal * 3.5) + (index * (math.pi / 4))
                    local radius = 4.0 + math.sin(timeVal * 2 + index) * 0.6
                    local heightOffset = math.sin(timeVal * 5 + index) * 1.8
                    
                    local offsetPos = Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)
                    eyePart.CFrame = rootPart.CFrame + offsetPos
                end
            end
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyMasterSuite()
end)

if LocalPlayer.Character then
    task.spawn(applyMasterSuite)
end

print("[SYSTEM] Ultimate Horror & Clone Suite Deployed.")
