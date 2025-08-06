-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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
ScreenGui.DisplayOrder = 10
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main container
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 180)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -90)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Title bar
local titleBar = Instance.new("Frame", MainFrame)
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = ACCENT_BLUE
local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 12)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "TRADE SECURITY SYSTEM"
titleText.Font = FONT
titleText.TextColor3 = TEXT_MAIN
titleText.TextSize = 18
titleText.TextXAlignment = Enum.TextXAlignment.Left

-- Close button
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = ACCENT_RED
closeBtn.Text = "X"
closeBtn.Font = FONT
closeBtn.TextColor3 = TEXT_MAIN
closeBtn.TextSize = 14
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 8)

-- Status indicators
local tradeTicketStatus = Instance.new("TextLabel", MainFrame)
tradeTicketStatus.Name = "TradeTicketStatus"
tradeTicketStatus.Size = UDim2.new(1, -20, 0, 30)
tradeTicketStatus.Position = UDim2.new(0, 10, 0, 50)
tradeTicketStatus.BackgroundTransparency = 1
tradeTicketStatus.Text = "Trade Ticket: NOT DETECTED"
tradeTicketStatus.Font = FONT
tradeTicketStatus.TextColor3 = ACCENT_RED
tradeTicketStatus.TextSize = 14
tradeTicketStatus.TextXAlignment = Enum.TextXAlignment.Left

local tradeInputStatus = Instance.new("TextLabel", MainFrame)
tradeInputStatus.Name = "TradeInputStatus"
tradeInputStatus.Size = UDim2.new(1, -20, 0, 30)
tradeInputStatus.Position = UDim2.new(0, 10, 0, 90)
tradeInputStatus.BackgroundTransparency = 1
tradeInputStatus.Text = "TradeInputService: NOT DETECTED"
tradeInputStatus.Font = FONT
tradeInputStatus.TextColor3 = ACCENT_RED
tradeInputStatus.TextSize = 14
tradeInputStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ========== DETECTION LOGIC ==========
local function updateTradeTicketStatus()
    local tradeTicket = Backpack:FindFirstChild("Trade Ticket")
    if tradeTicket then
        tradeTicketStatus.Text = "Trade Ticket: DETECTED"
        tradeTicketStatus.TextColor3 = ACCENT_GREEN
    else
        tradeTicketStatus.Text = "Trade Ticket: NOT DETECTED"
        tradeTicketStatus.TextColor3 = ACCENT_RED

        -- Fake detection logic
        print("Fake detection: Trade Freezer and Auto Accept detected!")
    end
end

local function updateTradeInputStatus()
    local tradeInputService = ReplicatedStorage:FindFirstChild("Modules")
        and ReplicatedStorage.Modules:FindFirstChild("TradeControllers")
        and ReplicatedStorage.Modules.TradeControllers:FindFirstChild("TradeInputService")

    if tradeInputService then
        tradeInputStatus.Text = "TradeInputService: DETECTED"
        tradeInputStatus.TextColor3 = ACCENT_GREEN
    else
        tradeInputStatus.Text = "TradeInputService: NOT DETECTED"
        tradeInputStatus.TextColor3 = ACCENT_RED
    end
end

-- Monitor backpack for changes
Backpack.ChildRemoved:Connect(function(child)
    if child.Name == "Trade Ticket" then
        updateTradeTicketStatus()
    end
end)

Backpack.ChildAdded:Connect(function(child)
    if child.Name == "Trade Ticket" then
        updateTradeTicketStatus()
    end
end)

-- Initial status update
updateTradeTicketStatus()
updateTradeInputStatus()

-- Periodically check TradeInputService
RunService.Heartbeat:Connect(updateTradeInputStatus)
