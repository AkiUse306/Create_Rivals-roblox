local CombatSystem = {}

local MAX_DAMAGE = 400

function CombatSystem:GetDamageFromWeapon(weaponName, player)
    local base = 15
    if weaponName == "SMG" then
        base = 10
    elseif weaponName == "Rifle" then
        base = 28
    end
    local multiplier = 1
    if player and player.Data and player.Data.Multipliers then
        multiplier = player.Data.Multipliers.Damage or 1
    end
    return base * multiplier
end

function CombatSystem:FireWeapon(player, origin, direction)
    local ray = Ray.new(origin, direction.Unit * 500)
    local ignore = {player.Character}
    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignore)
    if hit and hit.Parent then
        local humanoid = hit.Parent:FindFirstChild("Humanoid")
        if humanoid then
            return humanoid, position
        end
    end
    return nil, nil
end

function CombatSystem:ValidateDamage(player, damage)
    if not player or type(damage) ~= "number" then
        return false
    end
    if damage <= 0 or damage > MAX_DAMAGE then
        return false
    end
    return true
end

function CombatSystem:ApplyDamage(attacker, targetHumanoid, damage)
    if not targetHumanoid or targetHumanoid.Health <= 0 then
        return false
    end
    targetHumanoid:TakeDamage(damage)
    if attacker and attacker.Data and attacker.Data.Session then
        attacker.Data.Session.DamageDone = attacker.Data.Session.DamageDone + damage
    end
    if targetHumanoid.Health <= 0 and attacker then
        self:OnPlayerKill(attacker)
    end
    return true
end

function CombatSystem:OnPlayerKill(player)
    if not player or not player.Data then return end
    local economy = require(game.ReplicatedStorage.Modules.EconomySystem)
    local amount = economy:GiveKillReward(player)
    if player.Data.Session then
        player.Data.Session.Kills = player.Data.Session.Kills + 1
    end
    return amount
end

return CombatSystem
