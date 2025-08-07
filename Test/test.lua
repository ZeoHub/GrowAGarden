local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyUI"
screenGui.Parent = playerGui

local bgImage = Instance.new("ImageLabel")
bgImage.Name = "Background"
bgImage.Parent = screenGui
bgImage.Size = UDim2.new(0, 200, 0, 150)
bgImage.Position = UDim2.new(0.5, -100, 0.5, -75)
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
header.Text = "ANTI-FREEZER (ANTI-SCAM)"
header.TextColor3 = Color3.fromRGB(210, 180, 140)
header.Font = Enum.Font.GothamBold
header.TextScaled = true
header.TextStrokeTransparency = 0.5
header.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

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
		local goalColor = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
		TweenService:Create(toggleThumb, TweenInfo.new(0.2), { Position = goalPos }):Play()
		TweenService:Create(toggleTrack, TweenInfo.new(0.2), { BackgroundColor3 = goalColor }):Play()
		print(name .. " is", state and "ON" or "OFF")
	end

	toggleTrack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			toggle()
		end
	end)
end

createToggle("FreezeTrade", "ANTI-FREEZE TRADE", 55)
createToggle("LockInventory", "ANTI-AUTO ACCEPT", 95)

local helpButton = Instance.new("TextButton")
helpButton.Name = "HelpButton"
helpButton.Parent = bgImage
helpButton.Size = UDim2.new(0, 25, 0, 25)
helpButton.Position = UDim2.new(0.87, 0, 0, 130)
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
instructionText.Text = "- FREEZE TRADE Freezes the victims screen.\n- AUTO ACCEPT I mean, I need to explain this?.\n- Press '?' again to hide this."
instructionText.TextColor3 = Color3.fromRGB(210, 180, 140)
instructionText.Font = Enum.Font.Gotham
instructionText.TextWrapped = true
instructionText.TextScaled = true
instructionText.TextYAlignment = Enum.TextYAlignment.Top
instructionText.TextColor3 = Color3.fromRGB(255, 255, 255) -- white text
instructionText.TextStrokeTransparency = 0.2               -- make stroke visible
instructionText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- black stroke

local helpVisible = false
helpButton.MouseButton1Click:Connect(function()
	helpVisible = not helpVisible
	instructionFrame.Visible = helpVisible
end)

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
