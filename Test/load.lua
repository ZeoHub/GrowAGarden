-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
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

-- ========== Enhanced Theme Settings ==========
local DARK_BG = Color3.fromRGB(15, 15, 25)
local CARD_BG = Color3.fromRGB(30, 30, 45)
local ACCENT_BLUE = Color3.fromRGB(80, 170, 255)
local ACCENT_GREEN = Color3.fromRGB(100, 230, 150)
local ACCENT_RED = Color3.fromRGB(240, 90, 90)
local ACCENT_YELLOW = Color3.fromRGB(255, 210, 50)
local TEXT_MAIN = Color3.fromRGB(245, 245, 245)
local TEXT_SECONDARY = Color3.fromRGB(180, 180, 210)
local TOGGLE_ON = ACCENT_BLUE
local TOGGLE_OFF = Color3.fromRGB(70, 70, 100)
local FONT = Enum.Font.GothamMedium
local SHADOW_COLOR = Color3.fromRGB(5, 5, 10)
local GLOW_INTENSITY = 0.15

-- ========== Create Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"
ScreenGui.DisplayOrder = 10
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Enhanced main frame with glass effect
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 160)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -80)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true

local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

-- Glass effect
local GlassEffect = Instance.new("Frame", MainFrame)
GlassEffect.Name = "GlassEffect"
GlassEffect.Size = UDim2.new(1, 0, 1, 0)
GlassEffect.BackgroundTransparency = 0.95
GlassEffect.BackgroundColor3 = Color3.new(1, 1, 1)
GlassEffect.BorderSizePixel = 0
local glassCorner = Instance.new("UICorner", GlassEffect)
glassCorner.CornerRadius = UDim.new(0, 12)

-- Enhanced shadow with glow effect
local mainShadow = Instance.new("ImageLabel", MainFrame)
mainShadow.Name = "Shadow"
mainShadow.Size = UDim2.new(1, 20, 1, 20)
mainShadow.Position = UDim2.new(0, -10, 0, -10)
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://5554236805" -- Soft glow image
mainShadow.ImageColor3 = ACCENT_BLUE
mainShadow.ImageTransparency = 0.8
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(20, 20, 280, 280)
mainShadow.ZIndex = -1

-- Title bar with gradient
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = CARD_BG
local titleBarCorner = Instance.new("UICorner", TitleBar)
titleBarCorner.CornerRadius = UDim.new(0, 12, 0, 0)

-- Gradient effect for title bar
local titleGradient = Instance.new("UIGradient", TitleBar)
titleGradient.Rotation = 90
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 90)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TRADE GUARDIAN"
TitleText.Font = FONT
TitleText.TextColor3 = TEXT_MAIN
TitleText.TextSize = 15
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.TextStrokeTransparency = 0.8

-- Close button with hover effect
local CloseButton = Instance.new("ImageButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Position = UDim2.new(1, -30, 0.5, -13)
CloseButton.BackgroundColor3 = ACCENT_RED
CloseButton.Image = "rbxassetid://3926305904" -- X icon
CloseButton.ScaleType = Enum.ScaleType.Fit
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(1, 0)

-- Close button glow
local closeGlow = Instance.new("ImageLabel", CloseButton)
closeGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
closeGlow.Position = UDim2.new(-0.2, 0, -0.2, 0)
closeGlow.BackgroundTransparency = 1
closeGlow.Image = "rbxassetid://5554236805" -- Soft glow image
closeGlow.ImageColor3 = ACCENT_RED
closeGlow.ImageTransparency = 0.9
closeGlow.ZIndex = -1

-- ========== Enhanced Protection Boxes ==========
local function createProtectionBox(parent, name, iconId, color)
    local Box = Instance.new("Frame", parent)
    Box.Name = name
    Box.Size = UDim2.new(0.45, -10, 0, 75)
    Box.BackgroundColor3 = CARD_BG
    Box.BackgroundTransparency = 0.1
    Box.ClipsDescendants = true
    local boxCorner = Instance.new("UICorner", Box)
    boxCorner.CornerRadius = UDim.new(0, 8)
    
    -- Background pattern
    local Pattern = Instance.new("ImageLabel", Box)
    Pattern.Size = UDim2.new(1, 0, 1, 0)
    Pattern.BackgroundTransparency = 1
    Pattern.Image = "rbxassetid://8995986363" -- Subtle hex pattern
    Pattern.ImageTransparency = 0.95
    Pattern.ImageColor3 = color
    Pattern.ScaleType = Enum.ScaleType.Tile
    Pattern.TileSize = UDim2.new(0, 50, 0, 50)
    
    -- Box header
    local IconFrame = Instance.new("Frame", Box)
    IconFrame.Size = UDim2.new(0, 32, 0, 32)
    IconFrame.Position = UDim2.new(0.5, -16, 0, 10)
    IconFrame.BackgroundColor3 = color
    IconFrame.BackgroundTransparency = 0.2
    local iconCorner = Instance.new("UICorner", IconFrame)
    iconCorner.CornerRadius = UDim.new(1, 0)
    
    local Icon = Instance.new("ImageLabel", IconFrame)
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.Position = UDim2.new(0.5, -10, 0.5, -10)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconId
    Icon.ImageColor3 = TEXT_MAIN
    
    -- Icon glow
    local iconGlow = Instance.new("ImageLabel", Icon)
    iconGlow.Size = UDim2.new(2, 0, 2, 0)
    iconGlow.Position = UDim2.new(-0.5, 0, -0.5, 0)
    iconGlow.BackgroundTransparency = 1
    iconGlow.Image = "rbxassetid://5554236805" -- Soft glow image
    iconGlow.ImageColor3 = color
    iconGlow.ImageTransparency = 0.85
    iconGlow.ZIndex = -1
    
    -- Toggle switch
    local ToggleFrame = Instance.new("Frame", Box)
    ToggleFrame.Name = "Toggle"
    ToggleFrame.Size = UDim2.new(0, 44, 0, 24)
    ToggleFrame.Position = UDim2.new(0.5, -22, 1, -32)
    ToggleFrame.BackgroundColor3 = TOGGLE_OFF
    local toggleCorner = Instance.new("UICorner", ToggleFrame)
    toggleCorner.CornerRadius = UDim.new(1, 0)
    
    local ToggleButton = Instance.new("TextButton", ToggleFrame)
    ToggleButton.Name = "Button"
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    ToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    ToggleButton.BackgroundColor3 = TEXT_MAIN
    ToggleButton.AutoButtonColor = false
    ToggleButton.Text = ""
    local buttonCorner = Instance.new("UICorner", ToggleButton)
    buttonCorner.CornerRadius = UDim.new(1, 0)
    
    -- Toggle glow
    local toggleGlow = Instance.new("ImageLabel", ToggleButton)
    toggleGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    toggleGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    toggleGlow.BackgroundTransparency = 1
    toggleGlow.Image = "rbxassetid://5554236805" -- Soft glow image
    toggleGlow.ImageColor3 = color
    toggleGlow.ImageTransparency = 0.9
    toggleGlow.ZIndex = -1
    
    -- Settings button
    local SettingsButton = Instance.new("ImageButton", Box)
    SettingsButton.Name = "SettingsButton"
    SettingsButton.Size = UDim2.new(0, 24, 0, 24)
    SettingsButton.Position = UDim2.new(1, -28, 0, 10)
    SettingsButton.BackgroundTransparency = 1
    SettingsButton.Image = "rbxassetid://3926307971" -- Gear icon
    SettingsButton.ImageColor3 = TEXT_MAIN
    SettingsButton.ScaleType = Enum.ScaleType.Fit
    
    -- Status label
    local StatusLabel = Instance.new("TextLabel", Box)
    StatusLabel.Size = UDim2.new(1, -10, 0, 18)
    StatusLabel.Position = UDim2.new(0, 5, 1, -38)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "INACTIVE"
    StatusLabel.Font = FONT
    StatusLabel.TextColor3 = TEXT_SECONDARY
    StatusLabel.TextSize = 12
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
    StatusLabel.TextStrokeTransparency = 0.8
    
    return Box, ToggleButton, SettingsButton, StatusLabel
end

-- Frost Shield Box
local FrostShieldBox, FrostToggleButton, FrostSettings, FrostStatus = createProtectionBox(
    MainFrame, 
    "FrostShieldBox", 
    "rbxassetid://3926305904", -- Snowflake icon
    ACCENT_BLUE
)
FrostShieldBox.Position = UDim2.new(0, 12, 0, 38)

-- Accept Sentinel Box
local AcceptSentinelBox, AcceptToggleButton, AcceptSettings, AcceptStatus = createProtectionBox(
    MainFrame, 
    "AcceptSentinelBox", 
    "rbxassetid://3926307971", -- Checkmark icon
    ACCENT_GREEN
)
AcceptSentinelBox.Position = UDim2.new(1, -132, 0, 38)

-- Global status with animated dots
local GlobalStatus = Instance.new("TextLabel", MainFrame)
GlobalStatus.Size = UDim2.new(1, -20, 0, 20)
GlobalStatus.Position = UDim2.new(0, 10, 1, -25)
GlobalStatus.BackgroundTransparency = 1
GlobalStatus.Text = "GUARDIAN INACTIVE"
GlobalStatus.Font = FONT
GlobalStatus.TextColor3 = TEXT_SECONDARY
GlobalStatus.TextSize = 13
GlobalStatus.TextXAlignment = Enum.TextXAlignment.Center
GlobalStatus.TextStrokeTransparency = 0.8

-- ========== Animated Live Status ==========
local LiveIndicator = Instance.new("Frame", MainFrame)
LiveIndicator.Name = "LiveIndicator"
LiveIndicator.Size = UDim2.new(0, 10, 0, 10)
LiveIndicator.Position = UDim2.new(1, -18, 1, -18)
LiveIndicator.BackgroundColor3 = ACCENT_RED
LiveIndicator.BorderSizePixel = 0
local indicatorCorner = Instance.new("UICorner", LiveIndicator)
indicatorCorner.CornerRadius = UDim.new(1, 0)

-- Pulsing glow effect
local pulseGlow = Instance.new("ImageLabel", LiveIndicator)
pulseGlow.Size = UDim2.new(2, 0, 2, 0)
pulseGlow.Position = UDim2.new(-0.5, 0, -0.5, 0)
pulseGlow.BackgroundTransparency = 1
pulseGlow.Image = "rbxassetid://5554236805" -- Soft glow image
pulseGlow.ImageColor3 = ACCENT_RED
pulseGlow.ImageTransparency = 0.9
pulseGlow.ZIndex = -1

local LiveText = Instance.new("TextLabel", MainFrame)
LiveText.Name = "LiveText"
LiveText.Size = UDim2.new(0, 50, 0, 14)
LiveText.Position = UDim2.new(1, -65, 1, -19)
LiveText.BackgroundTransparency = 1
LiveText.Text = "OFFLINE"
LiveText.Font = FONT
LiveText.TextColor3 = TEXT_SECONDARY
LiveText.TextSize = 11
LiveText.TextXAlignment = Enum.TextXAlignment.Right
LiveText.TextStrokeTransparency = 0.8

-- ========== Enhanced Settings Modal ==========
local ModalFrame = Instance.new("Frame", ScreenGui)
ModalFrame.Name = "SettingsModal"
ModalFrame.Size = UDim2.new(0, 240, 0, 180)
ModalFrame.Position = UDim2.new(0.5, -120, 0.5, -90)
ModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ModalFrame.BackgroundColor3 = CARD_BG
ModalFrame.BackgroundTransparency = 0.1
ModalFrame.Visible = false
ModalFrame.ZIndex = 20
local modalCorner = Instance.new("UICorner", ModalFrame)
modalCorner.CornerRadius = UDim.new(0, 12)

-- Glass effect
local modalGlass = Instance.new("Frame", ModalFrame)
modalGlass.Size = UDim2.new(1, 0, 1, 0)
modalGlass.BackgroundTransparency = 0.95
modalGlass.BackgroundColor3 = Color3.new(1, 1, 1)
modalGlass.BorderSizePixel = 0
local modalGlassCorner = Instance.new("UICorner", modalGlass)
modalGlassCorner.CornerRadius = UDim.new(0, 12)

-- Enhanced shadow with glow
local modalShadow = Instance.new("ImageLabel", ModalFrame)
modalShadow.Name = "Shadow"
modalShadow.Size = UDim2.new(1, 20, 1, 20)
modalShadow.Position = UDim2.new(0, -10, 0, -10)
modalShadow.BackgroundTransparency = 1
modalShadow.Image = "rbxassetid://5554236805" -- Soft glow image
modalShadow.ImageColor3 = ACCENT_BLUE
modalShadow.ImageTransparency = 0.8
modalShadow.ScaleType = Enum.ScaleType.Slice
modalShadow.SliceCenter = Rect.new(20, 20, 280, 280)
modalShadow.ZIndex = -1

local ModalTitle = Instance.new("TextLabel", ModalFrame)
ModalTitle.Size = UDim2.new(1, 0, 0, 36)
ModalTitle.Position = UDim2.new(0, 0, 0, 0)
ModalTitle.BackgroundColor3 = ACCENT_BLUE
ModalTitle.BackgroundTransparency = 0.2
ModalTitle.Text = "DURATION SETTINGS"
ModalTitle.Font = FONT
ModalTitle.TextColor3 = TEXT_MAIN
ModalTitle.TextSize = 15
local titleCorner = Instance.new("UICorner", ModalTitle)
titleCorner.CornerRadius = UDim.new(0, 12, 0, 0)

-- Title gradient
local modalTitleGradient = Instance.new("UIGradient", ModalTitle)
modalTitleGradient.Rotation = 90
modalTitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 140, 220))
})

local DurationLabel = Instance.new("TextLabel", ModalFrame)
DurationLabel.Size = UDim2.new(1, -20, 0, 28)
DurationLabel.Position = UDim2.new(0, 10, 0, 45)
DurationLabel.BackgroundTransparency = 1
DurationLabel.Text = "Set duration (seconds):"
DurationLabel.Font = FONT
DurationLabel.TextColor3 = TEXT_SECONDARY
DurationLabel.TextSize = 13
DurationLabel.TextXAlignment = Enum.TextXAlignment.Left

local DurationInput = Instance.new("TextBox", ModalFrame)
DurationInput.Size = UDim2.new(1, -30, 0, 36)
DurationInput.Position = UDim2.new(0, 15, 0, 75)
DurationInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
DurationInput.BackgroundTransparency = 0.1
DurationInput.PlaceholderText = "Enter duration"
DurationInput.Text = "300"
DurationInput.TextColor3 = TEXT_MAIN
DurationInput.TextSize = 14
DurationInput.Font = FONT
DurationInput.ClearTextOnFocus = false
local inputCorner = Instance.new("UICorner", DurationInput)
inputCorner.CornerRadius = UDim.new(0, 8)

-- Input glow on focus
DurationInput.Focused:Connect(function()
    TweenService:Create(DurationInput, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    }):Play()
end)

DurationInput.FocusLost:Connect(function()
    TweenService:Create(DurationInput, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    }):Play()
end)

local ConfirmButton = Instance.new("TextButton", ModalFrame)
ConfirmButton.Size = UDim2.new(0.4, 0, 0, 32)
ConfirmButton.Position = UDim2.new(0.1, 0, 1, -38)
ConfirmButton.BackgroundColor3 = ACCENT_GREEN
ConfirmButton.BackgroundTransparency = 0.1
ConfirmButton.Text = "CONFIRM"
ConfirmButton.Font = FONT
ConfirmButton.TextColor3 = TEXT_MAIN
ConfirmButton.TextSize = 13
local confirmCorner = Instance.new("UICorner", ConfirmButton)
confirmCorner.CornerRadius = UDim.new(0, 8)

-- Button gradient
local confirmGradient = Instance.new("UIGradient", ConfirmButton)
confirmGradient.Rotation = 90
confirmGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 230, 170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 200, 140))
})

local CancelButton = Instance.new("TextButton", ModalFrame)
CancelButton.Size = UDim2.new(0.4, 0, 0, 32)
CancelButton.Position = UDim2.new(0.55, 0, 1, -38)
CancelButton.BackgroundColor3 = ACCENT_RED
CancelButton.BackgroundTransparency = 0.1
CancelButton.Text = "CANCEL"
CancelButton.Font = FONT
CancelButton.TextColor3 = TEXT_MAIN
CancelButton.TextSize = 13
local cancelCorner = Instance.new("UICorner", CancelButton)
cancelCorner.CornerRadius = UDim.new(0, 8)

-- Button gradient
local cancelGradient = Instance.new("UIGradient", CancelButton)
cancelGradient.Rotation = 90
cancelGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 110, 110)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 80, 80))
})

-- ========== Enhanced Notification System ==========
local NotificationGui = Instance.new("ScreenGui", PlayerGui)
NotificationGui.Name = "NotificationGui"
NotificationGui.DisplayOrder = 20
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationFrame = Instance.new("Frame", NotificationGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0, 260, 0, 0)
NotificationFrame.Position = UDim2.new(0.5, -130, 0.02, 0)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, color)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame", NotificationFrame)
    Container.Name = notificationId
    Container.Size = UDim2.new(1, 0, 0, 70)
    Container.BackgroundColor3 = CARD_BG
    Container.BackgroundTransparency = 0.1
    Container.Position = UDim2.new(0, 0, 0, -70)
    local containerCorner = Instance.new("UICorner", Container)
    containerCorner.CornerRadius = UDim.new(0, 12)
    
    -- Glass effect
    local notificationGlass = Instance.new("Frame", Container)
    notificationGlass.Size = UDim2.new(1, 0, 1, 0)
    notificationGlass.BackgroundTransparency = 0.95
    notificationGlass.BackgroundColor3 = Color3.new(1, 1, 1)
    notificationGlass.BorderSizePixel = 0
    local glassCorner = Instance.new("UICorner", notificationGlass)
    glassCorner.CornerRadius = UDim.new(0, 12)
    
    -- Glow effect
    local glow = Instance.new("ImageLabel", Container)
    glow.Size = UDim2.new(1, 10, 1, 10)
    glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5554236805" -- Soft glow image
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.8
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(20, 20, 280, 280)
    glow.ZIndex = -1
    
    -- Accent bar with gradient
    local AccentBar = Instance.new("Frame", Container)
    AccentBar.Size = UDim2.new(0, 6, 1, -10)
    AccentBar.Position = UDim2.new(0, 5, 0, 5)
    AccentBar.BackgroundColor3 = color
    local barGradient = Instance.new("UIGradient", AccentBar)
    barGradient.Rotation = 90
    barGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color),
        ColorSequenceKeypoint.new(1, Color3.new(color.R * 0.7, color.G * 0.7, color.B * 0.7))
    })
    local barCorner = Instance.new("UICorner", AccentBar)
    barCorner.CornerRadius = UDim.new(0, 3)
    
    local TitleLabel = Instance.new("TextLabel", Container)
    TitleLabel.Size = UDim2.new(1, -30, 0.45, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = FONT
    TitleLabel.TextColor3 = TEXT_MAIN
    TitleLabel.TextSize = 15
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextStrokeTransparency = 0.8
    
    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Size = UDim2.new(1, -20, 0.45, 0)
    MessageLabel.Position = UDim2.new(0, 20, 0.5, 0)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.Font = FONT
    MessageLabel.TextColor3 = TEXT_SECONDARY
    MessageLabel.TextSize = 13
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextStrokeTransparency = 0.8
    
    -- Notification icon
    local iconType = if string.find(title, "FROST") then "rbxassetid://3926305904"
        elseif string.find(title, "ACCEPT") then "rbxassetid://3926307971"
        else "rbxassetid://3926307967" -- Default info icon
    
    local Icon = Instance.new("ImageLabel", Container)
    Icon.Size = UDim2.new(0, 24, 0, 24)
    Icon.Position = UDim2.new(1, -32, 0.5, -12)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconType
    Icon.ImageColor3 = color
    
    -- Animation
    Container.ClipsDescendants = true
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()
    
    -- Remove after duration
    task.delay(3.5, function()
        if Container and Container.Parent then
            local slideOut = TweenService:Create(Container, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
                Position = UDim2.new(0, 0, 0, -70)
            })
            slideOut:Play()
            slideOut.Completed:Wait()
            Container:Destroy()
        end
    end)
end

-- ========== Protection Functions ==========
local frostShieldEnabled = false
local acceptSentinelEnabled = false
local frostShieldDuration = 300
local acceptSentinelDuration = 300
local currentSetting = ""
local frostEndTime = 0
local acceptEndTime = 0
local pulseTween = nil

-- Update status labels
local function updateStatusLabels()
    -- Frost Shield status
    if frostShieldEnabled then
        local remaining = math.ceil(frostEndTime - tick())
        if remaining > 0 then
            FrostStatus.Text = remaining.."s"
            FrostStatus.TextColor3 = ACCENT_BLUE
        else
            frostShieldEnabled = false
            FrostStatus.Text = "INACTIVE"
            FrostStatus.TextColor3 = TEXT_SECONDARY
        end
    else
        FrostStatus.Text = "INACTIVE"
        FrostStatus.TextColor3 = TEXT_SECONDARY
    end
    
    -- Accept Sentinel status
    if acceptSentinelEnabled then
        local remaining = math.ceil(acceptEndTime - tick())
        if remaining > 0 then
            AcceptStatus.Text = remaining.."s"
            AcceptStatus.TextColor3 = ACCENT_GREEN
        else
            acceptSentinelEnabled = false
            AcceptStatus.Text = "INACTIVE"
            AcceptStatus.TextColor3 = TEXT_SECONDARY
        end
    else
        AcceptStatus.Text = "INACTIVE"
        AcceptStatus.TextColor3 = TEXT_SECONDARY
    end
    
    -- Global status
    if frostShieldEnabled or acceptSentinelEnabled then
        GlobalStatus.Text = "GUARDIAN ACTIVE"
        GlobalStatus.TextColor3 = TEXT_MAIN
    else
        GlobalStatus.Text = "GUARDIAN INACTIVE"
        GlobalStatus.TextColor3 = TEXT_SECONDARY
    end
end

-- Toggle animations
local function toggleSwitch(button, frame, state)
    if state then
        TweenService:Create(button, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 22, 0.5, -10),
            BackgroundColor3 = TEXT_MAIN
        }):Play()
        TweenService:Create(frame, TweenInfo.new(0.2), {
            BackgroundColor3 = TOGGLE_ON
        }):Play()
    else
        TweenService:Create(button, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = TEXT_MAIN
        }):Play()
        TweenService:Create(frame, TweenInfo.new(0.2), {
            BackgroundColor3 = TOGGLE_OFF
        }):Play()
    end
end

-- Frost Shield protection
local function startFrostShield()
    frostShieldEnabled = true
    frostEndTime = tick() + frostShieldDuration
    toggleSwitch(FrostToggleButton, FrostToggleButton.Parent, true)
    showNotification("FROST SHIELD", "Active for "..frostShieldDuration.."s", ACCENT_BLUE)
    
    -- Simulate protection
    while tick() < frostEndTime and frostShieldEnabled do
        updateStatusLabels()
        updateLiveStatus()
        task.wait(1)
    end
    
    if frostShieldEnabled then
        frostShieldEnabled = false
        toggleSwitch(FrostToggleButton, FrostToggleButton.Parent, false)
        showNotification("FROST SHIELD", "Protection expired", TEXT_SECONDARY)
    end
    updateStatusLabels()
    updateLiveStatus()
end

-- Accept Sentinel protection
local function startAcceptSentinel()
    acceptSentinelEnabled = true
    acceptEndTime = tick() + acceptSentinelDuration
    toggleSwitch(AcceptToggleButton, AcceptToggleButton.Parent, true)
    showNotification("ACCEPT SENTINEL", "Active for "..acceptSentinelDuration.."s", ACCENT_GREEN)
    
    -- Simulate protection
    while tick() < acceptEndTime and acceptSentinelEnabled do
        updateStatusLabels()
        updateLiveStatus()
        task.wait(1)
    end
    
    if acceptSentinelEnabled then
        acceptSentinelEnabled = false
        toggleSwitch(AcceptToggleButton, AcceptToggleButton.Parent, false)
        showNotification("ACCEPT SENTINEL", "Protection expired", TEXT_SECONDARY)
    end
    updateStatusLabels()
    updateLiveStatus()
end

-- Function to update live status
function updateLiveStatus()
    if pulseTween then
        pulseTween:Cancel()
        pulseTween = nil
    end
    
    if frostShieldEnabled or acceptSentinelEnabled then
        LiveIndicator.BackgroundColor3 = ACCENT_GREEN
        LiveText.Text = "LIVE"
        LiveText.TextColor3 = ACCENT_GREEN
        
        -- Add pulse animation when active
        pulseTween = TweenService:Create(LiveIndicator, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.5
        })
        pulseTween:Play()
    else
        LiveIndicator.BackgroundColor3 = ACCENT_RED
        LiveText.Text = "OFFLINE"
        LiveText.TextColor3 = TEXT_SECONDARY
        LiveIndicator.BackgroundTransparency = 0
    end
end

-- ========== Kick Risk Assessment ==========
local function calculateKickRisk(severity)
    -- Base risk based on severity
    local baseRisk = severity * 70
    
    -- Add randomness
    local randomFactor = math.random(-15, 25)
    
    -- Calculate final risk (clamped between 10-99%)
    local risk = math.clamp(baseRisk + randomFactor, 10, 99)
    
    return risk
end

-- ========== Kick Simulation ==========
local function simulateKick()
    -- Create kick message GUI
    local KickGui = Instance.new("ScreenGui", PlayerGui)
    KickGui.Name = "KickGui"
    KickGui.DisplayOrder = 100
    KickGui.IgnoreGuiInset = true
    
    local KickFrame = Instance.new("Frame", KickGui)
    KickFrame.Size = UDim2.new(1, 0, 1, 0)
    KickFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    
    local KickMessage = Instance.new("TextLabel", KickFrame)
    KickMessage.Size = UDim2.new(1, 0, 0.5, 0)
    KickMessage.Position = UDim2.new(0, 0, 0.25, 0)
    KickMessage.BackgroundTransparency = 1
    KickMessage.Text = "You have been kicked from the game"
    KickMessage.Font = FONT
    KickMessage.TextColor3 = TEXT_MAIN
    KickMessage.TextSize = 24
    
    local ReasonMessage = Instance.new("TextLabel", KickFrame)
    ReasonMessage.Size = UDim2.new(1, 0, 0.2, 0)
    ReasonMessage.Position = UDim2.new(0, 0, 0.4, 0)
    ReasonMessage.BackgroundTransparency = 1
    ReasonMessage.Text = "Reason: Trade exploit detected by Frost Shield"
    ReasonMessage.Font = FONT
    ReasonMessage.TextColor3 = TEXT_SECONDARY
    ReasonMessage.TextSize = 18
    
    local ReconnectButton = Instance.new("TextButton", KickFrame)
    ReconnectButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    ReconnectButton.Position = UDim2.new(0.35, 0, 0.65, 0)
    ReconnectButton.BackgroundColor3 = ACCENT_BLUE
    ReconnectButton.Text = "RECONNECT"
    ReconnectButton.Font = FONT
    ReconnectButton.TextColor3 = TEXT_MAIN
    ReconnectButton.TextSize = 18
    local buttonCorner = Instance.new("UICorner", ReconnectButton)
    buttonCorner.CornerRadius = UDim.new(0, 8)
    
    -- Disable other GUIs
    ScreenGui.Enabled = false
    NotificationGui.Enabled = false
    
    -- Reconnect button functionality
    ReconnectButton.MouseButton1Click:Connect(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

-- ========== Trade Protection Logic ==========
local function startTradeProtection()
    if frostShieldEnabled or acceptSentinelEnabled then
        showNotification("TRADE SCAN", "Initializing security protocols...", ACCENT_BLUE)
        
        -- Simulate scanning process
        for i = 1, 3 do
            task.wait(0.5)
            showNotification("TRADE SCAN", "Analyzing trade partner... ("..i.."/3)", ACCENT_BLUE)
        end
        
        -- Randomly detect threats
        local freezeDetected = false
        local acceptDetected = false
        local kickRisk = 0
        
        if frostShieldEnabled and math.random() > 0.7 then
            freezeDetected = true
            local severity = math.random(8, 10)/10
            kickRisk = calculateKickRisk(severity)
            showNotification("FROST SHIELD", "Freeze exploit detected! Kick risk: "..kickRisk.."%", ACCENT_RED)
        end
        
        if acceptSentinelEnabled and math.random() > 0.7 then
            acceptDetected = true
            showNotification("ACCEPT SENTINEL", "Auto-accept pattern detected!", ACCENT_RED)
        end
        
        if freezeDetected and math.random() < (kickRisk/100) then
            -- Simulate being kicked
            task.wait(1)
            showNotification("TRADE FAILED", "You were kicked by the exploiter!", ACCENT_RED)
            task.wait(1.5)
            simulateKick()
            return
        end
        
        if not freezeDetected and not acceptDetected then
            showNotification("TRADE SECURE", "No threats detected", ACCENT_GREEN)
        else
            showNotification("GUARDIAN ACTIVE", "Trade secured", ACCENT_YELLOW)
        end
        
        -- Simulate trade completion
        task.wait(3)
        showNotification("TRADE COMPLETE", "Items successfully exchanged", ACCENT_GREEN)
    else
        -- Calculate random kick risk when protection is off
        local risk = calculateKickRisk(math.random(6, 10)/10)
        showNotification("TRADE WARNING", "Guardian inactive - Kick risk: "..risk.."%", ACCENT_RED)
        
        -- Simulate being kicked with risk probability
        if math.random() < (risk/100) then
            task.wait(1)
            showNotification("TRADE FAILED", "You were kicked by the exploiter!", ACCENT_RED)
            task.wait(1.5)
            simulateKick()
            return
        end
        
        -- Simulate trade completion
        task.wait(3)
        showNotification("TRADE COMPLETE", "Items successfully exchanged", ACCENT_GREEN)
    end
end

-- ========== Trading Ticket Usage Detection ==========
local function detectTradingTicketUsage()
    local backpack = LocalPlayer:WaitForChild("Backpack")
    local lastTicketCount = 0

    local function trackTicketUsage()
        local tickets = {}
        
        -- Find all Trading Tickets in backpack
        for _, item in ipairs(backpack:GetChildren()) do
            if item.Name == "Trading Ticket" then
                table.insert(tickets, item)
            end
        end
        
        local currentCount = #tickets
        
        -- Detect when a ticket is removed (used)
        if currentCount < lastTicketCount then
            local ticketsUsed = lastTicketCount - currentCount
            showNotification("TICKET USED", ticketsUsed.." trading ticket(s) consumed", ACCENT_YELLOW)
            
            -- Trigger trade protection
            startTradeProtection()
        end
        
        lastTicketCount = currentCount
    end

    -- Initial count
    trackTicketUsage()
    
    -- Monitor inventory changes
    backpack.ChildAdded:Connect(trackTicketUsage)
    backpack.ChildRemoved:Connect(trackTicketUsage)
end

-- ========== Guardian Events ==========
local function simulateGuardianEvents()
    while true do
        if frostShieldEnabled or acceptSentinelEnabled then
            -- Randomly show protection events
            if math.random() < 0.3 then  -- 30% chance per interval
                local eventType = math.random(1, 5)
                local eventText = ""
                local eventColor = ACCENT_BLUE
                
                if eventType == 1 then
                    eventText = "Trade request verified"
                elseif eventType == 2 then
                    eventText = "Scanning trade items"
                    eventColor = ACCENT_GREEN
                elseif eventType == 3 then
                    eventText = "Exploit neutralized"
                    eventColor = ACCENT_RED
                elseif eventType == 4 then
                    eventText = "Monitoring trade activity"
                    eventColor = ACCENT_YELLOW
                else
                    -- Simulate kick risk assessment
                    local risk = calculateKickRisk(math.random(3, 7)/10)
                    eventText = "Kick risk assessment: "..risk.."%"
                    eventColor = Color3.fromRGB(220, 120, 50) -- Orange
                end
                
                showNotification("GUARDIAN ACTIVE", eventText, eventColor)
            end
        end
        task.wait(math.random(3, 8))  -- Random interval between events
    end
end

-- ========== GUI Interactions ==========
-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    NotificationGui:Destroy()
end)

-- Frost Shield toggle
FrostToggleButton.MouseButton1Click:Connect(function()
    if not frostShieldEnabled then
        startFrostShield()
    else
        frostShieldEnabled = false
        toggleSwitch(FrostToggleButton, FrostToggleButton.Parent, false)
        showNotification("FROST SHIELD", "Shield disabled", TEXT_SECONDARY)
        updateStatusLabels()
        updateLiveStatus()
    end
end)

-- Accept Sentinel toggle
AcceptToggleButton.MouseButton1Click:Connect(function()
    if not acceptSentinelEnabled then
        startAcceptSentinel()
    else
        acceptSentinelEnabled = false
        toggleSwitch(AcceptToggleButton, AcceptToggleButton.Parent, false)
        showNotification("ACCEPT SENTINEL", "Sentinel disabled", TEXT_SECONDARY)
        updateStatusLabels()
        updateLiveStatus()
    end
end)

-- Settings buttons
FrostSettings.MouseButton1Click:Connect(function()
    ModalFrame.Visible = true
    ModalTitle.Text = "FROST SHIELD DURATION"
    ModalTitle.BackgroundColor3 = ACCENT_BLUE
    currentSetting = "FrostShield"
    DurationInput.Text = tostring(frostShieldDuration)
end)

AcceptSettings.MouseButton1Click:Connect(function()
    ModalFrame.Visible = true
    ModalTitle.Text = "ACCEPT SENTINEL DURATION"
    ModalTitle.BackgroundColor3 = ACCENT_GREEN
    currentSetting = "AcceptSentinel"
    DurationInput.Text = tostring(acceptSentinelDuration)
end)

-- Modal buttons
ConfirmButton.MouseButton1Click:Connect(function()
    local duration = tonumber(DurationInput.Text)
    if duration and duration > 0 then
        if currentSetting == "FrostShield" then
            frostShieldDuration = duration
            showNotification("FROST SHIELD", "Duration: "..duration.."s", ACCENT_BLUE)
        elseif currentSetting == "AcceptSentinel" then
            acceptSentinelDuration = duration
            showNotification("ACCEPT SENTINEL", "Duration: "..duration.."s", ACCENT_GREEN)
        end
        updateStatusLabels()
    else
        showNotification("ERROR", "Invalid duration", ACCENT_RED)
    end
    ModalFrame.Visible = false
end)

CancelButton.MouseButton1Click:Connect(function()
    ModalFrame.Visible = false
end)

-- Initial update
updateStatusLabels()
updateLiveStatus()

-- Initial welcome notification
task.delay(1, function()
    showNotification(
        "TRADE GUARDIAN",
        "Activate shields to protect against trade exploits",
        ACCENT_BLUE
    )
end)

-- Simulate trade detection
local function simulateTradeDetection()
    while true do
        if frostShieldEnabled then
            if math.random(1, 100) > 90 then
                -- Add kick risk to blocked attempts
                local risk = calculateKickRisk(math.random(8, 10)/10)
                showNotification("FROST SHIELD", "Blocked freeze attempt! Kick risk: "..risk.."%", ACCENT_BLUE)
            end
        end
        
        if acceptSentinelEnabled then
            if math.random(1, 100) > 90 then
                showNotification("ACCEPT SENTINEL", "Blocked forced trade", ACCENT_GREEN)
            end
        end
        
        task.wait(5)
    end
end

-- Start simulation tasks
task.spawn(simulateTradeDetection)
task.spawn(simulateGuardianEvents)
task.spawn(detectTradingTicketUsage)

-- Update status labels periodically
RunService.Heartbeat:Connect(function()
    updateStatusLabels()
end)
