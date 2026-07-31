-- Universal Script Loader Core (Modular Architecture)
local Loader = {}
Loader.Modules = {}

-- Конфигурация путей / репозиториев откуда тянем модули
Loader.Config = {
    RepoBase = "https://raw.githubusercontent.com/our-ecosystem/modules/main/",
    DebugMode = true
}

-- Функция безопасной загрузки модуля
function Loader:LoadModule(moduleName, url)
    if self.Modules[moduleName] then
        if self.Config.DebugMode then
            print("[Loader]: Модуль " .. moduleName .. " уже загружен из кэша.")
        end
        return self.Modules[moduleName]
    end

    local success, result = pcall(function()
        -- Используем стандартный геттер для подгрузки «на лету»
        return game:HttpGet(self.Config.RepoBase .. url)
    end)

    if success and result then
        local loadFunc, err = loadstring(result)
        if loadFunc then
            local moduleInstance = loadFunc()
            self.Modules[moduleName] = moduleInstance
            if self.Config.DebugMode then
                print("[Loader]: Успешно инициализирован -> " .. moduleName)
            end
            return moduleInstance
        else
            warn("[Loader Error] Ошибка компиляции модуля " .. moduleName .. ": " .. tostring(err))
        end
    else
        warn("[Loader Error] Не удалось стянуть модуль " .. moduleName)
    end
    return nil
end

-- Инициализация нашего комбайна
function Loader:Init()
    print("[Loader]: Запуск универсального арсенала...")
    
    -- Подтягиваем базу (CoolGUI, Dex, Spy)
    -- local CoolGUI = self:LoadModule("CoolGUI", "coolgui_modern.lua")
    -- local DarkDex = self:LoadModule("DarkDex", "dark_dex_v3.lua")
    
    print("[Loader]: Все системы в норме. Готово к работе.")
end

return Loader
