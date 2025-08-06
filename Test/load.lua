-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui.Name == "TradeGuardGui" or gui.Name == "NotificationGui" then
        gui:Destroy()
    end
end

-- ========== CYBERPUNK THEME ==========
local DARK_BG = Color3.fromRGB(10, 10, 15)
local CARD_BG = Color3.fromRGB(20, 20, 30)
local ACCENT_BLUE = Color3.fromRGB(0, 200, 255)
local ACCENT_PURPLE = Color3.fromRGB(150, 0, 255)
local ACCENT_RED = Color3.fromRGB(255, 50, 100)
local ACCENT_GREEN = Color3.fromRGB(50, 255, 150)
local TEXT_MAIN = Color3.fromRGB(240, 240, 255)
local TEXT_SECONDARY = Color3.fromRGB(180, 180, 220)
local GLOW_COLOR = Color3.fromRGB(0, 150, 255)
local FONT = Enum.Font.GothamBold

-- ========== CREATE MAIN GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"
ScreenGui.DisplayOrder = 10
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main container with cyberpunk styling
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 200)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = CARD_BG
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 8)

-- Grid background
local gridPattern = Instance.new("ImageLabel", MainFrame)
gridPattern.Name = "GridPattern"
gridPattern.Size = UDim2.new(1, 0, 1, 0)
gridPattern.BackgroundTransparency = 1
gridPattern.Image = "rbxassetid://11584599945" -- Grid pattern
gridPattern.ImageTransparency = 0.8
gridPattern.ScaleType = Enum.ScaleType.Tile
gridPattern.TileSize = UDim2.new(0, 50, 0, 50)
gridPattern.ZIndex = 0

-- Scanlines effect
local scanlines = Instance.new("ImageLabel", MainFrame)
scanlines.Name = "Scanlines"
scanlines.Size = UDim2.new(1, 0, 1, 0)
scanlines.BackgroundTransparency = 1
scanlines.Image = "rbxassetid://11584599652" -- Scanlines texture
scanlines.ImageTransparency = 0.9
scanlines.ZIndex = 1

-- Glowing border
local border = Instance.new("Frame", MainFrame)
border.Name = "Border"
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.BackgroundColor3 = ACCENT_BLUE
border.BackgroundTransparency = 0.7
border.ZIndex = -1
local borderCorner = Instance.new("UICorner", border)
borderCorner.CornerRadius = UDim.new(0, 8)

-- Animated border glow
local borderGlow = Instance.new("ImageLabel", border)
borderGlow.Name = "Glow"
borderGlow.Size = UDim2.new(1, 10, 1, 10)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://11584599218" -- Glow texture
borderGlow.ImageColor3 = ACCENT_BLUE
borderGlow.ImageTransparency = 0.5
borderGlow.ZIndex = -1

-- Title bar
local titleBar = Instance.new("Frame", MainFrame)
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundTransparency = 0.9
titleBar.BackgroundColor3 = ACCENT_BLUE
local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 8, 0, 0)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TRADE SECURITY SYSTEM"
titleText.Font = FONT
titleText.TextColor3 = TEXT_MAIN
titleText.TextSize = 16
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.TextStrokeTransparency = 0.8
titleText.TextStrokeColor3 = Color3.fromRGB(0, 50, 100)

-- Close button
local closeBtn = Instance.new("ImageButton", titleBar)
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0.5, -14)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://3926305904" -- X icon
closeBtn.ImageColor3 = TEXT_MAIN
closeBtn.ScaleType = Enum.ScaleType.Fit

-- Protection modules
local function createModule(name, icon, color, position)
    local module = Instance.new("Frame", MainFrame)
    module.Name = name
    module.Size = UDim2.new(0.45, -10, 0, 80)
    module.Position = position
    module.BackgroundColor3 = CARD_BG
    module.BackgroundTransparency = 0.2
    local modCorner = Instance.new("UICorner", module)
    modCorner.CornerRadius = UDim.new(0, 6)
    
    -- Module icon
    local iconFrame = Instance.new("ImageLabel", module)
    iconFrame.Name = "Icon"
    iconFrame.Size = UDim2.new(0, 36, 0, 36)
    iconFrame.Position = UDim2.new(0.5, -18, 0, 10)
    iconFrame.BackgroundTransparency = 1
    iconFrame.Image = icon
    iconFrame.ImageColor3 = color
    
    -- Module name
    local nameLabel = Instance.new("TextLabel", module)
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, -10, 0, 20)
    nameLabel.Position = UDim2.new(0, 5, 0, 50)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name:upper()
    nameLabel.Font = FONT
    nameLabel.TextColor3 = TEXT_MAIN
    nameLabel.TextSize = 12
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    -- Status indicator
    local status = Instance.new("Frame", module)
    status.Name = "Status"
    status.Size = UDim2.new(0, 12, 0, 12)
    status.Position = UDim2.new(0.5, -6, 1, -18)
    status.BackgroundColor3 = ACCENT_RED
    status.BorderSizePixel = 0
    local statusCorner = Instance.new("UICorner", status)
    statusCorner.CornerRadius = UDim.new(1, 0)
    
    -- Status glow
    local statusGlow = Instance.new("ImageLabel", status)
    statusGlow.Size = UDim2.new(2, 0, 2, 0)
    statusGlow.Position = UDim2.new(-0.5, 0, -0.5, 0)
    statusGlow.BackgroundTransparency = 1
    statusGlow.Image = "rbxassetid://11584599218" -- Glow texture
    statusGlow.ImageColor3 = ACCENT_RED
    statusGlow.ImageTransparency = 0.7
    statusGlow.ZIndex = -1
    
    -- Activation button
    local btn = Instance.new("TextButton", module)
    btn.Name = "ActivateButton"
    btn.Size = UDim2.new(1, -20, 0, 26)
    btn.Position = UDim2.new(0, 10, 1, -36)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.2
    btn.Text = "ACTIVATE"
    btn.Font = FONT
    btn.TextColor3 = TEXT_MAIN
    btn.TextSize = 12
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 4)
    
    -- Button glow
    local btnGlow = Instance.new("ImageLabel", btn)
    btnGlow.Size = UDim2.new(1, 10, 1, 10)
    btnGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    btnGlow.BackgroundTransparency = 1
    btnGlow.Image = "rbxassetid://11584599218" -- Glow texture
    btnGlow.ImageColor3 = color
    btnGlow.ImageTransparency = 0.8
    btnGlow.ZIndex = -1
    
    return module, btn, status
end

-- Create protection modules
local FrostShield, FrostButton, FrostStatus = createModule(
    "Frost Shield",
    "rbxassetid://11584599488", -- Shield icon
    ACCENT_BLUE,
    UDim2.new(0, 15, 0, 45)
    
local AcceptSentinel, AcceptButton, AcceptStatus = createModule(
    "Accept Sentinel",
    "rbxassetid://11584599027", -- Sentinel icon
    ACCENT_PURPLE,
    UDim2.new(1, -155, 0, 45))

-- Global status
local globalStatus = Instance.new("TextLabel", MainFrame)
globalStatus.Size = UDim2.new(1, -20, 0, 24)
globalStatus.Position = UDim2.new(0, 10, 1, -30)
globalStatus.BackgroundTransparency = 1
globalStatus.Text = "SYSTEM OFFLINE"
globalStatus.Font = FONT
globalStatus.TextColor3 = ACCENT_RED
globalStatus.TextSize = 14
globalStatus.TextXAlignment = Enum.TextXAlignment.Center

-- Live indicator
local liveIndicator = Instance.new("Frame", MainFrame)
liveIndicator.Name = "LiveIndicator"
liveIndicator.Size = UDim2.new(0, 10, 0, 10)
liveIndicator.Position = UDim2.new(1, -20, 1, -20)
liveIndicator.BackgroundColor3 = ACCENT_RED
liveIndicator.BorderSizePixel = 0
local liveCorner = Instance.new("UICorner", liveIndicator)
liveCorner.CornerRadius = UDim.new(1, 0)

-- Pulse animation
local pulse = TweenService:Create(liveIndicator, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    BackgroundTransparency = 0.5
})

-- ========== NOTIFICATION SYSTEM ==========
local NotificationGui = Instance.new("ScreenGui", PlayerGui)
NotificationGui.Name = "NotificationGui"
NotificationGui.DisplayOrder = 20
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationFrame = Instance.new("Frame", NotificationGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0, 280, 0, 0)
NotificationFrame.Position = UDim2.new(0.5, -140, 0.02, 0)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, color)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local container = Instance.new("Frame", NotificationFrame)
    container.Name = notificationId
    container.Size = UDim2.new(1, 0, 0, 70)
    container.BackgroundColor3 = CARD_BG
    container.BackgroundTransparency = 0.1
    container.Position = UDim2.new(0, 0, 0, -70)
    local containerCorner = Instance.new("UICorner", container)
    containerCorner.CornerRadius = UDim.new(0, 8)
    
    -- Glowing border
    local notifBorder = Instance.new("Frame", container)
    notifBorder.Size = UDim2.new(1, 4, 1, 4)
    notifBorder.Position = UDim2.new(0, -2, 0, -2)
    notifBorder.BackgroundColor3 = color
    notifBorder.BackgroundTransparency = 0.7
    notifBorder.ZIndex = -1
    local borderCorner = Instance.new("UICorner", notifBorder)
    borderCorner.CornerRadius = UDim.new(0, 8)
    
    local notifGlow = Instance.new("ImageLabel", notifBorder)
    notifGlow.Size = UDim2.new(1, 10, 1, 10)
    notifGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    notifGlow.BackgroundTransparency = 1
    notifGlow.Image = "rbxassetid://11584599218" -- Glow texture
    notifGlow.ImageColor3 = color
    notifGlow.ImageTransparency = 0.6
    notifGlow.ZIndex = -1
    
    -- Title
    local titleLabel = Instance.new("TextLabel", container)
    titleLabel.Size = UDim2.new(1, -20, 0.5, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "⚡ "..title
    titleLabel.Font = FONT
    titleLabel.TextColor3 = color
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Message
    local msgLabel = Instance.new("TextLabel", container)
    msgLabel.Size = UDim2.new(1, -20, 0.5, 0)
    msgLabel.Position = UDim2.new(0, 15, 0.5, 0)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = message
    msgLabel.Font = FONT
    msgLabel.TextColor3 = TEXT_MAIN
    msgLabel.TextSize = 14
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Icon
    local icon = Instance.new("ImageLabel", container)
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(1, -40, 0.5, -15)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://11584599027" -- Default icon
    icon.ImageColor3 = color
    
    -- Animation
    container.ClipsDescendants = true
    local slideIn = TweenService:Create(container, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()
    
    -- Remove after duration
    task.delay(4, function()
        if container and container.Parent then
            local slideOut = TweenService:Create(container, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                Position = UDim2.new(0, 0, 0, -70)
            })
            slideOut:Play()
            slideOut.Completed:Wait()
            container:Destroy()
        end
    end)
end

-- ========== PROTECTION SYSTEM ==========
local frostActive = false
local acceptActive = false
local frostEndTime = 0
local acceptEndTime = 0

local function updateStatus()
    -- Update frost shield status
    if frostActive then
        local remaining = math.max(0, frostEndTime - tick())
        if remaining > 0 then
            FrostStatus.BackgroundColor3 = ACCENT_BLUE
            FrostButton.Text = math.floor(remaining).."s"
        else
            frostActive = false
            FrostStatus.BackgroundColor3 = ACCENT_RED
            FrostButton.Text = "ACTIVATE"
            showNotification("FROST SHIELD", "Protection expired", ACCENT_BLUE)
        end
    else
        FrostStatus.BackgroundColor3 = ACCENT_RED
        FrostButton.Text = "ACTIVATE"
    end
    
    -- Update accept sentinel status
    if acceptActive then
        local remaining = math.max(0, acceptEndTime - tick())
        if remaining > 0 then
            AcceptStatus.BackgroundColor3 = ACCENT_PURPLE
            AcceptButton.Text = math.floor(remaining).."s"
        else
            acceptActive = false
            AcceptStatus.BackgroundColor3 = ACCENT_RED
            AcceptButton.Text = "ACTIVATE"
            showNotification("ACCEPT SENTINEL", "Protection expired", ACCENT_PURPLE)
        end
    else
        AcceptStatus.BackgroundColor3 = ACCENT_RED
        AcceptButton.Text = "ACTIVATE"
    end
    
    -- Update global status
    if frostActive or acceptActive then
        globalStatus.Text = "SYSTEM ACTIVE"
        globalStatus.TextColor3 = ACCENT_GREEN
        liveIndicator.BackgroundColor3 = ACCENT_GREEN
        pulse:Play()
    else
        globalStatus.Text = "SYSTEM OFFLINE"
        globalStatus.TextColor3 = ACCENT_RED
        liveIndicator.BackgroundColor3 = ACCENT_RED
        pulse:Stop()
        liveIndicator.BackgroundTransparency = 0
    end
end

-- Frost Shield activation
local function activateFrostShield()
    if frostActive then return end
    
    frostActive = true
    frostEndTime = tick() + 300 -- 5 minutes
    FrostButton.Text = "300s"
    showNotification("FROST SHIELD", "Activated for 5 minutes", ACCENT_BLUE)
    
    while frostActive and tick() < frostEndTime do
        updateStatus()
        task.wait(1)
    end
    
    frostActive = false
    updateStatus()
end

-- Accept Sentinel activation
local function activateAcceptSentinel()
    if acceptActive then return end
    
    acceptActive = true
    acceptEndTime = tick() + 300 -- 5 minutes
    AcceptButton.Text = "300s"
    showNotification("ACCEPT SENTINEL", "Activated for 5 minutes", ACCENT_PURPLE)
    
    while acceptActive and tick() < acceptEndTime do
        updateStatus()
        task.wait(1)
    end
    
    acceptActive = false
    updateStatus()
end

-- ========== TRADE SIMULATION ==========
local function simulateTrade()
    showNotification("TRADE DETECTED", "Initializing security scan...", ACCENT_BLUE)
    
    -- Scan sequence
    for i = 1, 3 do
        task.wait(0.8)
        showNotification("SCANNING", "Analyzing trade partner ("..i.."/3)", ACCENT_PURPLE)
    end
    
    -- Threat detection
    local threats = {}
    if frostActive and math.random() > 0.6 then
        table.insert(threats, {"Freeze exploit", ACCENT_RED})
    end
    if acceptActive and math.random() > 0.7 then
        table.insert(threats, {"Auto-accept pattern", ACCENT_RED})
    end
    
    if #threats > 0 then
        local threatMsg = "Threats detected: "
        for i, threat in ipairs(threats) do
            threatMsg = threatMsg..threat[1]
            if i < #threats then threatMsg = threatMsg..", " end
        end
        showNotification("WARNING", threatMsg, ACCENT_RED)
        
        -- Neutralize threats
        task.wait(1.5)
        for _, threat in ipairs(threats) do
            showNotification("NEUTRALIZED", "Blocked "..threat[1], ACCENT_GREEN)
            task.wait(0.8)
        end
    else
        showNotification("SECURE", "No threats detected", ACCENT_GREEN)
    end
    
    -- Complete trade
    task.wait(1.2)
    showNotification("TRADE COMPLETE", "Items successfully exchanged", ACCENT_GREEN)
end

-- ========== UI INTERACTIONS ==========
-- Close button
closeBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    NotificationGui:Destroy()
end)

-- Frost Shield button
FrostButton.MouseButton1Click:Connect(activateFrostShield)

-- Accept Sentinel button
AcceptButton.MouseButton1Click:Connect(activateAcceptSentinel)

-- Initial update
updateStatus()

-- Welcome notification
task.delay(1.5, function()
    showNotification("SECURITY SYSTEM ONLINE", "Protection modules initialized", ACCENT_BLUE)
end)

-- Simulate periodic trades
task.spawn(function()
    while true do
        task.wait(math.random(20, 40))
        simulateTrade()
    end
end)

-- Update status continuously
RunService.Heartbeat:Connect(updateStatus)

-- Create background particles
task.spawn(function()
    local particleContainer = Instance.new("Frame", MainFrame)
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.ZIndex = 0
    
    while true do
        if #particleContainer:GetChildren() < 15 then
            local particle = Instance.new("Frame", particleContainer)
            particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
            particle.Position = UDim2.new(0, math.random(0, 320), 0, math.random(0, 200))
            particle.BackgroundColor3 = ACCENT_BLUE
            particle.BackgroundTransparency = 0.7
            
            TweenService:Create(particle, TweenInfo.new(math.random(1, 3)), {
                Position = UDim2.new(0, math.random(0, 320), 0, math.random(0, 200)),
                BackgroundTransparency = 1
            }):Play()
            
            particle:Destroy()
        end
        task.wait(0.2)
    end
end)
