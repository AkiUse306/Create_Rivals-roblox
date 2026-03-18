local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ui = player:WaitForChild("PlayerGui"):WaitForChild("MainUI")

local BuyItemRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("BuyItem")
local OpenEggRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("OpenEgg")

local MainUI = {}

function MainUI:Init()
    local shop = ui:FindFirstChild("ShopFrame")
    local openEgg = ui:FindFirstChild("EggOpeningUI")
    if shop then
        local buyButton = shop:FindFirstChild("BuyWeaponButton")
        if buyButton then
            buyButton.MouseButton1Click:Connect(function()
                BuyItemRemote:FireServer("Primary", "Pistol")
            end)
        end
    end
    if openEgg then
        local rollButton = openEgg:FindFirstChild("RollButton")
        if rollButton then
            rollButton.MouseButton1Click:Connect(function()
                OpenEggRemote:FireServer()
            end)
        end
    end

    OpenEggRemote.OnClientEvent:Connect(function(petName, rank)
        warn("Egg result:", petName, rank)
    end)

    BuyItemRemote.OnClientEvent:Connect(function(success, msg)
        if success then
            warn("Bought item:", msg)
        else
            warn("Buy failed:", msg)
        end
    end)
end

MainUI:Init()

return MainUI
