local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local GameManager = {
    HubPlaceId = 0,
    ArenaPlaceId = 0,
}

function GameManager:SetPlaceIds(hubPlaceId, arenaPlaceId)
    self.HubPlaceId = hubPlaceId
    self.ArenaPlaceId = arenaPlaceId
end

function GameManager:TeleportToArena(player)
    if self.ArenaPlaceId == 0 then
        warn("ArenaPlaceId not configured")
        return
    end
    pcall(function()
        TeleportService:Teleport(self.ArenaPlaceId, player)
    end)
end

function GameManager:TeleportToHub(player)
    if self.HubPlaceId == 0 then
        warn("HubPlaceId not configured")
        return
    end
    pcall(function()
        TeleportService:Teleport(self.HubPlaceId, player)
    end)
end

return GameManager
