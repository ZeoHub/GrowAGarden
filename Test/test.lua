local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Constants for colors
local ACCENT_GREEN = Color3.fromRGB(0, 170, 0)
local ACCENT_RED = Color3.fromRGB(170, 0, 0)
local ACCENT_BLUE = Color3.fromRGB(0, 100, 255)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyUI"
screenGui.Parent = playerGui

local bgImage = Instance.new("ImageLabel")
bgImage.Name = "Background"
bgImage.Parent = screenGui
bgImage.Size = UDim2.new(0, 250, 0, 250)
bgImage.Position = UDim2.new(0.5, -125, 0.5, -125)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://119759831021473"

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = bgImage

local header = Instance.new("TextLabel")
header.Name = "Header"
header.Parent = bgImage
header.Size = UDim2.new(1, 0, 0, 30)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundTransparency = 1
header.Text = "BLOXIFIED"
header.TextColor3 = Color3.fromRGB(210, 180, 140)
header.Font = Enum.Font.GothamBold
header.TextScaled = true
header.TextStrokeTransparency = 0.5
header.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Status labels positioned above the toggles
local tradeRequestStatus = Instance.new("TextLabel")
tradeRequestStatus.Name = "TradeRequestStatus"
tradeRequestStatus.Parent = bgImage
tradeRequestStatus.Size = UDim2.new(0.9, 0, 0, 20)
tradeRequestStatus.Position = UDim2.new(0.05, 0, 0, 35)  -- Below header
tradeRequestStatus.BackgroundTransparency = 1
tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
tradeRequestStatus.TextColor3 = ACCENT_RED
tradeRequestStatus.Font = Enum.Font.Gotham
tradeRequestStatus.TextSize = 14
tradeRequestStatus.TextXAlignment = Enum.TextXAlignment.Left

local confirmationStatus = Instance.new("TextLabel")
confirmationStatus.Name = "ConfirmationStatus"
confirmationStatus.Parent = bgImage
confirmationStatus.Size = UDim2.new(0.9, 0, 0, 20)
confirmationStatus.Position = UDim2.new(0.05, 0, 0, 55)  -- Below trade status
confirmationStatus.BackgroundTransparency = 1
confirmationStatus.Text = "Transaction: PENDING"
confirmationStatus.TextColor3 = ACCENT_BLUE
confirmationStatus.Font = Enum.Font.Gotham
confirmationStatus.TextSize = 14
confirmationStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Create toggles below the status indicators
local function createToggle(name, text, yOffset)
    local label = Instance.new("TextLabel")
    label.Name = name .. "Label"
    label.Parent = bgImage
    label.Size = UDim2.new(0.6, 1, 0, 35)
    label.Position = UDim2.new(0.08, 0, 0, yOffset)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(210, 180, 140)
    label.Font = Enum.Font.GothamBlack
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    local toggleTrack = Instance.new("Frame")
    toggleTrack.Name = name .. "Track"
    toggleTrack.Parent = bgImage
    toggleTrack.Size = UDim2.new(0, 50, 0, 25)
    toggleTrack.Position = UDim2.new(0.72, 0, 0, yOffset + 3)
    toggleTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleTrack.BorderSizePixel = 0
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = toggleTrack

    local toggleThumb = Instance.new("Frame")
    toggleThumb.Name = name .. "Thumb"
    toggleThumb.Parent = toggleTrack
    toggleThumb.Size = UDim2.new(0, 22, 0, 22)
    toggleThumb.Position = UDim2.new(0, 2, 0, 1.5)
    toggleThumb.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
    toggleThumb.BorderSizePixel = 0
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = toggleThumb

    local state = false
    local function toggle()
        state = not state
        local goalPos = state and UDim2.new(0, 26, 0, 1.5) or UDim2.new(0, 2, 0, 1.5)
        local goalColor = state and ACCENT_GREEN or Color3.fromRGB(60, 60, 60)
        TweenService:Create(toggleThumb, TweenInfo.new(0.2), { Position = goalPos }):Play()
        TweenService:Create(toggleTrack, TweenInfo.new(0.2), { BackgroundColor3 = goalColor }):Play()
        print(name .. " is", state and "ON" or "OFF")
        return state
    end

    toggleTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle()
        end
    end)
    
    return {toggle = toggle, state = function() return state end}
end

-- Create toggles below status indicators (yOffset 75 and 115)
local freezeToggle = createToggle("FreezeTrade", "FREEZE TRADE", 75)
local autoAcceptToggle = createToggle("LockInventory", "AUTO ACCEPT", 115)

-- Toggle states
local antiFreezeEnabled = false
local antiAutoAcceptEnabled = false

-- Toggle logic with visual feedback
freezeToggle.toggle()
freezeToggle.toggle()  -- Reset to initial state

freezeToggle.toggle = function()
    antiFreezeEnabled = not antiFreezeEnabled
    freezeToggle.state = antiFreezeEnabled
    local goalPos = antiFreezeEnabled and UDim2.new(0, 26, 0, 1.5) or UDim2.new(0, 2, 0, 1.5)
    local goalColor = antiFreezeEnabled and ACCENT_GREEN or Color3.fromRGB(60, 60, 60)
    TweenService:Create(freezeToggle.Thumb, TweenInfo.new(0.2), { Position = goalPos }):Play()
    TweenService:Create(freezeToggle.Track, TweenInfo.new(0.2), { BackgroundColor3 = goalColor }):Play()
    return antiFreezeEnabled
end

autoAcceptToggle.toggle()
autoAcceptToggle.toggle()  -- Reset to initial state

autoAcceptToggle.toggle = function()
    antiAutoAcceptEnabled = not antiAutoAcceptEnabled
    autoAcceptToggle.state = antiAutoAcceptEnabled
    local goalPos = antiAutoAcceptEnabled and UDim2.new(0, 26, 0, 1.5) or UDim2.new(0, 2, 0, 1.5)
    local goalColor = antiAutoAcceptEnabled and ACCENT_GREEN or Color3.fromRGB(60, 60, 60)
    TweenService:Create(autoAcceptToggle.Thumb, TweenInfo.new(0.2), { Position = goalPos }):Play()
    TweenService:Create(autoAcceptToggle.Track, TweenInfo.new(0.2), { BackgroundColor3 = goalColor }):Play()
    return antiAutoAcceptEnabled
end

-- Help button positioned below toggles
local helpButton = Instance.new("TextButton")
helpButton.Name = "HelpButton"
helpButton.Parent = bgImage
helpButton.Size = UDim2.new(0, 25, 0, 25)
helpButton.Position = UDim2.new(0.87, 0, 0, 210)  -- Bottom right
helpButton.Text = "?"
helpButton.Font = Enum.Font.GothamBold
helpButton.TextScaled = true
helpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
helpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local helpCorner = Instance.new("UICorner")
helpCorner.CornerRadius = UDim.new(1, 0)
helpCorner.Parent = helpButton

local instructionFrame = Instance.new("ImageLabel")
instructionFrame.Name = "InstructionFrame"
instructionFrame.Parent = bgImage
instructionFrame.Size = UDim2.new(0, 200, 0, 130)
instructionFrame.Position = UDim2.new(0.5, 110, 0.5, -40)
instructionFrame.Image = "rbxassetid://119759831021473"
instructionFrame.BackgroundTransparency = 1
instructionFrame.Visible = false

local instructionCorner = Instance.new("UICorner")
instructionCorner.CornerRadius = UDim.new(0, 12)
instructionCorner.Parent = instructionFrame

local instructionsHeader = Instance.new("TextLabel")
instructionsHeader.Name = "InstructionsHeader"
instructionsHeader.Parent = instructionFrame
instructionsHeader.Size = UDim2.new(1, 0, 0, 25)
instructionsHeader.Position = UDim2.new(0, 0, 0, 0)
instructionsHeader.BackgroundTransparency = 1
instructionsHeader.Text = "INSTRUCTIONS"
instructionsHeader.TextColor3 = Color3.fromRGB(210, 180, 140)
instructionsHeader.Font = Enum.Font.GothamBold
instructionsHeader.TextScaled = true
instructionsHeader.TextStrokeTransparency = 0.5
instructionsHeader.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local instructionText = Instance.new("TextLabel")
instructionText.Name = "InstructionText"
instructionText.Parent = instructionFrame
instructionText.Size = UDim2.new(1, -10, 1, -40)
instructionText.Position = UDim2.new(0, 6, 0, 40)
instructionText.BackgroundTransparency = 1
instructionText.Text = "- FREEZE TRADE: Freezes the victim's screen\n- AUTO ACCEPT: Automatically accepts trades\n- Status indicators show trade activity\n- Press '?' again to hide instructions"
instructionText.TextColor3 = Color3.fromRGB(210, 180, 140)
instructionText.Font = Enum.Font.Gotham
instructionText.TextWrapped = true
instructionText.TextScaled = true
instructionText.TextYAlignment = Enum.TextYAlignment.Top
instructionText.TextColor3 = Color3.fromRGB(255, 255, 255)
instructionText.TextStrokeTransparency = 0.2
instructionText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local helpVisible = false
helpButton.MouseButton1Click:Connect(function()
    helpVisible = not helpVisible
    instructionFrame.Visible = helpVisible
end)

-- Dragging functionality
local dragging = false
local dragInput, mousePos, framePos

bgImage.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = bgImage.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - mousePos
        bgImage.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Detection Logic
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Trade request detection
    if (tostring(self) == "SendRequest" or tostring(self) == "RespondRequest") and method == "FireServer" then
        tradeRequestStatus.Text = "Trade Request: DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_GREEN
    end

    -- Trade decline detection
    if tostring(self) == "Decline" and method == "FireServer" then
        tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_RED
        confirmationStatus.Text = "Transaction: PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
    end

    -- Trade acceptance detection
    if tostring(self) == "Accept" and method == "FireServer" then
        confirmationStatus.Text = "Transaction: ACCEPTED"
        confirmationStatus.TextColor3 = ACCENT_GREEN
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
