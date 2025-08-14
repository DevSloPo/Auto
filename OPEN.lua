local OpenUI = Instance.new("ScreenGui")
local ToggleButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local UIGradient = Instance.new("UIGradient")
OpenUI.Name = "CustomToggleUI"
OpenUI.Parent = game.CoreGui
OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = OpenUI
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.Position = UDim2.new(0.02, 0, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = "rbxassetid://87900384857449"
ToggleButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.ScaleType = Enum.ScaleType.Fit
ToggleButton.Draggable = true
UICorner.CornerRadius = UDim.new(0, 7)
UICorner.Parent = ToggleButton
UIStroke.Thickness = 1
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = ToggleButton
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromHex("FF00FF")),
    ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FFFF")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("800080"))
})
UIGradient.Rotation = 10
UIGradient.Parent = UIStroke
local hoverTransparency = 0.1
ToggleButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        ToggleButton,
        TweenInfo.new(0.2),
        {BackgroundTransparency = hoverTransparency}
    ):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        ToggleButton,
        TweenInfo.new(0.2),
        {BackgroundTransparency = 0.3}
    ):Play()
end)
task.spawn(function()
    local hue = 0
    while true do
        local rainbowColor = Color3.fromHSV(hue, 0.8, 1)
        UIGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, rainbowColor),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((hue + 0.5) % 1, 0.8, 1))
        })
        hue = (hue + 0.005) % 1
        task.wait(0.05)
    end
end)
local isOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    
    if isOpen then
        if game.CoreGui:FindFirstChild("ui") then
            game.CoreGui.ui.Main:TweenSize(
                UDim2.new(0, 560, 0, 319),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.4,
                true
            )
        end
    else
        if game.CoreGui:FindFirstChild("ui") then
            game.CoreGui.ui.Main:TweenSize(
                UDim2.new(0, 0, 0, 0),
                Enum.EasingDirection.In,
                Enum.EasingStyle.Quad,
                0.4,
                true
            )
        end
    end
end)
Window.UIElements.Main:GetPropertyChangedSignal("Visible"):Connect(function()
    isOpen = Window.UIElements.Main.Visible
end)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        isOpen = not isOpen
        if isOpen then
            Window:Open()
        else
            Window:Close()
        end
    end
end)