local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local isSniperActive = false

-- ScreenGUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XX1_ModMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Menyu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Başlıq
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "XX1 HILESIDI ZAS"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Düymə
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "SNIPER: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 15
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

-- Steal a Brainrot üçün xüsusi kod göndərmə funksiyası
local function sendBrainrotCode(code)
    -- 1. Birbaşa ekrandakı TextBox-a yazır və düyməyə basır
    for _, v in pairs(PlayerGui:GetDescendants()) do
        if v:IsA("TextBox") then
            v.Text = code
            local parent = v.Parent
            if parent then
                for _, btn in pairs(parent:GetDescendants()) do
                    if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                        pcall(function()
                            firesignal(btn.MouseButton1Click)
                        end)
                    end
                end
            end
        end
    end

    -- 2. Əgər oyun RemoteEvent istifadə edirsə, birbaşa serverə ötürür
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = string.lower(obj.Name)
            if string.find(name, "code") or string.find(name, "redeem") or string.find(name, "claim") then
                pcall(function()
                    if obj:IsA("RemoteEvent") then
                        obj:FireServer(code)
                    else
                        obj:InvokeServer(code)
                    end
                end)
            end
        end
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

local function onMessage(content)
    if isSniperActive then
        local cleanCode = string.match(content, "%w+")
        if cleanCode and #cleanCode >= 3 then
            sendBrainrotCode(cleanCode)
        end
    end
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.OnIncomingMessage = function(message)
        if message.TextSource then
            onMessage(message.Text)
        end
    end
else
    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering").OnClientEvent:Connect(function(messageData)
        onMessage(messageData.Message)
    end)
end
