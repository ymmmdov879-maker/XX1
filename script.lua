local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/c4f2b279544d686fba3ae6547d0e290a29fad133e3799d30f70dd16f60c3a980")

-- Function to submit any code directly to the server
local function redeem(code)
    if code and #code > 0 then
        pcall(function()
            Remote:FireServer(code)
        end)
    end
end

-- Auto-fill UI TextBoxes if needed
for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
    if gui:IsA("TextBox") then
        gui:GetPropertyChangedSignal("Text"):Connect(function()
            if #gui.Text >= 3 then
                redeem(gui.Text)
            end
        end)
    end
end
