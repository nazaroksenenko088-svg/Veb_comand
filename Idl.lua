-- Тестовый отладчик / Спавнер на коленке
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Ищем потенциальный RemoteEvent для выдачи предметов или денег
-- (Имена могут отличаться, проверяем стандартные папки)
local remoteFolder = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:FindFirstChild("Events")

local function testExploit()
    print("[*] Запуск тестового модуля...")
    
    -- Пример 1: Попытка накрутить валюту/деньги через перехват эвента
    if remoteFolder then
        for _, event in ipairs(remoteFolder:GetChildren()) do
            if event:IsA("RemoteEvent") then
                -- Пробуем дернуть эвент с аргументами на добавление денег/побед
                pcall(function()
                    event:FireServer("AddMoney", 999999)
                    event:FireServer("ClaimReward", true)
                    event:FireServer("SpawnBrainrot", "Godot_Entity")
                end)
            end
        end
    end
    
    -- Пример 2: Прямая манифестация объекта на стороне клиента для теста отрисовки
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        print("[+] Тестовый каркас позиции зафиксирован.")
    end
end

-- Активация по нажатию клавиши (например, Insert или F2)
game:GetService("UserInputService").InputBegan:Connect(funcName(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        testExploit()
    end
end)
