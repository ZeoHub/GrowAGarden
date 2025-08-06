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
local ACCENT_YELLOW = Color3.fromRGB(255, 200, 0)
local TEXT_MAIN = Color3.fromRGB(240, 240, 255)
local FONT = Enum.Font.GothamBold

-- ========== CREATE COMPACT GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeGuardGui"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 100)  -- Compact size
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -50)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Status labels
local tradeRequestStatus = Instance.new("TextLabel", MainFrame)
tradeRequestStatus.Name = "TradeRequestStatus"
tradeRequestStatus.Size = UDim2.new(1, -10, 0, 20)
tradeRequestStatus.Position = UDim2.new(0, 5, 0, 5)
tradeRequestStatus.BackgroundTransparency = 1
tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
tradeRequestStatus.Font = FONT
tradeRequestStatus.TextColor3 = ACCENT_RED
tradeRequestStatus.TextSize = 12
tradeRequestStatus.TextXAlignment = Enum.TextXAlignment.Left

local confirmationStatus = Instance.new("TextLabel", MainFrame)
confirmationStatus.Name = "ConfirmationStatus"
confirmationStatus.Size = UDim2.new(1, -10, 0, 20)
confirmationStatus.Position = UDim2.new(0, 5, 0, 25)
confirmationStatus.BackgroundTransparency = 1
confirmationStatus.Text = "Transaction: PENDING"
confirmationStatus.Font = FONT
confirmationStatus.TextColor3 = ACCENT_BLUE
confirmationStatus.TextSize = 12
confirmationStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Trade Freezer Toggle
local tradeFreezerFrame = Instance.new("Frame", MainFrame)
tradeFreezerFrame.Name = "TradeFreezerFrame"
tradeFreezerFrame.Size = UDim2.new(1, -10, 0, 30)
tradeFreezerFrame.Position = UDim2.new(0, 5, 0, 50)
tradeFreezerFrame.BackgroundColor3 = CARD_BG
tradeFreezerFrame.Visible = false
local tradeFreezerCorner = Instance.new("UICorner", tradeFreezerFrame)
tradeFreezerCorner.CornerRadius = UDim.new(0, 6)

local tradeFreezerLabel = Instance.new("TextLabel", tradeFreezerFrame)
tradeFreezerLabel.Name = "TradeFreezerLabel"
tradeFreezerLabel.Size = UDim2.new(0.5, 0, 1, 0)
tradeFreezerLabel.Position = UDim2.new(0, 5, 0, 0)
tradeFreezerLabel.BackgroundTransparency = 1
tradeFreezerLabel.Text = "Trade Freezer"
tradeFreezerLabel.Font = FONT
tradeFreezerLabel.TextColor3 = TEXT_MAIN
tradeFreezerLabel.TextSize = 12
tradeFreezerLabel.TextXAlignment = Enum.TextXAlignment.Left

local tradeFreezerToggle = Instance.new("TextButton", tradeFreezerFrame)
tradeFreezerToggle.Name = "TradeFreezerToggle"
tradeFreezerToggle.Size = UDim2.new(0.45, 0, 0.8, 0)
tradeFreezerToggle.Position = UDim2.new(0.5, 5, 0.1, 0)
tradeFreezerToggle.BackgroundColor3 = ACCENT_RED
tradeFreezerToggle.Text = "OFF"
tradeFreezerToggle.Font = FONT
tradeFreezerToggle.TextColor3 = TEXT_MAIN
tradeFreezerToggle.TextSize = 12
local tradeFreezerToggleCorner = Instance.new("UICorner", tradeFreezerToggle)
tradeFreezerToggleCorner.CornerRadius = UDim.new(0, 6)

-- Auto Accept Toggle
local autoAcceptFrame = Instance.new("Frame", MainFrame)
autoAcceptFrame.Name = "AutoAcceptFrame"
autoAcceptFrame.Size = UDim2.new(1, -10, 0, 30)
autoAcceptFrame.Position = UDim2.new(0, 5, 0, 85)
autoAcceptFrame.BackgroundColor3 = CARD_BG
autoAcceptFrame.Visible = false
local autoAcceptCorner = Instance.new("UICorner", autoAcceptFrame)
autoAcceptCorner.CornerRadius = UDim.new(0, 6)

local autoAcceptLabel = Instance.new("TextLabel", autoAcceptFrame)
autoAcceptLabel.Name = "AutoAcceptLabel"
autoAcceptLabel.Size = UDim2.new(0.5, 0, 1, 0)
autoAcceptLabel.Position = UDim2.new(0, 5, 0, 0)
autoAcceptLabel.BackgroundTransparency = 1
autoAcceptLabel.Text = "Auto Accept"
autoAcceptLabel.Font = FONT
autoAcceptLabel.TextColor3 = TEXT_MAIN
autoAcceptLabel.TextSize = 12
autoAcceptLabel.TextXAlignment = Enum.TextXAlignment.Left

local autoAcceptToggle = Instance.new("TextButton", autoAcceptFrame)
autoAcceptToggle.Name = "AutoAcceptToggle"
autoAcceptToggle.Size = UDim2.new(0.45, 0, 0.8, 0)
autoAcceptToggle.Position = UDim2.new(0.5, 5, 0.1, 0)
autoAcceptToggle.BackgroundColor3 = ACCENT_RED
autoAcceptToggle.Text = "OFF"
autoAcceptToggle.Font = FONT
autoAcceptToggle.TextColor3 = TEXT_MAIN
autoAcceptToggle.TextSize = 12
local autoAcceptToggleCorner = Instance.new("UICorner", autoAcceptToggle)
autoAcceptToggleCorner.CornerRadius = UDim.new(0, 6)

-- Force Accept Button
local forceAcceptFrame = Instance.new("Frame", MainFrame)
forceAcceptFrame.Name = "ForceAcceptFrame"
forceAcceptFrame.Size = UDim2.new(1, -10, 0, 30)
forceAcceptFrame.Position = UDim2.new(0, 5, 0, 120)
forceAcceptFrame.BackgroundColor3 = CARD_BG
forceAcceptFrame.Visible = false
local forceAcceptCorner = Instance.new("UICorner", forceAcceptFrame)
forceAcceptCorner.CornerRadius = UDim.new(0, 6)

local forceAcceptButton = Instance.new("TextButton", forceAcceptFrame)
forceAcceptButton.Name = "ForceAcceptButton"
forceAcceptButton.Size = UDim2.new(1, -10, 0.8, 0)
forceAcceptButton.Position = UDim2.new(0.5, -((forceAcceptFrame.AbsoluteSize.X - 10)/2), 0.1, 0)
forceAcceptButton.AnchorPoint = Vector2.new(0.5, 0)
forceAcceptButton.BackgroundColor3 = ACCENT_YELLOW
forceAcceptButton.Text = "FORCE ACCEPT"
forceAcceptButton.Font = FONT
forceAcceptButton.TextColor3 = Color3.new(0, 0, 0)
forceAcceptButton.TextSize = 14
forceAcceptButton.TextScaled = true
local forceAcceptButtonCorner = Instance.new("UICorner", forceAcceptButton)
forceAcceptButtonCorner.CornerRadius = UDim.new(0, 6)

-- Toggle Logic
local tradeFreezerEnabled = false
local autoAcceptEnabled = false

tradeFreezerToggle.MouseButton1Click:Connect(function()
    tradeFreezerEnabled = not tradeFreezerEnabled
    if tradeFreezerEnabled then
        tradeFreezerToggle.Text = "ON"
        tradeFreezerToggle.BackgroundColor3 = ACCENT_GREEN
        confirmationStatus.Text = "Trade FROZEN"
        confirmationStatus.TextColor3 = ACCENT_BLUE
    else
        tradeFreezerToggle.Text = "OFF"
        tradeFreezerToggle.BackgroundColor3 = ACCENT_RED
        confirmationStatus.Text = "Transaction: PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
    end
end)

autoAcceptToggle.MouseButton1Click:Connect(function()
    autoAcceptEnabled = not autoAcceptEnabled
    if autoAcceptEnabled then
        autoAcceptToggle.Text = "ON"
        autoAcceptToggle.BackgroundColor3 = ACCENT_GREEN
    else
        autoAcceptToggle.Text = "OFF"
        autoAcceptToggle.BackgroundColor3 = ACCENT_RED
    end
end)

-- Force Accept Button Logic
forceAcceptButton.MouseButton1Click:Connect(function()
    -- Find and fire the Accept remote
    local acceptRemote = ReplicatedStorage:FindFirstChild("Accept")
    if acceptRemote then
        confirmationStatus.Text = "FORCING ACCEPT..."
        confirmationStatus.TextColor3 = ACCENT_YELLOW
        
        -- Fire the accept remote
        acceptRemote:FireServer()
        
        -- Visual feedback
        forceAcceptButton.BackgroundColor3 = ACCENT_GREEN
        forceAcceptButton.Text = "ACCEPTED!"
        
        -- Reset after 2 seconds
        delay(2, function()
            if forceAcceptButton then
                forceAcceptButton.BackgroundColor3 = ACCENT_YELLOW
                forceAcceptButton.Text = "FORCE ACCEPT"
            end
        end)
    else
        confirmationStatus.Text = "ERROR: No Accept remote"
        confirmationStatus.TextColor3 = ACCENT_RED
    end
end)

-- ========== DETECTION LOGIC ==========
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    local remoteName = tostring(self)

    -- Trade detection
    if (remoteName == "SendRequest" or remoteName == "RespondRequest") and method == "FireServer" then
        tradeRequestStatus.Text = "Trade Request: DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_GREEN
        
        -- Expand GUI and show controls
        MainFrame.Size = UDim2.new(0, 260, 0, 155)
        tradeFreezerFrame.Visible = true
        autoAcceptFrame.Visible = true
        forceAcceptFrame.Visible = true
        
        -- Auto Accept functionality
        if autoAcceptEnabled then
            confirmationStatus.Text = "Auto Accepting..."
            confirmationStatus.TextColor3 = ACCENT_BLUE
            
            -- Delay to simulate user action
            wait(1)
            
            -- Find and fire the Accept remote
            local acceptRemote = ReplicatedStorage:FindFirstChild("Accept")
            if acceptRemote then
                acceptRemote:FireServer()
            end
        end
    end

    -- Decline handling
    if remoteName == "Decline" and method == "FireServer" then
        tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
        tradeRequestStatus.TextColor3 = ACCENT_RED
        confirmationStatus.Text = "Transaction: PENDING"
        confirmationStatus.TextColor3 = ACCENT_BLUE
        
        -- Collapse GUI and hide controls
        MainFrame.Size = UDim2.new(0, 260, 0, 100)
        tradeFreezerFrame.Visible = false
        autoAcceptFrame.Visible = false
        forceAcceptFrame.Visible = false
        
        -- Reset toggle states
        tradeFreezerEnabled = false
        tradeFreezerToggle.Text = "OFF"
        tradeFreezerToggle.BackgroundColor3 = ACCENT_RED
        autoAcceptEnabled = false
        autoAcceptToggle.Text = "OFF"
        autoAcceptToggle.BackgroundColor3 = ACCENT_RED
    end

    -- Accept handling
    if remoteName == "Accept" and method == "FireServer" then
        -- Block if trade freezer is enabled
        if tradeFreezerEnabled then
            confirmationStatus.Text = "Accept BLOCKED (Freezer)"
            confirmationStatus.TextColor3 = ACCENT_RED
            return
        end
        
        confirmationStatus.Text = "Transaction: ACCEPTED"
        confirmationStatus.TextColor3 = ACCENT_GREEN
        
        -- Auto-reset after 5 seconds
        delay(5, function()
            if tradeRequestStatus and confirmationStatus then
                tradeRequestStatus.Text = "Trade Request: NOT DETECTED"
                tradeRequestStatus.TextColor3 = ACCENT_RED
                confirmationStatus.Text = "Transaction: PENDING"
                confirmationStatus.TextColor3 = ACCENT_BLUE
                MainFrame.Size = UDim2.new(0, 260, 0, 100)
                tradeFreezerFrame.Visible = false
                autoAcceptFrame.Visible = false
                forceAcceptFrame.Visible = false
                
                -- Reset toggle states
                tradeFreezerEnabled = false
                if tradeFreezerToggle then
                    tradeFreezerToggle.Text = "OFF"
                    tradeFreezerToggle.BackgroundColor3 = ACCENT_RED
                end
                autoAcceptEnabled = false
                if autoAcceptToggle then
                    autoAcceptToggle.Text = "OFF"
                    autoAcceptToggle.BackgroundColor3 = ACCENT_RED
                end
            end
        end)
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
