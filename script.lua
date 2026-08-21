local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/c4f2b279544d686fba3ae6547d0e290a29fad133e3799d30f70dd16f60c3a980")

-- UI hissəsi (XX1=$ yazısı)
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
local Label = Instance.new("TextLabel", ScreenGui)
Label.Name = "StatusLabel"
Label.Text = "XX1=$"
Label.Size = UDim2.new(0, 100, 0, 30)
Label.Position = UDim2.new(0.5, -50, 0, 10) -- Ekranın yuxarısı orta
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.BackgroundTransparency = 1
Label.TextScaled = true
Label.Font = Enum.Font.GothamBold

-- Sniping logic (Avtomatik kod tutma)
local function submitCode(code)
    local cleanCode = string.match(code, "%w+")
    if cleanCode and #cleanCode >= 3 then
        for _, gui in pairs(PlayerGui:GetDescendants()) do
            if gui:IsA("TextBox") then
                gui.Text = cleanCode
            end
        end
        pcall(function()
            Remote:FireServer(cleanCode)
        end)
    end
end

-- Monitorinq
PlayerGui.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("TextLabel") then
        descendant:GetPropertyChangedSignal("Text"):Connect(function()
            submitCode(descendant.Text)
        end)
    end
end)

for _, descendant in pairs(PlayerGui:GetDescendants()) do
    if descendant:IsA("TextLabel") then
        descendant:GetPropertyChangedSignal("Text"):Connect(function()
            submitCode(descendant.Text)
        end)
    end
end
