local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = PlayerGui:WaitForChild("CarControlsInfoAndMobileButtons")
local ControlFrame = ScreenGui:WaitForChild("ControlFrame")

-- Main GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "CustomButtonCreator"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

-- Creator Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(250, 120)
Frame.Position = UDim2.new(0.5, -125, 0.5, -60)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.Parent = Frame

-- Dragging
local UIS = game:GetService("UserInputService")

local Dragging = false
local DragStart
local StartPos

Frame.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = true
		DragStart = Input.Position
		StartPos = Frame.Position

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				Dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(Input)
	if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
		local Delta = Input.Position - DragStart

		Frame.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + Delta.Y
		)
	end
end)

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 35)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.PlaceholderText = "Button Name"
TextBox.Text = ""
TextBox.Parent = Frame

local BoxCorner = Instance.new("UICorner")
BoxCorner.Parent = TextBox

-- Create Button
local CreateButton = Instance.new("TextButton")
CreateButton.Size = UDim2.new(1, -20, 0, 35)
CreateButton.Position = UDim2.new(0, 10, 0, 55)
CreateButton.Text = "Create"
CreateButton.Parent = Frame

local CreateCorner = Instance.new("UICorner")
CreateCorner.Parent = CreateButton

-- Container for created buttons
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.fromOffset(200, 300)
ButtonHolder.Position = UDim2.new(1, -220, 0.5, -150)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = Gui

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.Parent = ButtonHolder

-- Create new buttons
CreateButton.MouseButton1Click:Connect(function()
	local Name = TextBox.Text

	if Name == "" then
		return
	end

	local NewButton = Instance.new("TextButton")
	NewButton.Size = UDim2.new(1, 0, 0, 40)
	NewButton.Text = Name
	NewButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	NewButton.TextColor3 = Color3.new(1, 1, 1)
	NewButton.Parent = ButtonHolder

	local Corner = Instance.new("UICorner")
	Corner.Parent = NewButton

	TextBox.Text = ""
end)

-- Visibility handling
local function UpdateVisibility()
	Frame.Visible = ControlFrame.Visible
	ButtonHolder.Visible = ControlFrame.Visible
end

UpdateVisibility()

ControlFrame:GetPropertyChangedSignal("Visible"):Connect(UpdateVisibility)
