-- Function to run both scripts with error handling
local function RunScripts()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/webhook.lua"))()
    end)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/Load/EggRandomizer.lua"))()
    end)
end

-- First run
RunScripts()

-- Teleport script with 10-minute duration limit
local teleportScript = [[
    local start = tick()
    while tick() - start < 600 do  -- 10 minutes
        pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/webhook.lua"))
        pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/Load/EggRandomizer.lua"))
        wait(math.random(3, 7))
    end
]]

-- Queue the teleport
queue_on_teleport('loadstring(' .. string.format('%q', teleportScript) .. ')()')

-- Spam in current session for 10 minutes
local start = tick()
while tick() - start < 600 do  -- 10 minutes
    RunScripts()
    wait(math.random(3, 7))
end
