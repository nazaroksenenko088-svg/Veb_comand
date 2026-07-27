-- Загружаем UI-библиотеку Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Создаем главное окно
local Window = Rayfield:CreateWindow({
   Name = "My Custom Hub",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "by Bro",
   ConfigurationSaving = {
      Enabled = false,
   },
   KeySystem = false, -- Без всяких ключей
})

-- Создаем вкладку
local MainTab = Window:CreateTab("Основные", 4483362458)

-- Секция
local PlayerSection = MainTab:CreateSection("Игрок")

-- Ползунок скорости бега (WalkSpeed)
PlayerSection:CreateSlider({
   Name = "Скорость бега",
   Range = {16, 150},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Ползунок высоты прыжка (JumpPower)
PlayerSection:CreateSlider({
   Name = "Сила прыжка",
   Range = {50, 300},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- Вкладка визуальных функций
local VisualTab = Window:CreateTab("Визуал", 4483362458)
local VisualSection = VisualTab:CreateSection("Освещение")

-- Полное освещение (убираем темноту)
VisualSection:CreateToggle({
   Name = "FullBright (Убрать темноту)",
   CurrentValue = false,
   Flag = "FullBrightToggle",
   Callback = function(Value)
      if Value then
         game:GetService("Lighting").Brightness = 2
         game:GetService("Lighting").ClockTime = 14
         game:GetService("Lighting").FogEnd = 100000
      else
         game:GetService("Lighting").Brightness = 1
         game:GetService("Lighting").ClockTime = 0
         game:GetService("Lighting").FogEnd = 1000
      end
   end,
})

Rayfield:LoadConfiguration()
