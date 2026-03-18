local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DealDamage = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DealDamage")
local CombatSystem = require(ReplicatedStorage.Modules.CombatSystem)
local AntiCheat = require(script.Parent.AntiCheat)

local CombatHandler = {}

DealDamage.OnServerEvent:Connect(function(player, damage, targetCharacter)
    if not AntiCheat:ValidateDamage(player, damage) then
        return
    end

    if not targetCharacter or not targetCharacter:FindFirstChild("Humanoid") then
        return
    end

    local humanoid = targetCharacter:FindFirstChild("Humanoid")
    CombatSystem:ApplyDamage(player, humanoid, damage)
end)

return CombatHandler
