-- TradeScamUI ✅ FINAL UPDATE
-- Logo bo góc, drag được, nằm phía trên
-- Menu có animation xuất hiện mượt

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TradeScamUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game:GetService("CoreGui")

-- LOGO BẬT/TẮT MENU (bo góc, drag được, vị trí trên)
local toggleLogo = Instance.new("ImageButton")
toggleLogo.Size = UDim2.new(0, 42, 0, 42)
toggleLogo.Position = UDim2.new(0, 15, 0, 80)
toggleLogo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleLogo.Image = "rbxassetid://108503499263102"
toggleLogo.AutoButtonColor = true
toggleLogo.ZIndex = 999
toggleLogo.Parent = gui

local corner = Instance.new("UICorner", toggleLogo)
corner.CornerRadius = UDim.new(0, 8)

-- Drag
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

-- NOTIFICATION BÊN DƯỚI, KHÔNG ĐÈ
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
	notif.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	notif.TextColor3 = color
	notif.Text = text
	notif.Font = Enum.Font.GothamBold
	notif.TextSize = 14
	notif.TextStrokeTransparency = 0.6
	notif.BackgroundTransparency = 1
	notif.TextTransparency = 1
	notif.BorderSizePixel = 0
	notif.ZIndex = 999
	notif.ClipsDescendants = true
	notif.Parent = gui
	table.insert(activeNotifs, notif)

	Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)

	TweenService:Create(notif, TweenInfo.new(0.3), {
		TextTransparency = 0,
		BackgroundTransparency = 0.1
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


-- PHẦN MENU CHÍNH:

-- TradeScamUI Compact Full - Animated Notifications Centered
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TradeScamUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game:GetService("CoreGui")


local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 230)
main.Position = UDim2.new(0.5, -140, 0.5, -115)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Active = true
main.Draggable = true
main.Parent = gui

-- Logo bật tắt

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
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🦝 GAG TRADE SCAM 🌶️"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local subtitle = Instance.new("TextLabel", main)
subtitle.Size = UDim2.new(1, 0, 0, 15)
subtitle.Position = UDim2.new(0, 0, 0, 32)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Made by MozilOnTop"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.TextColor3 = Color3.fromRGB(160, 160, 160)

local dropdownBtn = Instance.new("TextButton", main)
dropdownBtn.Size = UDim2.new(0.9, 0, 0, 35)
dropdownBtn.Position = UDim2.new(0.5, 0, 0, 55)
dropdownBtn.AnchorPoint = Vector2.new(0.5, 0)
dropdownBtn.Text = "Select Player"
dropdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.TextSize = 14
Instance.new("UICorner", dropdownBtn).CornerRadius = UDim.new(0, 6)

local dropdownAvatar = Instance.new("ImageLabel", dropdownBtn)
dropdownAvatar.Size = UDim2.new(0, 24, 0, 24)
dropdownAvatar.Position = UDim2.new(0, 5, 0.5, -12)
dropdownAvatar.BackgroundTransparency = 1
dropdownAvatar.Image = ""
dropdownAvatar.Visible = false

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
Instance.new("UIListLayout", listFrame).Padding = UDim.new(0, 4)

local function createToggleFrame(text, y)
	local frame = Instance.new("Frame", main)
	frame.Size = UDim2.new(0.9, 0, 0, 30)
	frame.Position = UDim2.new(0.5, 0, 0, y)
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, -55, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggle = Instance.new("TextButton", frame)
	toggle.Size = UDim2.new(0, 40, 0, 20)
	toggle.Position = UDim2.new(1, -45, 0.5, -10)
	toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
	toggle.Text = ""
	toggle.BorderSizePixel = 0
	Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)

	local dot = Instance.new("Frame", toggle)
	dot.Size = UDim2.new(0, 16, 0, 16)
	dot.Position = UDim2.new(0, 2, 0.5, -8)
	dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dot.BorderSizePixel = 0
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

	local toggled = false
	toggle.MouseButton1Click:Connect(function()
		toggled = not toggled
		TweenService:Create(toggle, TweenInfo.new(0.2), {
			BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 65)
		}):Play()
		TweenService:Create(dot, TweenInfo.new(0.2), {
			Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		}):Play()

		showNotification(text .. (toggled and " Enabled!" or " Disabled!"),
			toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 70, 70))
	end)

	return frame
end

local antiDetected = createToggleFrame("Freeze Trade", 100)
local freezeFrame = createToggleFrame("Anti Detected", 140)
local bypassFrame = createToggleFrame("Trade Failed Bypass", 180)

local warning = Instance.new("TextLabel", main)
warning.Text = "⚠️ Only Use When In Trade ‼️"
warning.Font = Enum.Font.GothamBold
warning.TextColor3 = Color3.fromRGB(255, 255, 255)
warning.TextStrokeTransparency = 0.5
warning.TextSize = 13
warning.BackgroundTransparency = 1
warning.Size = UDim2.new(1, 0, 0, 20)
warning.Position = UDim2.new(0.5, 0, 0, 210)
warning.AnchorPoint = Vector2.new(0.5, 0)

-- Dropdown logic giữ nguyên
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
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
			btn.Text = "            " .. plr.Name
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 13
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.TextXAlignment = Enum.TextXAlignment.Left
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

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
				TweenService:Create(antiDetected, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 100)}):Play()
				TweenService:Create(freezeFrame, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 140)}):Play()
				TweenService:Create(bypassFrame, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 180)}):Play()
				TweenService:Create(warning, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 210)}):Play()
			end)
		end
	end
	listFrame.CanvasSize = UDim2.new(0, 0, 0, count * 34)
end

dropdownBtn.MouseButton1Click:Connect(function()
	dropdownOpen = not dropdownOpen
	if dropdownOpen then
		refreshPlayers()
		listFrame.Visible = true
		listFrame:TweenSize(UDim2.new(0.9, 0, 0, 100), "Out", "Sine", 0.25, true)
		main:TweenSize(UDim2.new(0, 280, 0, 340), "Out", "Sine", 0.25, true)
		TweenService:Create(antiDetected, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 200)}):Play()
		TweenService:Create(freezeFrame, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 240)}):Play()
		TweenService:Create(bypassFrame, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 280)}):Play()
		TweenService:Create(warning, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 310)}):Play()
	else
		listFrame:TweenSize(UDim2.new(0.9, 0, 0, 0), "Out", "Sine", 0.25, true)
		task.delay(0.25, function() listFrame.Visible = false end)
		main:TweenSize(UDim2.new(0, 280, 0, 240), "Out", "Sine", 0.25, true)
		TweenService:Create(antiDetected, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 100)}):Play()
		TweenService:Create(freezeFrame, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 140)}):Play()
		TweenService:Create(bypassFrame, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 180)}):Play()
		TweenService:Create(warning, TweenInfo.new(0.25), {Position = UDim2.new(0.5, 0, 0, 210)}):Play()
	end
end)
