-- =====================================================================
-- ULTIMATE BERSERK & PSYCHOPATH MASTER SUITE: Final R15 Build
-- Target Executor: Delta X / Custom Environments
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
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
-- (Foxname полностью убран)

-- 2. Модуль визуального террора под R15
local function applyMasterSuite()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local head = character:WaitForChild("Head")
    local rightHand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")

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

    -- Правая рука Гайца (Демонический протез на R15 RightHand)
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

    -- Наручный голографический терминал на правой руке (с функцией закрытия/сворачивания по клику)
    local wristTerminal = character:FindFirstChild("WristTerminal")
    if not wristTerminal and rightHand then
        wristTerminal = Instance.new("Part")
        wristTerminal.Name = "WristTerminal"
        wristTerminal.Size = Vector3.new(0.7, 0.5, 0.1)
        wristTerminal.BrickColor = BrickColor.new("Bright red")
        wristTerminal.Material = Enum.Material.Neon
        wristTerminal.CanCollide = false
        wristTerminal.Transparency = 0.2

        local wConstraint = Instance.new("WeldConstraint")
        wConstraint.Part0 = rightHand
        wConstraint.Part1 = wristTerminal
        wConstraint.Parent = wristTerminal
        
        wristTerminal.CFrame = rightHand.CFrame * CFrame.new(0, -0.1, -0.25)
        wristTerminal.Parent = character

        -- Интерактив: клик по терминалу закрывает/сворачивает его
        local clickDetector = Instance.new("ClickDetector")
        clickDetector.MaxActivationDistance = 32
        clickDetector.Parent = wristTerminal

        local isTerminalOpen = true
        clickDetector.MouseClick:Connect(function(player)
            if player == LocalPlayer then
                isTerminalOpen = not isTerminalOpen
                if isTerminalOpen then
                    wristTerminal.Transparency = 0.2
                    wristTerminal.Size = Vector3.new(0.7, 0.5, 0.1)
                else
                    wristTerminal.Transparency = 0.98
                    wristTerminal.Size = Vector3.new(0.05, 0.05, 0.05)
                end
            end
        end)
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

    -- Рендер-цикл: Левитация и орбита глаз
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not character or not humanoid or humanoid.Health <= 0 then
            if connection then connection:Disconnect() end
            if eyesFolder then eyesFolder:Destroy() end
            return
        end

        local timeVal = tick()
        
        if rootPart then
            -- Стабилизация левитации
            rootPart.Velocity = Vector3.new(0, 0, 0)

            -- Орбитальное движение живых глаз вокруг персонажа
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

-- Автозапуск при респауне
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyMasterSuite()
end)

if LocalPlayer.Character then
    task.spawn(applyMasterSuite)
end

print("[SYSTEM] Final R15 Guts Master Suite Deployed Successfully.")
