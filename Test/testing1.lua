-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui.Name == "TradeGuardGui" then
        gui:Destroy()
    end
end

-- ========== THEME COLORS ==========
local DARK_BG = Color3.fromRGB(15, 15, 20)
local CARD_BG = Color3.fromRGB(25, 25, 35)
local ACCENT_BLUE = Color3.fromRGB(0, 170, 255)
local ACCENT_RED = Color3.fromRGB(255, 50, 100)
local ACCENT_GREEN = Color3.fromRGB(50, 255, 150)
local TEXT_MAIN = Color3.fromRGB(240, 240, 255)
local FONT = Enum.Font.GothamBold

-- ========== CREATE MODERN GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 100)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -50)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BackgroundTransparency = 0.15
MainFrame.Active = true
MainFrame.Draggable = true

-- Modern UI elements
local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

local glow = Instance.new("UIStroke", MainFrame)
glow.Color = Color3.fromRGB(50, 100, 150)
glow.Thickness = 1
glow.Transparency = 0.7

local topBar = Instance.new("Frame", MainFrame)
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 25)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
topBar.BackgroundTransparency = 0.1
local topCorner = Instance.new("UICorner", topBar)
topCorner.CornerRadius = UDim.new(0, 12)
topCorner:ApplyCorner(Enum.Corner.TopLeft)
topCorner:ApplyCorner(Enum.Corner.TopRight)

local title = Instance.new("TextLabel", topBar)
title.Name = "Title"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "TRADE GUARD"
title.Font = FONT
title.TextColor3 = TEXT_MAIN
title.TextSize = 14
title.TextTransparency = 0.1

-- Status indicators
local statusContainer = Instance.new("Frame", MainFrame)
statusContainer.Name = "StatusContainer"
statusContainer.Size = UDim2.new(1, -10, 0, 60)
statusContainer.Position = UDim2.new(0, 5, 0, 30)
statusContainer.BackgroundTransparency = 1

local tradeRequestStatus = Instance.new("TextLabel", statusContainer)
tradeRequestStatus.Name = "TradeRequestStatus"
tradeRequestStatus.Size = UDim2.new(1, 0, 0, 20)
tradeRequestStatus.Position = UDim2.new(0, 0, 0, 0)
tradeRequestStatus.BackgroundTransparency = 1
tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
tradeRequestStatus.Font = FONT
tradeRequestStatus.TextColor3 = ACCENT_RED
tradeRequestStatus.TextSize = 12
tradeRequestStatus.TextXAlignment = Enum.TextXAlignment.Left

local confirmationStatus = Instance.new("TextLabel", statusContainer)
confirmationStatus.Name = "ConfirmationStatus"
confirmationStatus.Size = UDim2.new(1, 0, 0, 20)
confirmationStatus.Position = UDim2.new(0, 0, 0, 20)
confirmationStatus.BackgroundTransparency = 1
confirmationStatus.Text = "Transaction: PENDING"
confirmationStatus.Font = FONT
confirmationStatus.TextColor3 = ACCENT_BLUE
confirmationStatus.TextSize = 12
confirmationStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Status indicator lights
local tradeIndicator = Instance.new("Frame", tradeRequestStatus)
tradeIndicator.Name = "Indicator"
tradeIndicator.Size = UDim2.new(0, 8, 0, 8)
tradeIndicator.Position = UDim2.new(1, -10, 0.5, -4)
tradeIndicator.BackgroundColor3 = ACCENT_RED
tradeIndicator.BackgroundTransparency = 0.2
local tradeIndicatorCorner = Instance.new("UICorner", tradeIndicator)
tradeIndicatorCorner.CornerRadius = UDim.new(1, 0)

local confirmIndicator = Instance.new("Frame", confirmationStatus)
confirmIndicator.Name = "Indicator"
confirmIndicator.Size = UDim2.new(0, 8, 0, 8)
confirmIndicator.Position = UDim2.new(1, -10, 0.5, -4)
confirmIndicator.BackgroundColor3 = ACCENT_BLUE
confirmIndicator.BackgroundTransparency = 0.2
local confirmIndicatorCorner = Instance.new("UICorner", confirmIndicator)
confirmIndicatorCorner.CornerRadius = UDim.new(1, 0)

-- Toggle container
local toggleContainer = Instance.new("Frame", MainFrame)
toggleContainer.Name = "ToggleContainer"
toggleContainer.Size = UDim2.new(1, -10, 0, 60)
toggleContainer.Position = UDim2.new(0, 5, 0, 95)
toggleContainer.BackgroundTransparency = 1
toggleContainer.Visible = false

-- Anti-Freeze Toggle
local antiFreezeFrame = Instance.new("Frame", toggleContainer)
antiFreezeFrame.Name = "AntiFreezeFrame"
antiFreezeFrame.Size = UDim2.new(0.5, -5, 1, 0)
antiFreezeFrame.Position = UDim2.new(0, 0, 0, 0)
antiFreezeFrame.BackgroundColor3 = CARD_BG
antiFreezeFrame.BackgroundTransparency = 0.2
local antiFreezeCorner = Instance.new("UICorner", antiFreezeFrame)
antiFreezeCorner.CornerRadius = UDim.new(0, 6)

local antiFreezeLabel = Instance.new("TextLabel", antiFreezeFrame)
antiFreezeLabel.Name = "AntiFreezeLabel"
antiFreezeLabel.Size = UDim2.new(1, -30, 1, 0)
antiFreezeLabel.Position = UDim2.new(0, 5, 0, 0)
antiFreezeLabel.BackgroundTransparency = 1
antiFreezeLabel.Text = "Anti-Freeze"
antiFreezeLabel.Font = FONT
antiFreezeLabel.TextColor3 = TEXT_MAIN
antiFreezeLabel.TextSize = 12
antiFreezeLabel.TextXAlignment = Enum.TextXAlignment.Left

local antiFreezeToggle = Instance.new("TextButton", antiFreezeFrame)
antiFreezeToggle.Name = "AntiFreezeToggle"
antiFreezeToggle.Size = UDim2.new(0, 20, 0, 20)
antiFreezeToggle.Position = UDim2.new(1, -25, 0.5, -10)
antiFreezeToggle.BackgroundColor3 = ACCENT_RED
antiFreezeToggle.Text = ""
local antiFreezeToggleCorner = Instance.new("UICorner", antiFreezeToggle)
antiFreezeToggleCorner.CornerRadius = UDim.new(1, 0)
local antiFreezeToggleStroke = Instance.new("UIStroke", antiFreezeToggle)
antiFreezeToggleStroke.Color = Color3.fromRGB(100, 100, 120)
antiFreezeToggleStroke.Thickness = 1

-- Anti-AutoAccept Toggle
local antiAutoAcceptFrame = Instance.new("Frame", toggleContainer)
antiAutoAcceptFrame.Name = "AntiAutoAcceptFrame"
antiAutoAcceptFrame.Size = UDim2.new(0.5, -5, 1, 0)
antiAutoAcceptFrame.Position = UDim2.new(0.5, 5, 0, 0)
antiAutoAcceptFrame.BackgroundColor3 = CARD_BG
antiAutoAcceptFrame.BackgroundTransparency = 0.2
local antiAutoAcceptCorner = Instance.new("UICorner", antiAutoAcceptFrame)
antiAutoAcceptCorner.CornerRadius = UDim.new(0, 6)

local antiAutoAcceptLabel = Instance.new("TextLabel", antiAutoAcceptFrame)
antiAutoAcceptLabel.Name = "AntiAutoAcceptLabel"
antiAutoAcceptLabel.Size = UDim2.new(1, -30, 1, 0)
antiAutoAcceptLabel.Position = UDim2.new(0, 5, 0, 0)
antiAutoAcceptLabel.BackgroundTransparency = 1
antiAutoAcceptLabel.Text = "Anti-AutoAccept"
antiAutoAcceptLabel.Font = FONT
antiAutoAcceptLabel.TextColor3 = TEXT_MAIN
antiAutoAcceptLabel.TextSize = 12
antiAutoAcceptLabel.TextXAlignment = Enum.TextXAlignment.Left

local antiAutoAcceptToggle = Instance.new("TextButton", antiAutoAcceptFrame)
antiAutoAcceptToggle.Name = "AntiAutoAcceptToggle"
antiAutoAcceptToggle.Size = UDim2.new(0, 20, 0, 20)
antiAutoAcceptToggle.Position = UDim2.new(1, -25, 0.5, -10)
antiAutoAcceptToggle.BackgroundColor3 = ACCENT_RED
antiAutoAcceptToggle.Text = ""
local antiAutoAcceptToggleCorner = Instance.new("UICorner", antiAutoAcceptToggle)
antiAutoAcceptToggleCorner.CornerRadius = UDim.new(1, 0)
local antiAutoAcceptToggleStroke = Instance.new("UIStroke", antiAutoAcceptToggle)
antiAutoAcceptToggleStroke.Color = Color3.fromRGB(100, 100, 120)
antiAutoAcceptToggleStroke.Thickness = 1

-- Toggle Logic
local antiFreezeEnabled = false
local antiAutoAcceptEnabled = false

-- Pulse animation function
local function pulseElement(element, endColor)
    local startSize = element.Size
    local startColor = element.BackgroundColor3
    local startTrans = element.BackgroundTransparency
    
    local tweenIn = TweenService:Create(element, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {
        Size = startSize + UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 0,
        BackgroundColor3 = endColor
    })
    
    local tweenOut = TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = startSize,
        BackgroundTransparency = startTrans,
        BackgroundColor3 = startColor
    })
    
    tweenIn:Play()
    tweenIn.Completed:Wait()
    tweenOut:Play()
end

antiFreezeToggle.MouseButton1Click:Connect(function()
    antiFreezeEnabled = not antiFreezeEnabled
    if antiFreezeEnabled then
        pulseElement(antiFreezeToggle, ACCENT_GREEN)
        antiFreezeToggle.BackgroundColor3 = ACCENT_GREEN
    else
        pulseElement(antiFreezeToggle, ACCENT_RED)
        antiFreezeToggle.BackgroundColor3 = ACCENT_RED
    end
end)

antiAutoAcceptToggle.MouseButton1Click:Connect(function()
    antiAutoAcceptEnabled = not antiAutoAcceptEnabled
    if antiAutoAcceptEnabled then
        pulseElement(antiAutoAcceptToggle, ACCENT_GREEN)
        antiAutoAcceptToggle.BackgroundColor3 = ACCENT_GREEN
    else
        pulseElement(antiAutoAcceptToggle, ACCENT_RED)
        antiAutoAcceptToggle.BackgroundColor3 = ACCENT_RED
    end
end)

-- ========== DETECTION LOGIC ==========
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Trade detection
    if (tostring(self) == "SendRequest" or tostring(self) == "RespondRequest") and method == "FireServer" then
        tradeRequestStatus.Text = "Trade Request: DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_GREEN
        tradeIndicator.BackgroundColor3 = ACCENT_GREEN
        pulseElement(tradeIndicator, ACCENT_GREEN)
        
        -- Expand GUI and show toggles
        MainFrame.Size = UDim2.new(0, 260, 0, 160)
        toggleContainer.Visible = true
    end

    -- Decline handling
    if tostring(self) == "Decline" and method == "FireServer" then
        tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_RED
        tradeIndicator.BackgroundColor3 = ACCENT_RED
        pulseElement(tradeIndicator, ACCENT_RED)
        
        confirmationStatus.Text = "Transaction: PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
        confirmIndicator.BackgroundColor3 = ACCENT_BLUE
        
        -- Collapse GUI and hide toggles
        MainFrame.Size = UDim2.new(0, 260, 0, 100)
        toggleContainer.Visible = false
    end

    -- Accept handling
    if tostring(self) == "Accept" and method == "FireServer" then
        confirmationStatus.Text = "Transaction: ACCEPTED"
        confirmationStatus.TextColor3 = ACCENT_GREEN
        confirmIndicator.BackgroundColor3 = ACCENT_GREEN
        pulseElement(confirmIndicator, ACCENT_GREEN)
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
