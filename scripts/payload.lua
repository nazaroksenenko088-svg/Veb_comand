-- CyberOS Test Payload
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

print("[CyberOS Payload] Injected successfully into: " .. localPlayer.Name)

-- Простой пример уведомления или функции
game.StarterGui:SetCore("SendNotification", {
    Title = "CyberOS Active",
    Text = "Environment connected via Delta X!",
    Duration = 5
})
