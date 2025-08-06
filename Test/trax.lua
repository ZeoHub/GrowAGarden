-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui.Name == "TradeGuardGui" or gui.Name == "NotificationGui" then
        gui:Destroy()
    end
end

-- ========== Theme Settings ==========
local DARK_BG = Color3.fromRGB(30, 30, 40)
local CARD_BG = Color3.fromRGB(45, 45, 60)
local ACCENT_BLUE = Color3.fromRGB(70, 130, 200)
local ACCENT_GREEN = Color3.fromRGB(80, 200, 120)
local ACCENT_RED = Color3.fromRGB(220, 80, 80)
local ACCENT_YELLOW = Color3.fromRGB(220, 180, 0)
local TEXT_MAIN = Color3.fromRGB(240, 240, 240)
local TEXT_SECONDARY = Color3.fromRGB(180, 180, 200)
local TOGGLE_ON = ACCENT_BLUE
local TOGGLE_OFF = Color3.fromRGB(100, 100, 120)
local FONT = Enum.Font.Gotham
local SHADOW_COLOR = Color3.fromRGB(20, 20, 30)

-- ========== Create Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"
ScreenGui.DisplayOrder = 10
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Compact main frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 140)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.Active = true
MainFrame.Draggable = true
local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 8)
local mainShadow = Instance.new("ImageLabel", MainFrame)
mainShadow.Name = "Shadow"
mainShadow.Size = UDim2.new(1, 10, 1, 10)
mainShadow.Position = UDim2.new(0, -5, 0, -5)
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://1316045217"
mainShadow.ImageColor3 = SHADOW_COLOR
mainShadow.ImageTransparency = 0.2
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
mainShadow.ZIndex = -1

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.BackgroundColor3 = CARD_BG
local titleBarCorner = Instance.new("UICorner", TitleBar)
titleBarCorner.CornerRadius = UDim.new(0, 8, 0, 0)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TRADE GUARDIAN"
TitleText.Font = FONT
TitleText.TextColor3 = TEXT_MAIN
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -28, 0.5, -12)
CloseButton.BackgroundColor3 = ACCENT_RED
CloseButton.Text = "×"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = TEXT_MAIN
CloseButton.TextSize = 18
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(1, 0)

-- ========== Protection Boxes ==========
-- Frost Shield Box
local FrostShieldBox = Instance.new("Frame", MainFrame)
FrostShieldBox.Name = "FrostShieldBox"
FrostShieldBox.Size = UDim2.new(0.45, -10, 0, 70)
FrostShieldBox.Position = UDim2.new(0, 10, 0, 35)
FrostShieldBox.BackgroundColor3 = CARD_BG
local boxCorner = Instance.new("UICorner", FrostShieldBox)
boxCorner.CornerRadius = UDim.new(0, 6)

-- Box header
local FrostIcon = Instance.new("ImageLabel", FrostShieldBox)
FrostIcon.Size = UDim2.new(0, 24, 0, 24)
FrostIcon.Position = UDim2.new(0.5, -12, 0, 8)
FrostIcon.BackgroundTransparency = 1
FrostIcon.Image = "rbxassetid://3926305904" -- Snowflake icon
FrostIcon.ImageColor3 = TEXT_MAIN

-- Toggle switch
local FrostToggle = Instance.new("Frame", FrostShieldBox)
FrostToggle.Name = "Toggle"
FrostToggle.Size = UDim2.new(0, 40, 0, 20)
FrostToggle.Position = UDim2.new(0.5, -20, 1, -28)
FrostToggle.BackgroundColor3 = TOGGLE_OFF
local toggleCorner = Instance.new("UICorner", FrostToggle)
toggleCorner.CornerRadius = UDim.new(1, 0)

local FrostToggleButton = Instance.new("TextButton", FrostToggle)
FrostToggleButton.Name = "Button"
FrostToggleButton.Size = UDim2.new(0, 16, 0, 16)
FrostToggleButton.Position = UDim2.new(0, 2, 0.5, -8)
FrostToggleButton.BackgroundColor3 = TEXT_MAIN
FrostToggleButton.Text = ""
local buttonCorner = Instance.new("UICorner", FrostToggleButton)
buttonCorner.CornerRadius = UDim.new(1, 0)

-- Settings button
local FrostSettings = Instance.new("TextButton", FrostShieldBox)
FrostSettings.Name = "SettingsButton"
FrostSettings.Size = UDim2.new(0, 24, 0, 24)
FrostSettings.Position = UDim2.new(1, -28, 0, 8)
FrostSettings.BackgroundTransparency = 1
FrostSettings.Text = "⚙️"
FrostSettings.Font = Enum.Font.Gotham
FrostSettings.TextSize = 14
FrostSettings.TextColor3 = TEXT_MAIN

-- Status label
local FrostStatus = Instance.new("TextLabel", FrostShieldBox)
FrostStatus.Size = UDim2.new(1, -10, 0, 16)
FrostStatus.Position = UDim2.new(0, 5, 1, -40)
FrostStatus.BackgroundTransparency = 1
FrostStatus.Text = "INACTIVE"
FrostStatus.Font = FONT
FrostStatus.TextColor3 = TEXT_SECONDARY
FrostStatus.TextSize = 12
FrostStatus.TextXAlignment = Enum.TextXAlignment.Center

-- Accept Sentinel Box
local AcceptSentinelBox = Instance.new("Frame", MainFrame)
AcceptSentinelBox.Name = "AcceptSentinelBox"
AcceptSentinelBox.Size = UDim2.new(0.45, -10, 0, 70)
AcceptSentinelBox.Position = UDim2.new(1, -120, 0, 35)
AcceptSentinelBox.BackgroundColor3 = CARD_BG
local boxCorner2 = Instance.new("UICorner", AcceptSentinelBox)
boxCorner2.CornerRadius = UDim.new(0, 6)

-- Box header
local AcceptIcon = Instance.new("ImageLabel", AcceptSentinelBox)
AcceptIcon.Size = UDim2.new(0, 24, 0, 24)
AcceptIcon.Position = UDim2.new(0.5, -12, 0, 8)
AcceptIcon.BackgroundTransparency = 1
AcceptIcon.Image = "rbxassetid://3926307971" -- Checkmark icon
AcceptIcon.ImageColor3 = TEXT_MAIN

-- Toggle switch
local AcceptToggle = Instance.new("Frame", AcceptSentinelBox)
AcceptToggle.Name = "Toggle"
AcceptToggle.Size = UDim2.new(0, 40, 0, 20)
AcceptToggle.Position = UDim2.new(0.5, -20, 1, -28)
AcceptToggle.BackgroundColor3 = TOGGLE_OFF
local toggleCorner2 = Instance.new("UICorner", AcceptToggle)
toggleCorner2.CornerRadius = UDim.new(1, 0)

local AcceptToggleButton = Instance.new("TextButton", AcceptToggle)
AcceptToggleButton.Name = "Button"
AcceptToggleButton.Size = UDim2.new(0, 16, 0, 16)
AcceptToggleButton.Position = UDim2.new(0, 2, 0.5, -8)
AcceptToggleButton.BackgroundColor3 = TEXT_MAIN
AcceptToggleButton.Text = ""
local buttonCorner2 = Instance.new("UICorner", AcceptToggleButton)
buttonCorner2.CornerRadius = UDim.new(1, 0)

-- Settings button
local AcceptSettings = Instance.new("TextButton", AcceptSentinelBox)
AcceptSettings.Name = "SettingsButton"
AcceptSettings.Size = UDim2.new(0, 24, 0, 24)
AcceptSettings.Position = UDim2.new(1, -28, 0, 8)
AcceptSettings.BackgroundTransparency = 1
AcceptSettings.Text = "⚙️"
AcceptSettings.Font = Enum.Font.Gotham
AcceptSettings.TextSize = 14
AcceptSettings.TextColor3 = TEXT_MAIN

-- Status label
local AcceptStatus = Instance.new("TextLabel", AcceptSentinelBox)
AcceptStatus.Size = UDim2.new(1, -10, 0, 16)
AcceptStatus.Position = UDim2.new(0, 5, 1, -40)
AcceptStatus.BackgroundTransparency = 1
AcceptStatus.Text = "INACTIVE"
AcceptStatus.Font = FONT
AcceptStatus.TextColor3 = TEXT_SECONDARY
AcceptStatus.TextSize = 12
AcceptStatus.TextXAlignment = Enum.TextXAlignment.Center

-- Global status
local GlobalStatus = Instance.new("TextLabel", MainFrame)
GlobalStatus.Size = UDim2.new(1, -20, 0, 18)
GlobalStatus.Position = UDim2.new(0, 10, 1, -22)
GlobalStatus.BackgroundTransparency = 1
GlobalStatus.Text = "GUARDIAN INACTIVE"
GlobalStatus.Font = FONT
GlobalStatus.TextColor3 = TEXT_SECONDARY
GlobalStatus.TextSize = 12
GlobalStatus.TextXAlignment = Enum.TextXAlignment.Center

-- ========== Settings Modal ==========
local ModalFrame = Instance.new("Frame", ScreenGui)
ModalFrame.Name = "SettingsModal"
ModalFrame.Size = UDim2.new(0, 220, 0, 160)
ModalFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
ModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ModalFrame.BackgroundColor3 = CARD_BG
ModalFrame.Visible = false
local modalCorner = Instance.new("UICorner", ModalFrame)
modalCorner.CornerRadius = UDim.new(0, 8)
local modalShadow = Instance.new("ImageLabel", ModalFrame)
modalShadow.Name = "Shadow"
modalShadow.Size = UDim2.new(1, 10, 1, 10)
modalShadow.Position = UDim2.new(0, -5, 0, -5)
modalShadow.BackgroundTransparency = 1
modalShadow.Image = "rbxassetid://1316045217"
modalShadow.ImageColor3 = SHADOW_COLOR
modalShadow.ImageTransparency = 0.2
modalShadow.ScaleType = Enum.ScaleType.Slice
modalShadow.SliceCenter = Rect.new(10, 10, 118, 118)
modalShadow.ZIndex = -1

local ModalTitle = Instance.new("TextLabel", ModalFrame)
ModalTitle.Size = UDim2.new(1, 0, 0, 32)
ModalTitle.Position = UDim2.new(0, 0, 0, 0)
ModalTitle.BackgroundColor3 = ACCENT_BLUE
ModalTitle.Text = "DURATION SETTINGS"
ModalTitle.Font = FONT
ModalTitle.TextColor3 = TEXT_MAIN
ModalTitle.TextSize = 14
local titleCorner = Instance.new("UICorner", ModalTitle)
titleCorner.CornerRadius = UDim.new(0, 8, 0, 0)

local DurationLabel = Instance.new("TextLabel", ModalFrame)
DurationLabel.Size = UDim2.new(1, -20, 0, 24)
DurationLabel.Position = UDim2.new(0, 10, 0, 40)
DurationLabel.BackgroundTransparency = 1
DurationLabel.Text = "Set duration (seconds):"
DurationLabel.Font = FONT
DurationLabel.TextColor3 = TEXT_SECONDARY
DurationLabel.TextSize = 12
DurationLabel.TextXAlignment = Enum.TextXAlignment.Left

local DurationInput = Instance.new("TextBox", ModalFrame)
DurationInput.Size = UDim2.new(1, -30, 0, 30)
DurationInput.Position = UDim2.new(0, 15, 0, 70)
DurationInput.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
DurationInput.PlaceholderText = "Enter duration"
DurationInput.Text = "300"
DurationInput.TextColor3 = TEXT_MAIN
DurationInput.TextSize = 14
DurationInput.Font = FONT
local inputCorner = Instance.new("UICorner", DurationInput)
inputCorner.CornerRadius = UDim.new(0, 6)

local ConfirmButton = Instance.new("TextButton", ModalFrame)
ConfirmButton.Size = UDim2.new(0.4, 0, 0, 28)
ConfirmButton.Position = UDim2.new(0.1, 0, 1, -34)
ConfirmButton.BackgroundColor3 = ACCENT_GREEN
ConfirmButton.Text = "CONFIRM"
ConfirmButton.Font = FONT
ConfirmButton.TextColor3 = TEXT_MAIN
ConfirmButton.TextSize = 12
local confirmCorner = Instance.new("UICorner", ConfirmButton)
confirmCorner.CornerRadius = UDim.new(0, 6)

local CancelButton = Instance.new("TextButton", ModalFrame)
CancelButton.Size = UDim2.new(0.4, 0, 0, 28)
CancelButton.Position = UDim2.new(0.55, 0, 1, -34)
CancelButton.BackgroundColor3 = ACCENT_RED
CancelButton.Text = "CANCEL"
CancelButton.Font = FONT
CancelButton.TextColor3 = TEXT_MAIN
CancelButton.TextSize = 12
local cancelCorner = Instance.new("UICorner", CancelButton)
cancelCorner.CornerRadius = UDim.new(0, 6)

-- ========== Notification System ==========
local NotificationGui = Instance.new("ScreenGui", PlayerGui)
NotificationGui.Name = "NotificationGui"
NotificationGui.DisplayOrder = 20
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationFrame = Instance.new("Frame", NotificationGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0, 240, 0, 0)
NotificationFrame.Position = UDim2.new(0.5, -120, 0.02, 0)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, color)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame", NotificationFrame)
    Container.Name = notificationId
    Container.Size = UDim2.new(1, 0, 0, 60)
    Container.BackgroundColor3 = CARD_BG
    Container.Position = UDim2.new(0, 0, 0, -60)
    local containerCorner = Instance.new("UICorner", Container)
    containerCorner.CornerRadius = UDim.new(0, 8)
    local containerShadow = Instance.new("ImageLabel", Container)
    containerShadow.Name = "Shadow"
    containerShadow.Size = UDim2.new(1, 10, 1, 10)
    containerShadow.Position = UDim2.new(0, -5, 0, -5)
    containerShadow.BackgroundTransparency = 1
    containerShadow.Image = "rbxassetid://1316045217"
    containerShadow.ImageColor3 = SHADOW_COLOR
    containerShadow.ImageTransparency = 0.2
    containerShadow.ScaleType = Enum.ScaleType.Slice
    containerShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    containerShadow.ZIndex = -1

    local TitleLabel = Instance.new("TextLabel", Container)
    TitleLabel.Size = UDim2.new(1, -20, 0.5, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = FONT
    TitleLabel.TextColor3 = TEXT_MAIN
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Size = UDim2.new(1, -20, 0.5, 0)
    MessageLabel.Position = UDim2.new(0, 10, 0.5, 0)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.Font = FONT
    MessageLabel.TextColor3 = TEXT_SECONDARY
    MessageLabel.TextSize = 12
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left

    local AccentBar = Instance.new("Frame", Container)
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.Position = UDim2.new(0, 0, 0, 0)
    AccentBar.BackgroundColor3 = color
    local barCorner = Instance.new("UICorner", AccentBar)
    barCorner.CornerRadius = UDim.new(0, 8, 0, 0)

    -- Animation
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.3), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()

    -- Remove after duration
    task.delay(3, function()
        if Container and Container.Parent then
            local slideOut = TweenService:Create(Container, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 0, 0, -60)
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
            Position = UDim2.new(0, 22, 0.5, -8),
            BackgroundColor3 = TEXT_MAIN
        }):Play()
        TweenService:Create(frame, TweenInfo.new(0.2), {
            BackgroundColor3 = TOGGLE_ON
        }):Play()
    else
        TweenService:Create(button, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 2, 0.5, -8),
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
    toggleSwitch(FrostToggleButton, FrostToggle, true)
    showNotification("FROST SHIELD", "Active for "..frostShieldDuration.."s", ACCENT_BLUE)
    
    -- Simulate protection
    while tick() < frostEndTime and frostShieldEnabled do
        updateStatusLabels()
        updateLiveStatus()
        task.wait(1)
    end
    
    if frostShieldEnabled then
        frostShieldEnabled = false
        toggleSwitch(FrostToggleButton, FrostToggle, false)
        showNotification("FROST SHIELD", "Protection expired", TEXT_SECONDARY)
    end
    updateStatusLabels()
    updateLiveStatus()
end

-- Accept Sentinel protection
local function startAcceptSentinel()
    acceptSentinelEnabled = true
    acceptEndTime = tick() + acceptSentinelDuration
    toggleSwitch(AcceptToggleButton, AcceptToggle, true)
    showNotification("ACCEPT SENTINEL", "Active for "..acceptSentinelDuration.."s", ACCENT_GREEN)
    
    -- Simulate protection
    while tick() < acceptEndTime and acceptSentinelEnabled do
        updateStatusLabels()
        updateLiveStatus()
        task.wait(1)
    end
    
    if acceptSentinelEnabled then
        acceptSentinelEnabled = false
        toggleSwitch(AcceptToggleButton, AcceptToggle, false)
        showNotification("ACCEPT SENTINEL", "Protection expired", TEXT_SECONDARY)
    end
    updateStatusLabels()
    updateLiveStatus()
end

-- ========== Guardian Status Indicator ==========
local LiveIndicator = Instance.new("Frame", MainFrame)
LiveIndicator.Name = "LiveIndicator"
LiveIndicator.Size = UDim2.new(0, 8, 0, 8)
LiveIndicator.Position = UDim2.new(1, -15, 1, -15)
LiveIndicator.BackgroundColor3 = ACCENT_RED
LiveIndicator.BorderSizePixel = 0
local indicatorCorner = Instance.new("UICorner", LiveIndicator)
indicatorCorner.CornerRadius = UDim.new(1, 0)

local LiveText = Instance.new("TextLabel", MainFrame)
LiveText.Name = "LiveText"
LiveText.Size = UDim2.new(0, 50, 0, 12)
LiveText.Position = UDim2.new(1, -60, 1, -16)
LiveText.BackgroundTransparency = 1
LiveText.Text = "OFFLINE"
LiveText.Font = FONT
LiveText.TextColor3 = TEXT_SECONDARY
LiveText.TextSize = 10
LiveText.TextXAlignment = Enum.TextXAlignment.Right

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
        toggleSwitch(FrostToggleButton, FrostToggle, false)
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
        toggleSwitch(AcceptToggleButton, AcceptToggle, false)
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
