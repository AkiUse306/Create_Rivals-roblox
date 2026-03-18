local AntiCheat = {}
local MAX_DAMAGE = 250
local MAX_FIRE_RATE = 0.08

function AntiCheat:ValidateDamage(player, damage)
    if damage > MAX_DAMAGE then
        player:Kick("Exploit detected: invalid damage")
        return false
    end
    return true
end

function AntiCheat:ValidateFireRate(player, fireRate)
    if fireRate < MAX_FIRE_RATE then
        player:Kick("Exploit detected: fire rate too high")
        return false
    end
    return true
end

return AntiCheat
