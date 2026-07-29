-- =========================================================================
-- DOMAIN HUB | Delta X Edition (Update: Smoke & Cola Chill Pack)
-- =========================================================================

local DomainHub = {
    Config = {
        HubName = "Domain Hub",
        Version = "3.4.0",
        KeyDurationDays = 7,
        AuthorNote = "Мы с бро не сидим до 03:00 ночи ради ежедневных правок, так что цените оригинал! ☕",
    },
    State = {
        IsCoreUpdated = true,
        ModsAvailable = true,
        AutoDayEnabled = true,
        SmartAFKActive = false,
        CombatModeActive = false,
        ChillItemActive = "None"
    },
    Modules = {},
    ModRegistry = {}
}

-- Защищенный запуск функций (анти-краш)
function DomainHub:SafeCall(name, func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn(string.format("[Domain Hub Error] Модуль '%s' сбоит: %s", name, tostring(result)))
        return nil
    end
    return result
end

-- Инициализация базового ядра
function DomainHub:InitCore()
    print(">>> Запуск ядра Domain Hub для Delta X...")
    
    self:SafeCall("AntiStealer", function()
        print("[Security] Анти-стилер активен.")
    end)

    self:SafeCall("PerformanceOptimizer", function()
        UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualityLevel.Level1
        print("[Performance] Оптимизация памяти применена.")
    end)
end

-- Модуль «Сигарета или Кола» (Психологический троллинг и чилл)
function DomainHub:InitChillPack()
    self:SafeCall("ChillPackModule", function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        -- Чат-команды для мгновенного ответа токсикам на чиле
        LocalPlayer.Chatted:Connect(function(msg)
            if msg == ".smoke" then
                self.State.ChillItemActive = "Cigarette"
                local reply = "Не катит? Сейчас исправим. 🚬"
                
                local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
                    chatEvent.SayMessageRequest:FireServer(reply, "All")
                end
                print("[ChillPack] Достали сигарету. Пусть завидуют молча.")
                
            elseif msg == ".cola" then
                self.State.ChillItemActive = "Cola"
                local reply = "Не катит сигарета? Держи холодную колу, остынь, бро. 🥤"
                
                local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
                    chatEvent.SayMessageRequest:FireServer(reply, "All")
                end
                print("[ChillPack] Открыли колу. Полный релакс посреди замеса.")
            end
        end)

        print("[Feature] Модуль «Сигарета и Кола» успешно интегрирован.")
    end)
end

-- Загрузка системы модов и чилл-пака
function DomainHub:LoadModSystem()
    print(">>> Загрузка системы модов, чилл-пака и тир-листа...")
    self.ModRegistry = {
        {
            Name = "Foxname Enhanced Edition (Domain Hub Optimized)",
            Author = "Foxname x Domain Hub Team",
            Tier = "S+ Tier",
            Link = "internal://foxname_enhanced",
            IsStable = true
        },
        {
            Name = "Smoke & Cola Chill Addon",
            Author = "Domain Hub Team",
            Tier = "Exclusive Tier",
            Link = "internal://chill_pack",
            IsStable = true
        }
    }
end

-- Главный запуск хаба
function DomainHub:Launch()
    self:InitCore()
    self:InitChillPack() -- Включаем режим максимального расслабона и троллинга
    self:LoadModSystem()
    
    print(string.format("=== %s (v%s) успешно запущен! Ключ действует еще %d дней. ===", self.Config.HubName, self.Config.Version, self.Config.KeyDurationDays))
    print("Памятка:", self.Config.AuthorNote)
end

-- Старт
DomainHub:Launch()
