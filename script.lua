local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/c4f2b279544d686fba3ae6547d0e290a29fad133e3799d30f70dd16f60c3a980")

local function submitCode(code)
    local cleanCode = string.match(code, "%w+")
    if cleanCode and #cleanCode >= 3 then
        -- 1. "Kod Burada..." kutusunun içine kodu yazır
        for _, gui in pairs(PlayerGui:GetDescendants()) do
            if gui:IsA("TextBox") then
                gui.Text = cleanCode
            end
        end
        -- 2. "Gönder" düyməsini gözləmədən anında serverə vurur
        pcall(function()
            Remote:FireServer(cleanCode)
        end)
    end
end

-- Ekranın ortasında/yuxarısında yeni yazı (kod) çıxan kimi tut
PlayerGui.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("TextLabel") then
        submitCode(descendant.Text)
        descendant:GetPropertyChangedSignal("Text"):Connect(function()
            submitCode(descendant.Text)
        end)
    end
end)

-- Ekrandakı mövcut yazıları izlə
for _, descendant in pairs(PlayerGui:GetDescendants()) do
    if descendant:IsA("TextLabel") then
        descendant:GetPropertyChangedSignal("Text"):Connect(function()
            submitCode(descendant.Text)
        end)
    end
end
