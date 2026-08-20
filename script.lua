local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/c4f2b279544d686fba3ae6547d0e290a29fad133e3799d30f70dd16f60c3a980")

local function submitCode(code)
    pcall(function()
        Remote:FireServer(code)
    end)
end

-- Automatically triggers when a new message is received in chat
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.OnIncomingMessage = function(msg)
        if msg.TextSource then
            local cleanCode = string.match(msg.Text, "%w+")
            if cleanCode and #cleanCode >= 3 then
                submitCode(cleanCode)
            end
        end
    end
else
    ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering").OnClientEvent:Connect(function(msgData)
        local cleanCode = string.match(msgData.Message, "%w+")
        if cleanCode and #cleanCode >= 3 then
            submitCode(cleanCode)
        end
    end)
end


