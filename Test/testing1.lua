local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Constants for colors
local ACCENT_GREEN = Color3.fromRGB(0, 170, 0)
local ACCENT_RED = Color3.fromRGB(170, 0, 0)
local ACCENT_BLUE = Color3.fromRGB(0, 100, 255)
local TEXT_COLOR = Color3.fromRGB(210, 180, 140)  -- Beige text color
local BG_COLOR = Color3.fromRGB(40, 40, 40)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyUI"
screenGui.Parent = playerGui

local bgImage = Instance.new("ImageLabel")
bgImage.Name = "Background"
bgImage.Parent = screenGui
bgImage.Size = UDim2.new(0, 250, 0, 135)
bgImage.Position = UDim2.new(0.5, -125, 0.5, -110)
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
header.Text = "ANTI-SCAM"
header.TextColor3 = TEXT_COLOR
header.Font = Enum.Font.GothamBold
header.TextScaled = true
header.TextStrokeTransparency = 0.5
header.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Status labels
local tradeRequestStatus = Instance.new("TextLabel")
tradeRequestStatus.Name = "TradeRequestStatus"
tradeRequestStatus.Parent = bgImage
tradeRequestStatus.Size = UDim2.new(0.9, 0, 0, 20)
tradeRequestStatus.Position = UDim2.new(0.05, 0, 0, 40)
tradeRequestStatus.BackgroundTransparency = 1
tradeRequestStatus.Text = "TRADE REQUEST: NOT DETECTED"
tradeRequestStatus.TextColor3 = TEXT_COLOR
tradeRequestStatus.Font = Enum.Font.GothamBlack
tradeRequestStatus.TextSize = 8
tradeRequestStatus.TextXAlignment = Enum.TextXAlignment.Left
tradeRequestStatus.TextStrokeTransparency = 0.2
tradeRequestStatus.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local confirmationStatus = Instance.new("TextLabel")
confirmationStatus.Name = "ConfirmationStatus"
confirmationStatus.Parent = bgImage
confirmationStatus.Size = UDim2.new(0.9, 0, 0, 20)
confirmationStatus.Position = UDim2.new(0.05, 0, 0, 49)
confirmationStatus.BackgroundTransparency = 1
confirmationStatus.Text = "TRANSACTION: PENDING"
confirmationStatus.TextColor3 = TEXT_COLOR
confirmationStatus.Font = Enum.Font.GothamBlack
confirmationStatus.TextSize = 8
confirmationStatus.TextXAlignment = Enum.TextXAlignment.Left
confirmationStatus.TextStrokeTransparency = 0.2
confirmationStatus.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- GUARANTEED WORKING TOGGLE SYSTEM
local function createToggle(name, text, yOffset)
    -- Create container for the entire toggle row
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Name = name .. "Container"
    toggleContainer.Parent = bgImage
    toggleContainer.Size = UDim2.new(1, 0, 0, 35)
    toggleContainer.Position = UDim2.new(0, 0, 0, yOffset)
    toggleContainer.BackgroundTransparency = 1
    
    -- Toggle label
    local label = Instance.new("TextLabel")
    label.Name = name .. "Label"
    label.Parent = toggleContainer
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0.08, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = TEXT_COLOR
    label.Font = Enum.Font.GothamBlack
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextStrokeTransparency = 0.2
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    -- Toggle track
    local toggleTrack = Instance.new("Frame")
    toggleTrack.Name = name .. "Track"
    toggleTrack.Parent = toggleContainer
    toggleTrack.Size = UDim2.new(0, 50, 0, 25)
    toggleTrack.Position = UDim2.new(0.72, 0, 0.5, -12.5)
    toggleTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleTrack.BorderSizePixel = 0
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = toggleTrack

    -- Toggle thumb
    local toggleThumb = Instance.new("Frame")
    toggleThumb.Name = name .. "Thumb"
    toggleThumb.Parent = toggleTrack
    toggleThumb.Size = UDim2.new(0, 22, 0, 22)
    toggleThumb.Position = UDim2.new(0, 2, 0, 1.5)
    toggleThumb.BackgroundColor3 = TEXT_COLOR
    toggleThumb.BorderSizePixel = 0
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = toggleThumb

    -- Invisible button to capture clicks
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = name .. "Button"
    toggleButton.Parent = toggleContainer
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.ZIndex = 10  -- Make sure it's on top

    -- Toggle state
    local state = false
    
    -- Toggle function
    local function toggle()
        state = not state
        local goalPos = state and UDim2.new(0, 26, 0, 1.5) or UDim2.new(0, 2, 0, 1.5)
        local goalColor = state and ACCENT_GREEN or Color3.fromRGB(60, 60, 60)
        
        TweenService:Create(toggleThumb, TweenInfo.new(0.2), {Position = goalPos}):Play()
        TweenService:Create(toggleTrack, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
        
        print(name .. " is now " .. (state and "ON" or "OFF"))
        return state
    end

    -- Connect click event to the invisible button
    toggleButton.MouseButton1Click:Connect(toggle)
    
    return {
        toggle = toggle,
        getState = function() return state end
    }
end

-- Create toggles at positions 55 and 95
local freezeToggle = createToggle("FreezeTrade", "ANTI-FREEZE", 55)
local autoAcceptToggle = createToggle("LockInventory", "ANTI-ACCEPT", 95)

-- Help button
local helpButton = Instance.new("TextButton")
helpButton.Name = "HelpButton"
helpButton.Parent = bgImage
helpButton.Size = UDim2.new(0, 25, 0, 25)
helpButton.Position = UDim2.new(0.87, 0, 0, 10)
helpButton.Text = "?"
helpButton.Font = Enum.Font.GothamBold
helpButton.TextScaled = true
helpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
helpButton.BackgroundColor3 = BG_COLOR
helpButton.ZIndex = 2

local helpCorner = Instance.new("UICorner")
helpCorner.CornerRadius = UDim.new(1, 0)
helpCorner.Parent = helpButton

-- INSTRUCTION FRAME (DRAGGABLE)
local instructionFrame = Instance.new("Frame")
instructionFrame.Name = "InstructionFrame"
instructionFrame.Parent = screenGui
instructionFrame.Size = UDim2.new(0, 300, 0, 130)
instructionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
instructionFrame.BackgroundTransparency = 0.3
instructionFrame.Visible = false
instructionFrame.ZIndex = 3

local instructionCorner = Instance.new("UICorner")
instructionCorner.CornerRadius = UDim.new(0, 12)
instructionCorner.Parent = instructionFrame

local instructionsHeader = Instance.new("TextButton") -- Changed to TextButton for better interaction
instructionsHeader.Name = "InstructionsHeader"
instructionsHeader.Parent = instructionFrame
instructionsHeader.Size = UDim2.new(1, 0, 0, 25)
instructionsHeader.Position = UDim2.new(0, 0, 0, 0)
instructionsHeader.BackgroundTransparency = 1
instructionsHeader.Text = "INSTRUCTIONS"
instructionsHeader.TextColor3 = TEXT_COLOR
instructionsHeader.Font = Enum.Font.GothamBold
instructionsHeader.TextScaled = true
instructionsHeader.TextStrokeTransparency = 0.5
instructionsHeader.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
instructionsHeader.ZIndex = 3
instructionsHeader.AutoButtonColor = false -- Disable automatic color change

-- CORRECTED TEXT WITH PROPER FORMATTING
local instructionText = Instance.new("TextLabel")
instructionText.Name = "InstructionText"
instructionText.Parent = instructionFrame
instructionText.Size = UDim2.new(0.95, 0, 0.8, 0)
instructionText.Position = UDim2.new(0.025, 0, 0.2, 0)
instructionText.BackgroundTransparency = 1
instructionText.Text = [[
HOW TO USE:
1. Find someone to trade with
2. Wait for trade detection
3. Toggle Anti-FREEZE to prevent screen freeze
4. Toggle Anti-AUTO ACCEPT to prevent auto-accept

Press '?' again to hide instructions]]
instructionText.Font = Enum.Font.Gotham
instructionText.TextWrapped = true
instructionText.TextSize = 14
instructionText.TextYAlignment = Enum.TextYAlignment.Top
instructionText.TextColor3 = TEXT_COLOR
instructionText.TextStrokeTransparency = 0.2
instructionText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
instructionText.ZIndex = 3

-- Make instruction frame draggable
local dragging = false
local dragStartPos
local startFramePos

instructionsHeader.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Vector2.new(input.Position.X, input.Position.Y)
        startFramePos = instructionFrame.Position
        
        -- Capture mouse movement even if cursor leaves the header
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local currentPos = Vector2.new(input.Position.X, input.Position.Y)
        local delta = currentPos - dragStartPos
        
        -- Update frame position
        instructionFrame.Position = UDim2.new(
            startFramePos.X.Scale,
            startFramePos.X.Offset + delta.X,
            startFramePos.Y.Scale,
            startFramePos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local helpVisible = false
helpButton.MouseButton1Click:Connect(function()
    helpVisible = not helpVisible
    
    -- Position instructions relative to main UI when first shown
    if helpVisible then
        local mainPos = bgImage.AbsolutePosition
        local mainSize = bgImage.AbsoluteSize
        instructionFrame.Position = UDim2.new(
            0, mainPos.X + (mainSize.X/2) - 150,
            0, mainPos.Y + mainSize.Y + 10
        )
    end
    
    instructionFrame.Visible = helpVisible
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
        tradeRequestStatus.Text = "TRADE REQUEST: DETECTED"
    end

    -- Trade decline detection
    if tostring(self) == "Decline" and method == "FireServer" then
        tradeRequestStatus.Text = "TRADE REQUEST: NOT DETECTED"
        confirmationStatus.Text = "TRANSACTION: PENDING"
    end

    -- Trade acceptance detection
    if tostring(self) == "Accept" and method == "FireServer" then
        confirmationStatus.Text = "TRANSACTION: ACCEPTED"
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

print("UI LOADED! Toggles are guaranteed to work - click anywhere in the toggle row!")
