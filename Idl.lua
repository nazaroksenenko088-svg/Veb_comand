-- Разведывательный модуль (Scout & Test Engine)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

print("[*] Запуск сканирования уязвимых Remote-объектов...")

local foundRemotes = {}

-- Функция рекурсивного поиска дырявых эвентов
local function scanFolder(parentFolder)
    for _, item in ipairs(parentFolder:GetChildren()) do
        if item:IsA("RemoteEvent") or item:IsA("RemoteFunction") then
            table.insert(foundRemotes, item)
            print(("[+] Найден Remote: %s (%s)"):format(item.Name, item.ClassName))
        end
        -- Уходим вглубь по структуре
        if #item:GetChildren() > 0 then
            scanFolder(item)
        end
    end
end

-- Сканируем основные зоны хранения сетевых данных
pcall(function()
    scanFolder(ReplicatedStorage)
end)

print(("[*] Сканирование завершено. Найдено целей: %d"):format(#foundRemotes))

-- Функция зондирования и тест-драйва найденного эвента
local function probeEvent(remoteInstance, ...)
    local args = {...}
    print(("[~] Зондируем цель: %s"):format(remoteInstance.Name))
    
    local success, err = pcall(function()
        if remoteInstance:IsA("RemoteEvent") then
            remoteInstance:FireServer(unpack(args))
        elseif remoteInstance:IsA("RemoteFunction") then
            remoteInstance:InvokeServer(unpack(args))
        end
    end)
    
    if success then
        print(("[+] Успех! Запрос принят сервером для: %s"):format(remoteInstance.Name))
    else
        print(("[-] Сервер отклонил или заблокировал: %s | Ошибка: %s"):format(remoteInstance.Name, tostring(err)))
    end
end

-- Пример тестового вызова первого попавшегося эвента (можно заменить аргументы под нужные нужды)
if #foundRemotes > 0 then
    task.spawn(function()
        task.wait(1)
        -- Пробуем дернуть первую найденную цель с тестовым аргументом
        probeEvent(foundRemotes[1], "TestPayload", 1337)
    end)
end    --     for i = 1, 5 do
    --         targetRemote:FireServer(999999)
    --         task.wait(0.5 + math.random() * 0.3)
    --     end
    -- end
    
    print("[Chaos Engine] Симуляция пакетов завершена. Проверяем баланс...")
end)

-- 3. Финальный отчёт о готовности
safeExecute("Finalizer", function()
    print("[Chaos Engine] Все системы в норме. Сервер готов к перформансу!")
end)
