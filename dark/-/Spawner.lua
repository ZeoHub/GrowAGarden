task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/0e08efc5390446f12bb3f48e59cc6766.lua"))()
end)

local genv = getgenv()
repeat task.wait() until genv.Spawner and genv.Spawner.Load
return genv.Spawner
