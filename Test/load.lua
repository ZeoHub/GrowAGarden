-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

-- ========== CREATE MAIN GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 300)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -150)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

local tradeRequestStatus = Instance.new("TextLabel", MainFrame)
tradeRequestStatus.Name = "TradeRequestStatus"
tradeRequestStatus.Size = UDim2.new(1, -20, 0, 30)
tradeRequestStatus.Position = UDim2.new(0, 10, 0, 10)
tradeRequestStatus.BackgroundTransparency = 1
tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
tradeRequestStatus.Font = FONT
tradeRequestStatus.TextColor3 = ACCENT_RED
tradeRequestStatus.TextSize = 14
tradeRequestStatus.TextXAlignment = Enum.TextXAlignment.Left

local confirmationStatus = Instance.new("TextLabel", MainFrame)
confirmationStatus.Name = "ConfirmationStatus"
confirmationStatus.Size = UDim2.new(1, -20, 0, 30)
confirmationStatus.Position = UDim2.new(0, 10, 0, 50)
confirmationStatus.BackgroundTransparency = 1
confirmationStatus.Text = "Transaction: PENDING"
confirmationStatus.Font = FONT
confirmationStatus.TextColor3 = ACCENT_BLUE
confirmationStatus.TextSize = 14
confirmationStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Anti-Freeze Toggle
local antiFreezeFrame = Instance.new("Frame", MainFrame)
antiFreezeFrame.Name = "AntiFreezeFrame"
antiFreezeFrame.Size = UDim2.new(1, -20, 0, 40)
antiFreezeFrame.Position = UDim2.new(0, 10, 0, 100)
antiFreezeFrame.BackgroundColor3 = CARD_BG
antiFreezeFrame.Visible = false
local antiFreezeCorner = Instance.new("UICorner", antiFreezeFrame)
antiFreezeCorner.CornerRadius = UDim.new(0, 8)

local antiFreezeLabel = Instance.new("TextLabel", antiFreezeFrame)
antiFreezeLabel.Name = "AntiFreezeLabel"
antiFreezeLabel.Size = UDim2.new(0.7, 0, 1, 0)
antiFreezeLabel.Position = UDim2.new(0, 10, 0, 0)
antiFreezeLabel.BackgroundTransparency = 1
antiFreezeLabel.Text = "Anti-Freeze"
antiFreezeLabel.Font = FONT
antiFreezeLabel.TextColor3 = TEXT_MAIN
antiFreezeLabel.TextSize = 14
antiFreezeLabel.TextXAlignment = Enum.TextXAlignment.Left

local antiFreezeToggle = Instance.new("TextButton", antiFreezeFrame)
antiFreezeToggle.Name = "AntiFreezeToggle"
antiFreezeToggle.Size = UDim2.new(0.2, 0, 0.6, 0)
antiFreezeToggle.Position = UDim2.new(0.75, 0, 0.2, 0)
antiFreezeToggle.BackgroundColor3 = ACCENT_RED
antiFreezeToggle.Text = "OFF"
antiFreezeToggle.Font = FONT
antiFreezeToggle.TextColor3 = TEXT_MAIN
antiFreezeToggle.TextSize = 14
local antiFreezeToggleCorner = Instance.new("UICorner", antiFreezeToggle)
antiFreezeToggleCorner.CornerRadius = UDim.new(0, 8)

-- Anti-AutoAccept Toggle
local antiAutoAcceptFrame = Instance.new("Frame", MainFrame)
antiAutoAcceptFrame.Name = "AntiAutoAcceptFrame"
antiAutoAcceptFrame.Size = UDim2.new(1, -20, 0, 40)
antiAutoAcceptFrame.Position = UDim2.new(0, 10, 0, 150)
antiAutoAcceptFrame.BackgroundColor3 = CARD_BG
antiAutoAcceptFrame.Visible = false
local antiAutoAcceptCorner = Instance.new("UICorner", antiAutoAcceptFrame)
antiAutoAcceptCorner.CornerRadius = UDim.new(0, 8)

local antiAutoAcceptLabel = Instance.new("TextLabel", antiAutoAcceptFrame)
antiAutoAcceptLabel.Name = "AntiAutoAcceptLabel"
antiAutoAcceptLabel.Size = UDim2.new(0.7, 0, 1, 0)
antiAutoAcceptLabel.Position = UDim2.new(0, 10, 0, 0)
antiAutoAcceptLabel.BackgroundTransparency = 1
antiAutoAcceptLabel.Text = "Anti-AutoAccept"
antiAutoAcceptLabel.Font = FONT
antiAutoAcceptLabel.TextColor3 = TEXT_MAIN
antiAutoAcceptLabel.TextSize = 14
antiAutoAcceptLabel.TextXAlignment = Enum.TextXAlignment.Left

local antiAutoAcceptToggle = Instance.new("TextButton", antiAutoAcceptFrame)
antiAutoAcceptToggle.Name = "AntiAutoAcceptToggle"
antiAutoAcceptToggle.Size = UDim2.new(0.2, 0, 0.6, 0)
antiAutoAcceptToggle.Position = UDim2.new(0.75, 0, 0.2, 0)
antiAutoAcceptToggle.BackgroundColor3 = ACCENT_RED
antiAutoAcceptToggle.Text = "OFF"
antiAutoAcceptToggle.Font = FONT
antiAutoAcceptToggle.TextColor3 = TEXT_MAIN
antiAutoAcceptToggle.TextSize = 14
local antiAutoAcceptToggleCorner = Instance.new("UICorner", antiAutoAcceptToggle)
antiAutoAcceptToggleCorner.CornerRadius = UDim.new(0, 8)

-- Toggle Logic
local antiFreezeEnabled = false
local antiAutoAcceptEnabled = false

antiFreezeToggle.MouseButton1Click:Connect(function()
    antiFreezeEnabled = not antiFreezeEnabled
    if antiFreezeEnabled then
        antiFreezeToggle.Text = "ON"
        antiFreezeToggle.BackgroundColor3 = ACCENT_GREEN
    else
        antiFreezeToggle.Text = "OFF"
        antiFreezeToggle.BackgroundColor3 = ACCENT_RED
    end
end)

antiAutoAcceptToggle.MouseButton1Click:Connect(function()
    antiAutoAcceptEnabled = not antiAutoAcceptEnabled
    if antiAutoAcceptEnabled then
        antiAutoAcceptToggle.Text = "ON"
        antiAutoAcceptToggle.BackgroundColor3 = ACCENT_GREEN
    else
        antiAutoAcceptToggle.Text = "OFF"
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

    -- Check if the RemoteEvent is "SendRequest" or "RespondRequest" and the method is "FireServer"
    if (tostring(self) == "SendRequest" or tostring(self) == "RespondRequest") and method == "FireServer" then
        -- Update the GUI to show that a trade transaction was detected
        tradeRequestStatus.Text = "Trade Request: DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_GREEN

        -- Show the toggles
        antiFreezeFrame.Visible = true
        antiAutoAcceptFrame.Visible = true
    end

    -- Check if the RemoteEvent is "Decline" and the method is "FireServer"
    if tostring(self) == "Decline" and method == "FireServer" then
        -- Reset the trade request and hide toggles
        tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_RED
        confirmationStatus.Text = "Transaction: PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
        antiFreezeFrame.Visible = false
        antiAutoAcceptFrame.Visible = false
    end

    -- Check if the RemoteEvent is "Accept" and the method is "FireServer"
    if tostring(self) == "Accept" and method == "FireServer" then
        -- Show confirmation in the GUI
        confirmationStatus.Text = "Transaction: ACCEPTED"
        confirmationStatus.TextColor3 = ACCENT_GREEN
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
