local RunService = game:GetService("RunService")
local RADIUS = 18 -- Радиус действия ауры ужаса

local function StartKneelingAura()
    RunService.RenderStepped:Connect(function()
        local char = localPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local myPos = char.HumanoidRootPart.Position

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local enemyChar = player.Character
                local enemyRoot = enemyChar:FindFirstChild("HumanoidRootPart")
                local enemyHumanoid = enemyChar:FindFirstChildOfClass("Humanoid")

                if enemyRoot and enemyHumanoid then
                    local distance = (myPos - enemyRoot.Position).Magnitude
                    if distance <= RADIUS then
                        -- Принудительно отключаем управление, сажаем/валим на колени
                        enemyHumanoid.PlatformStand = true
                        
                        -- Дополнительно можно обнулить скорость передвижения
                        enemyHumanoid.WalkSpeed = 0
                    else
                        -- Возвращаем управление, когда отбежали далеко
                        if enemyHumanoid.PlatformStand and enemyHumanoid.WalkSpeed == 0 then
                            enemyHumanoid.PlatformStand = false
                            enemyHumanoid.WalkSpeed = 16 -- Стандартная скорость
                        end
                    end
                end
            end
        end
    end)
end

StartKneelingAura()
