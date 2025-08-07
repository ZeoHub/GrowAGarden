local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Constants for colors
local ACCENT_GREEN = Color3.fromRGB(0, 170, 0)
local ACCENT_RED = Color3.fromRGB(170, 0, 0)
local ACCENT_BLUE = Color3.fromRGB(0, 100, 255)
local TEXT_COLOR = Color3.fromRGB(210, 180, 140)  -- Beige text color

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
header.TextColor3 = TEXT_COLOR
header.Font = Enum.Font.GothamBold
header.TextScaled = true
header.TextStrokeTransparency = 0.5
header.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Status labels with proper font styling
local tradeRequestStatus = Instance.new("TextLabel")
tradeRequestStatus.Name = "TradeRequestStatus"
tradeRequestStatus.Parent = bgImage
tradeRequestStatus.Size = UDim2.new(0.9, 0, 0, 20)
tradeRequestStatus.Position = UDim2.new(0.05, 0, 0, 35)
tradeRequestStatus.BackgroundTransparency = 1
tradeRequestStatus.Text = "TRADE REQUEST: NOT DETECTED"
tradeRequestStatus.TextColor3 = ACCENT_RED
tradeRequestStatus.Font = Enum.Font.GothamBlack  -- Changed to GothamBlack
tradeRequestStatus.TextSize = 14
tradeRequestStatus.TextXAlignment = Enum.TextXAlignment.Left
tradeRequestStatus.TextStrokeTransparency = 0.2  -- Added text stroke
tradeRequestStatus.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local confirmationStatus = Instance.new("TextLabel")
confirmationStatus.Name = "ConfirmationStatus"
confirmationStatus.Parent = bgImage
confirmationStatus.Size = UDim2.new(0.9, 0, 0, 20)
confirmationStatus.Position = UDim2.new(0.05, 0, 0, 55)
confirmationStatus.BackgroundTransparency = 1
confirmationStatus.Text = "TRANSACTION: PENDING"
confirmationStatus.TextColor3 = ACCENT_BLUE
confirmationStatus.Font = Enum.Font.GothamBlack  -- Changed to GothamBlack
confirmationStatus.TextSize = 14
confirmationStatus.TextXAlignment = Enum.TextXAlignment.Left
confirmationStatus.TextStrokeTransparency = 0.2  -- Added text stroke
confirmationStatus.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Create toggle function remains the same as before
local function createToggle(name, text, yOffset)
    -- ... (same toggle creation code as before)
end

-- Create toggles
local freezeToggle = createToggle("FreezeTrade", "FREEZE TRADE", 75)
local autoAcceptToggle = createToggle("LockInventory", "AUTO ACCEPT", 115)

-- Toggle states
local antiFreezeEnabled = false
local antiAutoAcceptEnabled = false

-- Toggle logic with visual feedback
-- ... (same toggle logic as before)

-- Help button and instructions
-- ... (same help button and instructions as before)

-- Dragging functionality
-- ... (same dragging code as before)

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
        tradeRequestStatus.TextColor3 = ACCENT_GREEN
    end

    -- Trade decline detection
    if tostring(self) == "Decline" and method == "FireServer" then
        tradeRequestStatus.Text = "TRADE REQUEST: NOT DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_RED
        confirmationStatus.Text = "TRANSACTION: PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
    end

    -- Trade acceptance detection
    if tostring(self) == "Accept" and method == "FireServer" then
        confirmationStatus.Text = "TRANSACTION: ACCEPTED"
        confirmationStatus.TextColor3 = ACCENT_GREEN
    end

    return oldNamecall(self, ...)
end

setreadonly(mt, true)
