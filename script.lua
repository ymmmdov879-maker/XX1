local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local isSniperActive = false
local TARGET_EVENT_NAME = "RedeemCode"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XX1_ModMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "XX1 HILESIDI ZAS"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "SNIPER: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 15
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

local function redeemCode(code)
    local event = ReplicatedStorage:FindFirstChild(TARGET_EVENT_NAME, true)
    if event and event:IsA("RemoteEvent") then
        event:FireServer(code)
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    isSniperActive = not isSniperActive
    if isSniperActive then
        ToggleBtn.Text = "SNIPER: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "SNIPER: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

TextChatService.OnIncomingMessage = function(message)
    if isSniperActive and message.TextSource then
        local content = message.Text
        if string.find(string.lower(content), "code") then
            local code = string.match(content, "%w+%d+") or string.match(content, ":%s*(%w+)")
            if code then
                redeemCode(code)
            end
        end
    end
end

