local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DealDamage = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DealDamage")
local CombatSystem = require(ReplicatedStorage.Modules.CombatSystem)
local AntiCheat = require(script.Parent.AntiCheat)
local GraphicsService = require(script.Parent.GraphicsService)

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
    if humanoid.RootPart then
        GraphicsService:OnHit(humanoid.RootPart.Position)
    end
end)

return CombatHandler
