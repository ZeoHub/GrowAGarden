-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

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
local ACCENT_PURPLE = Color3.fromRGB(150, 100, 255)
local TEXT_MAIN = Color3.fromRGB(240, 240, 255)
local FONT = Enum.Font.GothamBold
local GRADIENT_COLORS = {
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255))
}

-- ========== CREATE MAIN GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 340)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -170)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BackgroundTransparency = 0.05
MainFrame.Active = true
MainFrame.Draggable = true

-- Modern frame styling
local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(60, 60, 80)
stroke.Thickness = 2
stroke.Transparency = 0.3

local glow = Instance.new("ImageLabel", MainFrame)
glow.Name = "Glow"
glow.Size = UDim2.new(1.1, 0, 1.1, 0)
glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://8992230670"
glow.ImageColor3 = Color3.fromRGB(0, 100, 200)
glow.ImageTransparency = 0.8
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(100, 100, 100, 100)
glow.ZIndex = 0

-- Title bar with gradient
local titleBar = Instance.new("Frame", MainFrame)
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundTransparency = 0.95
titleBar.Active = true
titleBar.Draggable = true

local titleGradient = Instance.new("UIGradient", titleBar)
titleGradient.Color = ColorSequence.new(GRADIENT_COLORS)
titleGradient.Rotation = 90

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Name = "TopCorner"

local title = Instance.new("TextLabel", titleBar)
title.Name = "Title"
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TRADEGUARD"
title.Font = FONT
title.TextColor3 = TEXT_MAIN
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextTransparency = 0.1

-- Minimize button
local minimizeButton = Instance.new("ImageButton", titleBar)
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -34, 0.5, -12)
minimizeButton.AnchorPoint = Vector2.new(1, 0.5)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Image = "rbxassetid://3926305904"
minimizeButton.ImageRectOffset = Vector2.new(124, 4)
minimizeButton.ImageRectSize = Vector2.new(24, 24)
minimizeButton.ImageColor3 = TEXT_MAIN

-- Status indicators container
local statusContainer = Instance.new("Frame", MainFrame)
statusContainer.Name = "StatusContainer"
statusContainer.Size = UDim2.new(1, -20, 0, 80)
statusContainer.Position = UDim2.new(0, 10, 0, 50)
statusContainer.BackgroundTransparency = 1

-- Status cards
local function createStatusCard(name, position, defaultText)
    local card = Instance.new("Frame", statusContainer)
    card.Name = name
    card.Size = UDim2.new(0.5, -5, 1, 0)
    card.Position = position
    card.BackgroundColor3 = CARD_BG
    card.BackgroundTransparency = 0.1
    
    local cardCorner = Instance.new("UICorner", card)
    cardCorner.CornerRadius = UDim.new(0, 8)
    
    local cardStroke = Instance.new("UIStroke", card)
    cardStroke.Color = Color3.fromRGB(60, 60, 80)
    cardStroke.Thickness = 1
    
    local statusLabel = Instance.new("TextLabel", card)
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -10, 0, 20)
    statusLabel.Position = UDim2.new(0, 5, 0, 8)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = name .. ":"
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    statusLabel.TextSize = 12
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local statusValue = Instance.new("TextLabel", card)
    statusValue.Name = "StatusValue"
    statusValue.Size = UDim2.new(1, -10, 0, 24)
    statusValue.Position = UDim2.new(0, 5, 0, 30)
    statusValue.BackgroundTransparency = 1
    statusValue.Text = defaultText
    statusValue.Font = FONT
    statusValue.TextSize = 16
    statusValue.TextXAlignment = Enum.TextXAlignment.Left
    
    local icon = Instance.new("ImageLabel", card)
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(1, -29, 0.5, -12)
    icon.AnchorPoint = Vector2.new(1, 0.5)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://3926305904"
    icon.ImageRectOffset = Vector2.new(50, 700)
    icon.ImageRectSize = Vector2.new(50, 50)
    
    return statusValue, icon
end

local tradeRequestStatus, tradeIcon = createStatusCard("Trade Request", UDim2.new(0, 0, 0, 0), "NOT DETECTED")
tradeRequestStatus.TextColor3 = ACCENT_RED
tradeIcon.ImageColor3 = ACCENT_RED

local confirmationStatus, confirmIcon = createStatusCard("Transaction", UDim2.new(0.5, 5, 0, 0), "PENDING")
confirmationStatus.TextColor3 = ACCENT_BLUE
confirmIcon.ImageColor3 = ACCENT_BLUE

-- Toggles container
local togglesContainer = Instance.new("Frame", MainFrame)
togglesContainer.Name = "TogglesContainer"
togglesContainer.Size = UDim2.new(1, -20, 0, 90)
togglesContainer.Position = UDim2.new(0, 10, 0, 140)
togglesContainer.BackgroundTransparency = 1
togglesContainer.Visible = false

-- Modern toggle switch
local function createToggle(name, position, description)
    local toggleFrame = Instance.new("Frame", togglesContainer)
    toggleFrame.Name = name .. "Frame"
    toggleFrame.Size = UDim2.new(1, 0, 0, 40)
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = CARD_BG
    toggleFrame.BackgroundTransparency = 0.1
    
    local toggleCorner = Instance.new("UICorner", toggleFrame)
    toggleCorner.CornerRadius = UDim.new(0, 8)
    
    local toggleStroke = Instance.new("UIStroke", toggleFrame)
    toggleStroke.Color = Color3.fromRGB(60, 60, 80)
    toggleStroke.Thickness = 1
    
    local label = Instance.new("TextLabel", toggleFrame)
    label.Name = "Label"
    label.Size = UDim2.new(0.7, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.Font = FONT
    label.TextColor3 = TEXT_MAIN
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local descriptionLabel = Instance.new("TextLabel", toggleFrame)
    descriptionLabel.Name = "Description"
    descriptionLabel.Size = UDim2.new(0.7, -10, 0, 14)
    descriptionLabel.Position = UDim2.new(0, 10, 0, 22)
    descriptionLabel.BackgroundTransparency = 1
    descriptionLabel.Text = description
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    descriptionLabel.TextSize = 12
    descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Modern toggle switch
    local toggle = Instance.new("Frame", toggleFrame)
    toggle.Name = "Toggle"
    toggle.Size = UDim2.new(0, 50, 0, 24)
    toggle.Position = UDim2.new(1, -60, 0.5, -12)
    toggle.AnchorPoint = Vector2.new(1, 0.5)
    toggle.BackgroundColor3 = ACCENT_RED
    toggle.BorderSizePixel = 0
    
    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(0.5, 0)
    
    local toggleKnob = Instance.new("Frame", toggle)
    toggleKnob.Name = "Knob"
    toggleKnob.Size = UDim2.new(0, 20, 0, 20)
    toggleKnob.Position = UDim2.new(0, 2, 0.5, -10)
    toggleKnob.AnchorPoint = Vector2.new(0, 0.5)
    toggleKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleKnob.BorderSizePixel = 0
    
    local knobCorner = Instance.new("UICorner", toggleKnob)
    knobCorner.CornerRadius = UDim.new(0.5, 0)
    
    local knobShadow = Instance.new("ImageLabel", toggleKnob)
    knobShadow.Name = "Shadow"
    knobShadow.Size = UDim2.new(1.5, 0, 1.5, 0)
    knobShadow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    knobShadow.BackgroundTransparency = 1
    knobShadow.Image = "rbxassetid://8992230670"
    knobShadow.ImageColor3 = Color3.new(0, 0, 0)
    knobShadow.ImageTransparency = 0.8
    knobShadow.ScaleType = Enum.ScaleType.Slice
    knobShadow.SliceCenter = Rect.new(100, 100, 100, 100)
    knobShadow.ZIndex = -1
    
    return toggle, toggleKnob
end

local antiFreezeToggle, antiFreezeKnob = createToggle("Anti-Freeze", UDim2.new(0, 0, 0, 0), "Prevents trade freeze exploits")
local antiAutoAcceptToggle, antiAutoAcceptKnob = createToggle("Anti-AutoAccept", UDim2.new(0, 0, 0, 50), "Blocks forced trade acceptance")

-- ========== TOGGLE LOGIC ==========
local antiFreezeEnabled = false
local antiAutoAcceptEnabled = false

local function updateToggle(toggle, knob, enabled, color)
    toggle.BackgroundColor3 = color
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if enabled then
        TweenService:Create(knob, tweenInfo, {Position = UDim2.new(1, -22, 0.5, -10)}):Play()
    else
        TweenService:Create(knob, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
    end
end

antiFreezeToggle.MouseButton1Click:Connect(function()
    antiFreezeEnabled = not antiFreezeEnabled
    updateToggle(antiFreezeToggle, antiFreezeKnob, antiFreezeEnabled, antiFreezeEnabled and ACCENT_GREEN or ACCENT_RED)
end)

antiAutoAcceptToggle.MouseButton1Click:Connect(function()
    antiAutoAcceptEnabled = not antiAutoAcceptEnabled
    updateToggle(antiAutoAcceptToggle, antiAutoAcceptKnob, antiAutoAcceptEnabled, antiAutoAcceptEnabled and ACCENT_GREEN or ACCENT_RED)
end)

-- Minimize button functionality
minimizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size.Y.Offset == 340 then
        -- Minimize
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 40), "Out", "Quad", 0.3, true)
        minimizeButton.ImageRectOffset = Vector2.new(364, 284)
    else
        -- Maximize
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 340), "Out", "Quad", 0.3, true)
        minimizeButton.ImageRectOffset = Vector2.new(124, 4)
    end
end)

-- ========== DETECTION LOGIC ==========
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Check if the RemoteEvent is "SendRequest" or "RespondRequest" and the method is "FireServer"
    if (tostring(self) == "SendRequest" or tostring(self) == "RespondRequest") and method == "FireServer" then
        -- Update the GUI to show that a trade transaction was detected
        tradeRequestStatus.Text = "DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_GREEN
        tradeIcon.ImageColor3 = ACCENT_GREEN
        tradeIcon.ImageRectOffset = Vector2.new(150, 700)

        -- Show the toggles
        togglesContainer.Visible = true
    end

    -- Check if the RemoteEvent is "Decline" and the method is "FireServer"
    if tostring(self) == "Decline" and method == "FireServer" then
        -- Reset the trade request and hide toggles
        tradeRequestStatus.Text = "NOT DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_RED
        tradeIcon.ImageColor3 = ACCENT_RED
        tradeIcon.ImageRectOffset = Vector2.new(50, 700)
        
        confirmationStatus.Text = "PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
        confirmIcon.ImageColor3 = ACCENT_BLUE
        confirmIcon.ImageRectOffset = Vector2.new(50, 700)
        
        togglesContainer.Visible = false
    end

    -- Check if the RemoteEvent is "Accept" and the method is "FireServer"
    if tostring(self) == "Accept" and method == "FireServer" then
        -- Show confirmation in the GUI
        confirmationStatus.Text = "ACCEPTED"
        confirmationStatus.TextColor3 = ACCENT_GREEN
        confirmIcon.ImageColor3 = ACCENT_GREEN
        confirmIcon.ImageRectOffset = Vector2.new(150, 700)
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
