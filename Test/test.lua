local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Wait for player
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create the loading screen GUI
local blurScreen = Instance.new("ScreenGui")
blurScreen.Name = "BlurLoadingScreen"
blurScreen.DisplayOrder = 99999
blurScreen.IgnoreGuiInset = true
blurScreen.ResetOnSpawn = false

-- Create blur effect container
local blurContainer = Instance.new("Frame")
blurContainer.Name = "BlurContainer"
blurContainer.Size = UDim2.new(1, 0, 1, 0)
blurContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
blurContainer.BackgroundTransparency = 0.3
blurContainer.ZIndex = 99999

-- Add subtle gradient effect
local gradient = Instance.new("UIGradient")
gradient.Rotation = 90
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 30, 80))
})
gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.3),
    NumberSequenceKeypoint.new(1, 0.7)
})
gradient.Parent = blurContainer

-- Create the blur effect
local blur = Instance.new("BlurEffect")
blur.Name = "LoadingBlur"
blur.Size = 0
blur.Parent = Lighting

-- Create the logo container
local logoContainer = Instance.new("Frame")
logoContainer.Name = "LogoContainer"
logoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
logoContainer.Position = UDim2.new(0.5, 0, 0.45, 0)
logoContainer.Size = UDim2.new(0, 200, 0, 200)
logoContainer.BackgroundTransparency = 1
logoContainer.ZIndex = 99999

-- Create the logo
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(1, 0, 1, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://119919697523670"
logo.ScaleType = Enum.ScaleType.Fit
logo.ZIndex = 99999

-- Add glow effect to logo
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.Size = UDim2.new(1.2, 0, 1.2, 0)
glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://119919697523670"
glow.ImageColor3 = Color3.fromRGB(100, 150, 255)
glow.ScaleType = Enum.ScaleType.Fit
glow.ZIndex = 99998
glow.ImageTransparency = 0.8
glow.Parent = logoContainer

-- Add pulsing effect to logo
local pulseTween
local function startPulse()
    pulseTween = TweenService:Create(logo, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(1.1, 0, 1.1, 0)
    })
    pulseTween:Play()
    
    TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(1.4, 0, 1.4, 0),
        ImageTransparency = 0.6
    }):Play()
end

-- Create loading text with Comic Neue Angular SemiBold font (FIXED)
local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.Position = UDim2.new(0.5, 0, 0.6, 0)
loadingText.Size = UDim2.new(0, 300, 0, 40)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading: 1/1000"
loadingText.TextColor3 = Color3.fromRGB(200, 220, 255)
loadingText.TextSize = 22
loadingText.ZIndex = 99999

-- FONT FIX: Use FontFace instead of deprecated Font property
loadingText.FontFace = Font.new(
    "rbxasset://fonts/families/ComicNeueAngular.json",
    Enum.FontWeight.SemiBold,
    Enum.FontStyle.Normal
)

-- Create progress bar
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.AnchorPoint = Vector2.new(0.5, 0.5)
progressBar.Position = UDim2.new(0.5, 0, 0.7, 0)
progressBar.Size = UDim2.new(0.6, 0, 0, 8)
progressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
progressBar.BorderSizePixel = 0
progressBar.ZIndex = 99999

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.CornerRadius = UDim.new(0.5, 0)
progressBarCorner.Parent = progressBar

local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 99999

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(0.5, 0)
progressFillCorner.Parent = progressFill

-- Assemble the UI
progressFill.Parent = progressBar
logo.Parent = logoContainer
logoContainer.Parent = blurContainer
loadingText.Parent = blurContainer
progressBar.Parent = blurContainer
blurContainer.Parent = blurScreen

-- Smoother blur animation with longer duration
local function animateBlur()
    local tween = TweenService:Create(blur, TweenInfo.new(2, Enum.EasingStyle.Quad), {
        Size = 24
    })
    tween:Play()
    return tween
end

-- Progress bar with 13 second duration and 1-1000 count
local function simulateProgress()
    local duration = 13
    local startTime = os.clock()
    local totalSteps = 1000
    
    while os.clock() - startTime < duration do
        local progress = (os.clock() - startTime) / duration
        progressFill.Size = UDim2.new(progress, 0, 1, 0)
        
        -- Update loading text to show 1-1000 count
        local currentStep = math.floor(progress * totalSteps) + 1
        if currentStep > totalSteps then
            currentStep = totalSteps
        end
        loadingText.Text = "Loading: " .. currentStep .. "/1000"
        
        RunService.RenderStepped:Wait()
    end
    
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    loadingText.Text = "Loading Complete: 1000/1000"
end

-- Function to execute after loading completes
local function executeLoadString()
    -- Replace this with your actual loadstring code
    local success, result = pcall(function()
        -- YOUR ACTUAL LOADSTRING CODE GOES HERE
        loadstring(game:HttpGet("YOUR_SCRIPT_URL_HERE"))()
        
        -- Example notification
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Loadstring",
            Text = "Script executed successfully!",
            Duration = 5
        })
    end)
    
    if not success then
        -- Show error message if loadstring fails
        warn("Loadstring Error: " .. tostring(result))
        loadingText.Text = "Error: Failed to load script"
        loadingText.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(3)  -- Show error for 3 seconds
    end
end

-- Main loading function
local function showLoadingScreen()
    -- Add to player GUI
    blurScreen.Parent = playerGui
    
    -- Start animations
    local blurTween = animateBlur()
    startPulse()
    
    -- Simulate loading progress with 13s duration
    simulateProgress()
    
    -- Execute loadstring after progress completes
    executeLoadString()
    
    -- Wait a moment before hiding
    task.wait(1.5)
    
    -- Smoother fade out with blur effect
    local fadeOut = TweenService:Create(blurContainer, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    })
    
    -- Fade out blur effect
    local blurFade = TweenService:Create(blur, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        Size = 0
    })
    
    -- Fade out all elements
    TweenService:Create(logo, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(loadingText, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(progressBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(progressFill, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    }):Play()
    
    -- Start fade animations
    fadeOut:Play()
    blurFade:Play()
    
    -- Wait for completion
    fadeOut.Completed:Wait()
    blurFade.Completed:Wait()
    
    -- Clean up
    if pulseTween then pulseTween:Cancel() end
    blurScreen:Destroy()
    blur:Destroy()
end

-- Start the loading screen
showLoadingScreen()
