-- Загружаем красивую библиотеку Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirblood.github.io/Rayfield/'))()

-- Создаем главное окно
local Window = Rayfield:CreateWindow({
   Name = "Ultimate Hub | by Bro",
   LoadingTitle = "Загрузка скриптов...",
   LoadingSubtitle = "Подожди немного",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false, -- Можно включить, если захочешь добавить пароль
})

-- ==========================================
-- СОЗДАЕМ ВКЛАДКИ
-- ==========================================
local TabMain = Window:CreateTab("Главная", 4483362458) -- Иконка домика
local TabAdmin = Window:CreateTab("Админка", 4483362458)
local TabFun = Window:CreateTab("Фан", 4483362458)

-- ==========================================
-- КНОПКИ ДЛЯ ГЛАВНОЙ ВКЛАДКИ
-- ==========================================
TabMain:CreateButton({
   Name = "Запустить Akbarshox Fly V3",
   Callback = function()
       -- Скрипт на полет
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Administration1boo/solid-octo-succotash/refs/heads/main/Akbarshox%20Fly%20V3%E2%9A%A1"))()
   end,
})

TabMain:CreateButton({
   Name = "Загрузить Caomod2077 Loader",
   Callback = function()
       -- Скрипт лоадера
       loadstring(game:HttpGet("https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/loader"))()
   end,
})

-- ==========================================
-- КНОПКИ ДЛЯ ВКЛАДКИ "АДМИНКА"
-- ==========================================
TabAdmin:CreateButton({
   Name = "Запустить Rubo Admin",
   Callback = function()
       -- Твой скрипт для Rubo Admin
       game:GetService("StarterGui"):SetCore("SendNotification", {
           Title = "Rubo Admin Loaded",
           Text = "Powered by Delta - All Commands Ready!",
           Duration = 5
       })

       loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

       task.wait(1)
       if game:GetService("CoreGui"):FindFirstChild("EdgeIY") then
           local IY_UI = game:GetService("CoreGui").EdgeIY
           if IY_UI:FindFirstChild("Frame") and IY_UI.Frame:FindFirstChild("Title") then
               IY_UI.Frame.Title.Text = "Rubo Admin (Delta Edition)"
           end
       end
   end,
})

-- ==========================================
-- КНОПКИ ДЛЯ ВКЛАДКИ "ФАН"
-- ==========================================
TabFun:CreateButton({
   Name = "Scary Animation Script",
   Callback = function()
       -- Скрипт на страшные анимации
       loadstring(game:HttpGet("https://raw.githubusercontent.com/hailongcoding/Scary-animation-script/refs/heads/main/Scary-animation-script.lua", true))()
   end,
})

-- Уведомление об успешной загрузке
Rayfield:Notify({
   Title = "Успешно!",
   Content = "Хаб загружен, все скрипты готовы к работе.",
   Duration = 5,
   Image = 4483362458,
})
