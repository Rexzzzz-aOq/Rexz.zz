-- Rexz Lock Mobile Camlock Script

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Target = nil

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Create Lock Button
local LockButton = Instance.new("TextButton")
LockButton.Parent = ScreenGui
LockButton.Size = UDim2.new(0, 150, 0, 50)
LockButton.Position = UDim2.new(0.5, -75, 0.8, 0)
LockButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LockButton.TextScaled = true
LockButton.Text = "Rexz Lock"
LockButton.BorderSizePixel = 2
LockButton.BorderColor3 = Color3.fromRGB(255, 0, 0)

-- Create Locked Label
local LockedLabel = Instance.new("TextLabel")
LockedLabel.Parent = ScreenGui
LockedLabel.Size = UDim2.new(0, 300, 0, 50)
LockedLabel.Position = UDim2.new(0.5, -150, 0.7, 0)
LockedLabel.BackgroundTransparency = 1
LockedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LockedLabel.TextScaled = true
LockedLabel.Text = "No Target Locked"

-- Find closest player function
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (Camera.CFrame.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

-- Button Function
LockButton.MouseButton1Click:Connect(function()
    if Target then
        Target = nil
        LockedLabel.Text = "No Target Locked"
        LockButton.Text = "Rexz Lock"
    else
        local player = GetClosestPlayer()
        if player then
            Target = player
            LockedLabel.Text = "Locked onto: " .. player.Name
            LockButton.Text = "Unlock"
        else
            LockedLabel.Text = "No players found!"
        end
    end
end)

-- Camera follow update
RunService.RenderStepped:Connect(function()
    if Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
    end
end)
