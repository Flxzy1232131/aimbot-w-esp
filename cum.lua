local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local FOV = 100
local MaxDistance = 1000

local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.Color = Color3.new(1, 1, 1)
Circle.Filled = false
Circle.Transparency = 1
Circle.NumSides = 100
Circle.Visible = true

local IsActive = false
local AimbotKey = Enum.KeyCode.E

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

local AimbotFrame = Instance.new("Frame")
AimbotFrame.Size = UDim2.new(0, 250, 0, 250)  -- Increased height for new button
AimbotFrame.Position = UDim2.new(0.5, -125, 0, 20)
AimbotFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AimbotFrame.BorderSizePixel = 0
AimbotFrame.ClipsDescendants = true
AimbotFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = AimbotFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = AimbotFrame

local TitleBarUICorner = Instance.new("UICorner")
TitleBarUICorner.CornerRadius = UDim.new(0, 10)
TitleBarUICorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Aimbot Settings"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.9, 0, 0, 35)
KeyInput.Position = UDim2.new(0.05, 0, 0.2, 0)
KeyInput.Text = "E"
KeyInput.PlaceholderText = "Aimbot Key"
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.Parent = AimbotFrame

local KeyUICorner = Instance.new("UICorner")
KeyUICorner.CornerRadius = UDim.new(0, 5)
KeyUICorner.Parent = KeyInput

local ColorInput = Instance.new("TextBox")
ColorInput.Size = UDim2.new(0.9, 0, 0, 35)
ColorInput.Position = UDim2.new(0.05, 0, 0.35, 0)
ColorInput.Text = "White"
ColorInput.PlaceholderText = "FOV Color (e.g. Red, Blue, Green)"
ColorInput.TextColor3 = Color3.new(1, 1, 1)
ColorInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ColorInput.Font = Enum.Font.Gotham
ColorInput.TextSize = 14
ColorInput.Parent = AimbotFrame

local ColorUICorner = Instance.new("UICorner")
ColorUICorner.CornerRadius = UDim.new(0, 5)
ColorUICorner.Parent = ColorInput

local FOVSlider = Instance.new("Frame")
FOVSlider.Size = UDim2.new(0.9, 0, 0, 35)
FOVSlider.Position = UDim2.new(0.05, 0, 0.5, 0)
FOVSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FOVSlider.Parent = AimbotFrame

local FOVSliderUICorner = Instance.new("UICorner")
FOVSliderUICorner.CornerRadius = UDim.new(0, 5)
FOVSliderUICorner.Parent = FOVSlider

local FOVSliderFill = Instance.new("Frame")
FOVSliderFill.Size = UDim2.new(FOV / 200, 0, 1, 0)
FOVSliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
FOVSliderFill.Parent = FOVSlider

local FOVSliderFillUICorner = Instance.new("UICorner")
FOVSliderFillUICorner.CornerRadius = UDim.new(0, 5)
FOVSliderFillUICorner.Parent = FOVSliderFill

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(1, 0, 1, 0)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV: " .. FOV
FOVLabel.TextColor3 = Color3.new(1, 1, 1)
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextSize = 14
FOVLabel.Parent = FOVSlider

-- New Fullbright Button
local FullbrightButton = Instance.new("TextButton")
FullbrightButton.Size = UDim2.new(0.9, 0, 0, 35)
FullbrightButton.Position = UDim2.new(0.05, 0, 0.65, 0)
FullbrightButton.Text = "Toggle Fullbright"
FullbrightButton.TextColor3 = Color3.new(1, 1, 1)
FullbrightButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FullbrightButton.Font = Enum.Font.Gotham
FullbrightButton.TextSize = 14
FullbrightButton.Parent = AimbotFrame

local FullbrightUICorner = Instance.new("UICorner")
FullbrightUICorner.CornerRadius = UDim.new(0, 5)
FullbrightUICorner.Parent = FullbrightButton

local TargetInfoFrame = Instance.new("Frame")
TargetInfoFrame.Size = UDim2.new(0, 200, 0, 50)
TargetInfoFrame.Position = UDim2.new(1, -220, 1, -70)
TargetInfoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TargetInfoFrame.BorderSizePixel = 0
TargetInfoFrame.Parent = ScreenGui

local TargetInfoUICorner = Instance.new("UICorner")
TargetInfoUICorner.CornerRadius = UDim.new(0, 10)
TargetInfoUICorner.Parent = TargetInfoFrame

local TargetInfoLabel = Instance.new("TextLabel")
TargetInfoLabel.Size = UDim2.new(1, -20, 1, 0)
TargetInfoLabel.Position = UDim2.new(0, 10, 0, 0)
TargetInfoLabel.Text = "Target: None"
TargetInfoLabel.TextColor3 = Color3.new(1, 1, 1)
TargetInfoLabel.Font = Enum.Font.GothamBold
TargetInfoLabel.TextSize = 16
TargetInfoLabel.BackgroundTransparency = 1
TargetInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetInfoLabel.Parent = TargetInfoFrame

local function UpdateColor(colorName)
    local color = Color3.fromRGB(255, 255, 255)

    if colorName:lower() == "red" then
        color = Color3.fromRGB(255, 0, 0)
    elseif colorName:lower() == "green" then
        color = Color3.fromRGB(0, 255, 0)
    elseif colorName:lower() == "blue" then
        color = Color3.fromRGB(0, 0, 255)
    elseif colorName:lower() == "yellow" then
        color = Color3.fromRGB(255, 255, 0)
    elseif colorName:lower() == "purple" then
        color = Color3.fromRGB(128, 0, 128)
    elseif colorName:lower() == "orange" then
        color = Color3.fromRGB(255, 165, 0)
    end

    Circle.Color = color
    ColorInput.TextColor3 = color
end

ColorInput.FocusLost:Connect(function()
    UpdateColor(ColorInput.Text)
end)

local function GetClosestPlayerInFOV()
    local ClosestPlayer = nil
    local ShortestDistance = math.huge

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
            local ScreenPosition, OnScreen = Camera:WorldToScreenPoint(Player.Character.HumanoidRootPart.Position)
            local Distance = (Vector2.new(ScreenPosition.X, ScreenPosition.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude

            if OnScreen and Distance <= FOV and Distance < ShortestDistance then
                ClosestPlayer = Player
                ShortestDistance = Distance
            end
        end
    end

    return ClosestPlayer
end

-- ESP Functions
local function CreateHighlight(player)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 0, 0)
    highlight.OutlineTransparency = 0
    highlight.Parent = player.Character
    return highlight
end

local function CreateBillboardGui(player)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(4, 0, 5, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = player.Character.Head

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboardGui

    local boxOutline = Instance.new("Frame")
    boxOutline.Size = UDim2.new(1, 0, 1, 0)
    boxOutline.BorderSizePixel = 3
    boxOutline.BorderColor3 = Color3.new(1, 0, 0)
    boxOutline.BackgroundTransparency = 1
    boxOutline.Parent = frame

    return billboardGui
end

local EspEnabled = true
local EspConnections = {}
local BoneEsp = {}

local function CreatePlayerEsp(player)
    local esp = {
        Highlight = CreateHighlight(player),
        BillboardGui = CreateBillboardGui(player)
    }

    BoneEsp[player] = esp

    local function UpdateEsp()
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
            esp.Highlight.Enabled = false
            esp.BillboardGui.Enabled = false
            return
        end

        esp.Highlight.Enabled = true
        esp.BillboardGui.Enabled = true
    end

    EspConnections[player] = RunService.RenderStepped:Connect(UpdateEsp)
end

local function RemovePlayerEsp(player)
    if EspConnections[player] then
        EspConnections[player]:Disconnect()
        EspConnections[player] = nil
    end
    if BoneEsp[player] then
        for _, obj in pairs(BoneEsp[player]) do
            obj:Destroy()
        end
        BoneEsp[player] = nil
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreatePlayerEsp(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        CreatePlayerEsp(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    RemovePlayerEsp(player)
end)

-- Fullbright
local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd
local OriginalGlobalShadows = Lighting.GlobalShadows
local OriginalOutdoorAmbient = Lighting.OutdoorAmbient

local FullbrightEnabled = false

local function SetFullbright(enable)
    if enable then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        Lighting.Brightness = OriginalBrightness
        Lighting.ClockTime = OriginalClockTime
        Lighting.FogEnd = OriginalFogEnd
        Lighting.GlobalShadows = OriginalGlobalShadows
        Lighting.OutdoorAmbient = OriginalOutdoorAmbient
    end
end

FullbrightButton.MouseButton1Click:Connect(function()
    FullbrightEnabled = not FullbrightEnabled
    SetFullbright(FullbrightEnabled)
    FullbrightButton.BackgroundColor3 = FullbrightEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
end)

RunService.RenderStepped:Connect(function()
    Circle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    Circle.Radius = FOV

    if IsActive then
        local Target = GetClosestPlayerInFOV()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
            TargetInfoLabel.Text = "Target: " .. Target.Name
        else
            TargetInfoLabel.Text = "Target: None"
        end
    else
        TargetInfoLabel.Text = "Target: None"
    end
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == AimbotKey then
        IsActive = not IsActive
        local goal = {BackgroundColor3 = IsActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)}
        local tween = TweenService:Create(KeyInput, TweenInfo.new(0.3), goal)
        tween:Play()
    end
end)

KeyInput.FocusLost:Connect(function()
    local newKey = Enum.KeyCode[KeyInput.Text:upper()]
    if newKey then
        AimbotKey = newKey
    else
        KeyInput.Text = AimbotKey.Name
    end
end)

local function UpdateFOV(input)
    local relativeX = math.clamp((input.Position.X - FOVSlider.AbsolutePosition.X) / FOVSlider.AbsoluteSize.X, 0, 1)
    FOV = math.floor(relativeX * 200)
    FOVSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
    FOVLabel.Text = "FOV: " .. FOV
    Circle.Radius = FOV
end

FOVSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        UpdateFOV(input)
        local connection
        connection = UserInputService.InputChanged:Connect(function(changedInput)
            if changedInput.UserInputType == Enum.UserInputType.MouseMovement then
                UpdateFOV(changedInput)
            end
        end)
        UserInputService.InputEnded:Connect(function(endedInput)
            if endedInput.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end
end)

local function AddDragging(frame, dragpart)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(frame, TweenInfo.new(0.1), {Position = newPosition}):Play()
    end

    dragpart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragpart.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

AddDragging(AimbotFrame, TitleBar)

-- Return a function to clean up the script when it's unloaded
return function()
    ScreenGui:Destroy()
    Circle:Remove()
    for _, connection in pairs(EspConnections) do
        connection:Disconnect()
    end
    for _, esp in pairs(BoneEsp) do
        for _, obj in pairs(esp) do
            obj:Destroy()
        end
    end
    SetFullbright(false)
end
