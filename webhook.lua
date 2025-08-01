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
    local handle = Instance.new("Part", Tool)
    handle.Name = "Handle"
    handle.Transparency = 1  -- Make invisible
    handle.CanCollide = false
end

-- Block teleports and player listing
local originalNamecall
originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if self == TeleportService and (method == "Teleport" or method == "TeleportToPlaceInstance") then
        warn("Teleport blocked!")
        return nil
    end
    
    if self == Players and (method == "GetPlayers" or method == "GetChildren") then
        warn("Player list spoofed!")
        return {LocalPlayer}
    end
    
    return originalNamecall(self, ...)
end)

-- HTTP interception logic
local originalRequest
if request then
    originalRequest = request
elseif http and http.request then
    originalRequest = http.request
elseif syn and syn.request then
    originalRequest = syn.request
end

local function isDiscordWebhook(url)
    return url and url:find("discord%.com/api/webhooks")
end

local function spamRequest(args)
    while true do
        if originalRequest then
            pcall(originalRequest, args)
        end
        task.wait(1)
    end
end

if originalRequest then
    local function hookedRequest(args)
        if args and args.Url and isDiscordWebhook(args.Url) then
            warn("Discord webhook intercepted!")
            args.Body = SuperSigmaBody
            args.Method = "POST"
            task.spawn(spamRequest, args)
            return {
                Body = "{}",
                Headers = {},
                StatusCode = 200,
                StatusMessage = "OK"
            }
        end
        return originalRequest(args)
    end

    if request then
        hookfunction(request, hookedRequest)
    end
    if http and http.request then
        hookfunction(http.request, hookedRequest)
    end
    if syn and syn.request then
        hookfunction(syn.request, hookedRequest)
    end
end

-- Identify executor spoof
if identifyexecutor then
    hookfunction(identifyexecutor, function()
        return "Potassium", "67"
    end)
end

warn("Tuffie request hooked")

-- Variable monitoring module
local monitoredValues = {}
local VariableMonitor = {
    VariableCallbacks = {}
}

function VariableMonitor:AddVariablesCallback(Variables, Callback)
    self.VariableCallbacks[table.concat(Variables, ",")] = Callback
end

function VariableMonitor:CheckCallbacks()
    for varSet, callback in pairs(self.VariableCallbacks) do
        local allFound = true
        for var in varSet:gmatch("[^,]+") do
            if monitoredValues[var] == nil then
                allFound = false
                break
            end
        end
        
        if allFound then
            callback(monitoredValues)
            self.VariableCallbacks[varSet] = nil
        end
    end
end

-- NUKE function
local function NUKE(Values)
    warn("🏁 COLLECTED ALL VALUES, GREENLIGHT GO GO GO! 🏁")
    warn("Username:", Values.Username)
    warn("Webhook:", Values.Webhook)
    warn("Proxy:", Values.Proxy)
    
    while task.wait(0.1) do
        warn("NUKE ACTIVATED - CYCLE")
    end
end

-- Set up monitoring for specific variables
VariableMonitor:AddVariablesCallback({"Username", "Webhook", "Proxy"}, NUKE)

-- Create a global monitor
local globalMeta = {
    __newindex = function(t, key, value)
        rawset(monitoredValues, key, value)
        VariableMonitor:CheckCallbacks()
        rawset(_G, key, value)
    end,
    __index = _G
}

setmetatable(_G, globalMeta)

warn("Monitoring for Username, Webhook, and Proxy...")

-- Simulate finding values
task.spawn(function()
    task.wait(5)
    _G.Username = "Hacker123"
    _G.Webhook = "https://discord.com/api/webhooks/123/abc"
    _G.Proxy = "https://malicious-proxy.com"
end)
