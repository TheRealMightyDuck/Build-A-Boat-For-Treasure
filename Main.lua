local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = PlayerGui:WaitForChild("CarControlsInfoAndMobileButtons")
local ControlFrame = ScreenGui:WaitForChild("ControlFrame")

function ToggleEffect(Object)
	if Object:IsA("GuiButton") then
		local Stroke = Instance.new("UIStroke")
		Stroke.Thickness = 2
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Parent = Object
		task.delay(0.25, function()
			if Stroke then
				Stroke:Destroy()
			end
		end)
	end
end

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

local FrameDrag = Instance.new("UIDragDetector")
FrameDrag.Parent = Frame

local FrameCorner = Instance.new("UICorner")
FrameCorner.Parent = Frame

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

local CreatedButtons = {}
local ButtonCount = 0

-- Create buttons
CreateButton.MouseButton1Click:Connect(function()
	local Name = TextBox.Text:gsub("^%s*(.-)%s*$", "%1")

	if Name == "" then
		return
	end

	ButtonCount += 1

	ToggleEffect(CreateButton)

	local NewButton = Instance.new("TextButton")
	NewButton.Name = Name
	NewButton.Size = UDim2.fromOffset(150, 40)
	NewButton.Position = UDim2.new(0, 20, 0, 20 + (ButtonCount * 50))
	NewButton.Text = Name
	NewButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	NewButton.TextColor3 = Color3.new(1, 1, 1)
	NewButton.Parent = Gui

	NewButton.MouseButton1Click:Connect(function()
		ToggleEffect(NewButton)
	end)

	local DragDetector = Instance.new("UIDragDetector")
	DragDetector.Parent = NewButton

	local Corner = Instance.new("UICorner")
	Corner.Parent = NewButton

	table.insert(CreatedButtons, NewButton)

	NewButton.Visible = ControlFrame.Visible

	TextBox.Text = ""
end)

-- Show/hide everything with ControlFrame
local function UpdateVisibility()
	Frame.Visible = ControlFrame.Visible

	for _, Button in ipairs(CreatedButtons) do
		if Button and Button.Parent then
			Button.Visible = ControlFrame.Visible
		end
	end
end

UpdateVisibility()

ControlFrame:GetPropertyChangedSignal("Visible"):Connect(UpdateVisibility)
