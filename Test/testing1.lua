-- TradeHelperUI ✅ FINAL UPDATE
-- Logo with rounded corners, draggable, positioned at top
-- Menu with smooth animations

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Color scheme
local BROWN_BG = Color3.fromRGB(118, 61, 25)
local BROWN_LIGHT = Color3.fromRGB(164, 97, 43)
local BROWN_BORDER = Color3.fromRGB(51, 25, 0)
local ACCENT_GREEN = Color3.fromRGB(110, 196, 99)
local BUTTON_RED = Color3.fromRGB(255, 62, 62)
local BUTTON_GRAY = Color3.fromRGB(190, 190, 190)
local BUTTON_GREEN = Color3.fromRGB(85, 200, 85)
local BUTTON_GREEN_HOVER = Color3.fromRGB(120, 230, 120)
local FONT = Enum.Font.FredokaOne
local TILE_IMAGE = "rbxassetid://15910695828"

local gui = Instance.new("ScreenGui")
gui.Name = "TradeHelperUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game:GetService("CoreGui")

-- TOGGLE LOGO (rounded corners, draggable, top position)
local toggleLogo = Instance.new("ImageButton")
toggleLogo.Size = UDim2.new(0, 42, 0, 42)
toggleLogo.Position = UDim2.new(0, 15, 0, 80)
toggleLogo.BackgroundColor3 = BROWN_BG
toggleLogo.Image = "rbxassetid://81767899440204"
toggleLogo.AutoButtonColor = true
toggleLogo.ZIndex = 999
toggleLogo.Parent = gui

local corner = Instance.new("UICorner", toggleLogo)
corner.CornerRadius = UDim.new(0, 8)

-- Add border to logo
local logoBorder = Instance.new("UIStroke", toggleLogo)
logoBorder.Color = BROWN_BORDER
logoBorder.Thickness = 2

-- Drag functionality
local dragging = false
local dragStart, startPos
toggleLogo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = toggleLogo.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		toggleLogo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- NOTIFICATIONS (bottom, non-overlapping)
local activeNotifs = {}
function showNotification(text, color)
	local baseY = -60
	for _, n in ipairs(activeNotifs) do
		baseY = baseY - 35
	end

	local notif = Instance.new("TextLabel")
	notif.Size = UDim2.new(0, 260, 0, 30)
	notif.Position = UDim2.new(0.5, -130, 1, baseY)
	notif.AnchorPoint = Vector2.new(0, 0)
	notif.BackgroundColor3 = BROWN_BG
	notif.TextColor3 = color
	notif.Text = text
	notif.Font = FONT
	notif.TextSize = 14
	notif.TextStrokeTransparency = 0.6
	notif.BackgroundTransparency = 1
	notif.TextTransparency = 1
	notif.BorderSizePixel = 0
	notif.ZIndex = 999
	notif.ClipsDescendants = true
	notif.Parent = gui
	table.insert(activeNotifs, notif)

	-- Add border and corner
	local notifCorner = Instance.new("UICorner", notif)
	notifCorner.CornerRadius = UDim.new(0, 8)
	local notifBorder = Instance.new("UIStroke", notif)
	notifBorder.Color = BROWN_BORDER
	notifBorder.Thickness = 2

	TweenService:Create(notif, TweenInfo.new(0.3), {
		TextTransparency = 0,
		BackgroundTransparency = 0
	}):Play()

	task.delay(3, function()
		TweenService:Create(notif, TweenInfo.new(0.3), {
			TextTransparency = 1,
			BackgroundTransparency = 1,
			Position = notif.Position + UDim2.new(0, 0, 0, -10)
		}):Play()
		wait(0.3)
		notif:Destroy()

		for i, v in ipairs(activeNotifs) do
			if v == notif then
				table.remove(activeNotifs, i)
				break
			end
		end

		for i, v in ipairs(activeNotifs) do
			local newY = -60 - (i - 1) * 35
			TweenService:Create(v, TweenInfo.new(0.3), {
				Position = UDim2.new(0.5, -130, 1, newY)
			}):Play()
		end
	end)
end

-- MAIN MENU FRAME
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 230)
main.Position = UDim2.new(0.5, -140, 0.5, -115)
main.BackgroundColor3 = BROWN_BG
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Active = true
main.Draggable = true
main.Visible = false
main.Parent = gui

-- Add tile background
local bgPattern = Instance.new("ImageLabel")
bgPattern.Name = "BackgroundPattern"
bgPattern.Image = TILE_IMAGE
bgPattern.ScaleType = Enum.ScaleType.Tile
bgPattern.TileSize = UDim2.new(0, 100, 0, 100)
bgPattern.BackgroundTransparency = 1
bgPattern.Size = UDim2.new(1, 0, 1, 0)
bgPattern.ZIndex = 0
bgPattern.ImageTransparency = 0.8
bgPattern.Parent = main

-- Add border
local mainBorder = Instance.new("UIStroke", main)
mainBorder.Color = BROWN_BORDER
mainBorder.Thickness = 2

-- Add corner radius
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 12)

-- Toggle functionality
toggleLogo.MouseButton1Click:Connect(function()
	if main.Visible then
		TweenService:Create(main, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0)}):Play()
		task.delay(0.2, function() main.Visible = false end)
	else
		main.Size = UDim2.new(0, 0, 0, 0)
		main.Visible = true
		TweenService:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 230)}):Play()
	end
end)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🦝 TRADE HELPER UI 🌶️"
title.Font = FONT
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)

-- Subtitle
local subtitle = Instance.new("TextLabel", main)
subtitle.Size = UDim2.new(1, 0, 0, 15)
subtitle.Position = UDim2.new(0, 0, 0, 32)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Trade Management Tools"
subtitle.Font = FONT
subtitle.TextSize = 12
subtitle.TextColor3 = Color3.fromRGB(220, 220, 220)

-- Player dropdown
local dropdownBtn = Instance.new("TextButton", main)
dropdownBtn.Size = UDim2.new(0.9, 0, 0, 35)
dropdownBtn.Position = UDim2.new(0.5, 0, 0, 55)
dropdownBtn.AnchorPoint = Vector2.new(0.5, 0)
dropdownBtn.Text = "Select Player"
dropdownBtn.TextColor3 = Color3.new(1, 1, 1)
dropdownBtn.BackgroundColor3 = BROWN_LIGHT
dropdownBtn.Font = FONT
dropdownBtn.TextSize = 14
dropdownBtn.ZIndex = 3

-- Dropdown styling
local btnCorner = Instance.new("UICorner", dropdownBtn)
btnCorner.CornerRadius = UDim.new(0, 6)
local btnBorder = Instance.new("UIStroke", dropdownBtn)
btnBorder.Color = BROWN_BORDER
btnBorder.Thickness = 2

-- Avatar preview
local dropdownAvatar = Instance.new("ImageLabel", dropdownBtn)
dropdownAvatar.Size = UDim2.new(0, 24, 0, 24)
dropdownAvatar.Position = UDim2.new(0, 5, 0.5, -12)
dropdownAvatar.BackgroundTransparency = 1
dropdownAvatar.Image = ""
dropdownAvatar.Visible = false

-- Player list
local listFrame = Instance.new("ScrollingFrame", main)
listFrame.Size = UDim2.new(0.9, 0, 0, 0)
listFrame.Position = UDim2.new(0.5, 0, 0, 95)
listFrame.AnchorPoint = Vector2.new(0.5, 0)
listFrame.BackgroundTransparency = 1
listFrame.BorderSizePixel = 0
listFrame.ScrollBarThickness = 4
listFrame.Visible = false
listFrame.ClipsDescendants = true
listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
listFrame.ZIndex = 3

-- List layout
local listLayout = Instance.new("UIListLayout", listFrame)
listLayout.Padding = UDim.new(0, 4)

-- Toggle button creator
local function createToggleFrame(text, y)
	local frame = Instance.new("Frame", main)
	frame.Size = UDim2.new(0.9, 0, 0, 30)
	frame.Position = UDim2.new(0.5, 0, 0, y)
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.BackgroundColor3 = BROWN_LIGHT
	frame.BorderSizePixel = 0
	frame.ZIndex = 2
	
	-- Add styling
	local frameCorner = Instance.new("UICorner", frame)
	frameCorner.CornerRadius = UDim.new(0, 6)
	local frameBorder = Instance.new("UIStroke", frame)
	frameBorder.Color = BROWN_BORDER
	frameBorder.Thickness = 2

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, -55, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = FONT
	label.TextSize = 14
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggle = Instance.new("TextButton", frame)
	toggle.Size = UDim2.new(0, 40, 0, 20)
	toggle.Position = UDim2.new(1, -45, 0.5, -10)
	toggle.BackgroundColor3 = BUTTON_GRAY
	toggle.Text = ""
	toggle.BorderSizePixel = 0
	toggle.ZIndex = 2
	
	-- Toggle styling
	local toggleCorner = Instance.new("UICorner", toggle)
	toggleCorner.CornerRadius = UDim.new(1, 0)
	local toggleBorder = Instance.new("UIStroke", toggle)
	toggleBorder.Color = BROWN_BORDER
	toggleBorder.Thickness = 1

	local dot = Instance.new("Frame", toggle)
	dot.Size = UDim2.new(0, 16, 0, 16)
	dot.Position = UDim2.new(0, 2, 0.5, -8)
	dot.BackgroundColor3 = Color3.new(1, 1, 1)
	dot.BorderSizePixel = 0
	dot.ZIndex = 3
	
	-- Dot styling
	local dotCorner = Instance.new("UICorner", dot)
	dotCorner.CornerRadius = UDim.new(1, 0)
	local dotBorder = Instance.new("UIStroke", dot)
	dotBorder.Color = BROWN_BORDER
	dotBorder.Thickness = 1

	local toggled = false
	toggle.MouseButton1Click:Connect(function()
		toggled = not toggled
		TweenService:Create(toggle, TweenInfo.new(0.2), {
			BackgroundColor3 = toggled and BUTTON_GREEN or BUTTON_GRAY
		}):Play()
		TweenService:Create(dot, TweenInfo.new(0.2), {
			Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		}):Play()

		showNotification(text .. (toggled and " Enabled" or " Disabled"),
			toggled and ACCENT_GREEN or BUTTON_RED)
	end)

	return frame
end

-- Create toggle buttons
local tradeFreeze = createToggleFrame("Trade Freeze", 100)
local securityMode = createToggleFrame("Security Mode", 140)
local tradeProtection = createToggleFrame("Trade Protection", 180)

-- Information label
local infoLabel = Instance.new("TextLabel", main)
infoLabel.Text = "⚠️ Trade Safely ‼️"
infoLabel.Font = FONT
infoLabel.TextColor3 = ACCENT_GREEN
infoLabel.TextStrokeTransparency = 0.5
infoLabel.TextSize = 13
infoLabel.BackgroundTransparency = 1
infoLabel.Size = UDim2.new(1, 0, 0, 20)
infoLabel.Position = UDim2.new(0.5, 0, 0, 210)
infoLabel.AnchorPoint = Vector2.new(0.5, 0)
infoLabel.ZIndex = 2

-- Dropdown functionality
local dropdownOpen = false
local function refreshPlayers()
	for _, c in pairs(listFrame:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
	
	local count = 0
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer then
			count += 1
			local btn = Instance.new("TextButton", listFrame)
			btn.Size = UDim2.new(1, 0, 0, 30)
			btn.BackgroundColor3 = BROWN_LIGHT
			btn.Text = "            " .. plr.Name
			btn.Font = FONT
			btn.TextSize = 13
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.ZIndex = 4
			
			-- Button styling
			local btnCorner = Instance.new("UICorner", btn)
			btnCorner.CornerRadius = UDim.new(0, 6)
			local btnBorder = Instance.new("UIStroke", btn)
			btnBorder.Color = BROWN_BORDER
			btnBorder.Thickness = 2
			
			-- Hover effect
			btn.MouseEnter:Connect(function()
				TweenService:Create(btn, TweenInfo.new(0.1), {
					BackgroundColor3 = BUTTON_GREEN_HOVER
				}):Play()
			end)
			
			btn.MouseLeave:Connect(function()
				TweenService:Create(btn, TweenInfo.new(0.1), {
					BackgroundColor3 = BROWN_LIGHT
				}):Play()
			end)

			local avatar = Instance.new("ImageLabel", btn)
			avatar.Size = UDim2.new(0, 24, 0, 24)
			avatar.Position = UDim2.new(0, 3, 0.5, -12)
			avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..plr.UserId.."&width=50&height=50&format=png"
			avatar.BackgroundTransparency = 1

			btn.MouseButton1Click:Connect(function()
				dropdownBtn.Text = plr.Name
				dropdownAvatar.Image = avatar.Image
				dropdownAvatar.Visible = true
				listFrame.Visible = false
				dropdownOpen = false
				main:TweenSize(UDim2.new(0, 280, 0, 240), "Out", "Sine", 0.25, true)
				TweenService:Create(tradeFreeze, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 100)}):Play()
				TweenService:Create(securityMode, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 140)}):Play()
				TweenService:Create(tradeProtection, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 180)}):Play()
				TweenService:Create(infoLabel, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 210)}):Play()
			end)
		end
	end
	listFrame.CanvasSize = UDim2.new(0, 0, 0, count * 34)
end

-- Dropdown toggle
dropdownBtn.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	if dropdownOpen then
		refreshPlayers()
		listFrame.Visible = true
		listFrame:TweenSize(UDim2.new(0.9, 0, 0, 100), "Out", "Sine", 0.25, true)
		main:TweenSize(UDim2.new(0, 280, 0, 340), "Out", "Sine", 0.25, true)
		TweenService:Create(tradeFreeze, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 200)}):Play()
		TweenService:Create(securityMode, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 240)}):Play()
		TweenService:Create(tradeProtection, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 280)}):Play()
		TweenService:Create(infoLabel, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 310)}):Play()
	else
		listFrame:TweenSize(UDim2.new(0.9, 0, 0, 0), "Out", "Sine", 0.25, true)
		task.delay(0.25, function() listFrame.Visible = false end)
		main:TweenSize(UDim2.new(0, 280, 0, 240), "Out", "Sine", 0.25, true)
		TweenService:Create(tradeFreeze, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 100)}):Play()
		TweenService:Create(securityMode, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 140)}):Play()
		TweenService:Create(tradeProtection, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 180)}):Play()
		TweenService:Create(infoLabel, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 210)}):Play()
	end
end)
