

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "amaz dupe",Icon = 0,LoadingTitle = "dupe",LoadingSubtitle = "by amaz0.",Theme = "Default",DisableRayfieldPrompts = false,DisableBuildWarnings = false,
    ConfigurationSaving = {Enabled = false,FolderName = nil,FileName = ""},
    Discord = {Enabled = false,Invite = "noinvitelink",RememberJoins = true },
    KeySystem = false,
    KeySettings = {Title = "Untitled",Subtitle = "Key System",Note = "No method of obtaining the key is provided",FileName = "Key",SaveKey = true,GrabKeyFromSite = false,Key = {""}}
 })
 local Tab = Window:CreateTab("Main", 4483362458) -- Title, Image
 local Button = Tab:CreateButton({Name = "Dupe fruits and pets",
    Callback = function()
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if not tostring(v):match("Seed") then
                d = v:Clone()
                d.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end,
 })
 local m = 2
 local Slider = Tab:CreateSlider({Name = "Multiplier",Range = {2, 100},Increment = 1,Suffix = "",CurrentValue = 2,Flag = "a",
    Callback = function(Value)
        m = Value
    end,
 })
 local Button = Tab:CreateButton({Name = "Dupe seeds",
    Callback = function()
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if tostring(v):match("[X%d+]") and tostring(v):match("Seed") then
                v.Name = tostring(v):gsub(tostring(v):match("(%d+)"),tonumber(tostring(v):match("(%d+)"))*m)
            end 
        end
    end,
 })
