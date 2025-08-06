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
blurScreen.DisplayOrder = 99999  -- Highest possible z-index
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
blur.Size = 0  -- Will animate later
blur.Parent = Lighting

-- Create the logo container
local logoContainer = Instance.new("Frame")
logoContainer.Name = "LogoContainer"
logoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
logoContainer.Position = UDim2.new(0.5, 0, 0.45, 0)
logoContainer.Size = UDim2.new(0, 200, 0, 200)
logoContainer.BackgroundTransparency = 1
logoContainer.ZIndex = 99999

-- Create the logo using your asset ID
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(1, 0, 1, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://119919697523670"  -- Your logo ID
logo.ScaleType = Enum.ScaleType.Fit
logo.ZIndex = 99999

-- Add glow effect to logo
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.Size = UDim2.new(1.2, 0, 1.2, 0)
glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://119919697523670"  -- Same as logo
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
    
    -- Animate glow
    TweenService:Create(glow, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        Size = UDim2.new(1.4, 0, 1.4, 0),
        ImageTransparency = 0.6
    }):Play()
end

-- Create the loading spinner
local spinner = Instance.new("Frame")
spinner.Name = "Spinner"
spinner.AnchorPoint = Vector2.new(0.5, 0.5)
spinner.Position = UDim2.new(0.5, 0, 0.6, 0)
spinner.Size = UDim2.new(0, 60, 0, 60)
spinner.BackgroundTransparency = 1
spinner.ZIndex = 99999

-- Create spinner segments
local spinnerParts = {}
for i = 1, 8 do
    local part = Instance.new("Frame")
    part.Name = "Part"..i
    part.AnchorPoint = Vector2.new(0.5, 0.5)
    part.Position = UDim2.new(0.5, 0, 0.5, 0)
    part.Size = UDim2.new(0, 8, 0, 20)
    part.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    part.BorderSizePixel = 0
    part.Rotation = (i-1) * 45
    part.ZIndex = 99999
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = part
    
    spinnerParts[i] = part
    part.Parent = spinner
end

-- Create loading text
local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.Position = UDim2.new(0.5, 0, 0.75, 0)
loadingText.Size = UDim2.new(0, 300, 0, 40)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading Experience..."
loadingText.TextColor3 = Color3.fromRGB(200, 220, 255)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 22
loadingText.ZIndex = 99999

-- Create progress bar
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.AnchorPoint = Vector2.new(0.5, 0.5)
progressBar.Position = UDim2.new(0.5, 0, 0.8, 0)
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
spinner.Parent = blurContainer
loadingText.Parent = blurContainer
progressBar.Parent = blurContainer
blurContainer.Parent = blurScreen

-- Animation functions
local function animateSpinner()
    local time = 0
    local connection
    
    connection = RunService.RenderStepped:Connect(function(delta)
        time = time + delta
        
        for i, part in ipairs(spinnerParts) do
            local alpha = (time * 2 - (i-1)/8) % 1
            local scale = 0.3 + 0.7 * math.abs(math.sin(alpha * math.pi))
            part.BackgroundTransparency = 0.2 + 0.8 * (1 - scale)
            part.Size = UDim2.new(0, 8, 0, 20 * scale)
        end
    end)
    
    return connection
end

local function animateBlur()
    local tween = TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Size = 24
    })
    tween:Play()
    return tween
end

local function simulateProgress()
    local duration = 4  -- Total loading time
    local startTime = os.clock()
    
    while os.clock() - startTime < duration do
        local progress = (os.clock() - startTime) / duration
        progressFill.Size = UDim2.new(progress, 0, 1, 0)
        
        -- Update loading text
        if progress < 0.3 then
            loadingText.Text = "Loading Assets..."
        elseif progress < 0.6 then
            loadingText.Text = "Initializing Game..."
        else
            loadingText.Text = "Finalizing Experience..."
        end
        
        RunService.RenderStepped:Wait()
    end
    
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    loadingText.Text = "Ready!"
end

-- Main loading function
local function showLoadingScreen()
    -- Add to player GUI
    blurScreen.Parent = playerGui
    
    -- Start animations
    local spinnerConnection = animateSpinner()
    local blurTween = animateBlur()
    startPulse()
    
    -- Simulate loading progress
    simulateProgress()
    
    -- Wait a moment before hiding
    task.wait(1.5)
    
    -- Fade out animation
    local fadeOut = TweenService:Create(blurContainer, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    })
    
    -- Fade out text and logo
    TweenService:Create(logo, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(glow, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        ImageTransparency = 1
    }):Play()
    
    TweenService:Create(loadingText, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        TextTransparency = 1
    }):Play()
    
    TweenService:Create(progressBar, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(progressFill, TweenInfo.new(1, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    }):Play()
    
    fadeOut:Play()
    fadeOut.Completed:Wait()
    
    -- Clean up
    spinnerConnection:Disconnect()
    if pulseTween then pulseTween:Cancel() end
    blurScreen:Destroy()
    blur:Destroy()
end

-- Start the loading screen
showLoadingScreen()
