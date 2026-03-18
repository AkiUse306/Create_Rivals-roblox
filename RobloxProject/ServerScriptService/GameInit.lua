local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(script.DataManager)
local CombatHandler = require(script.CombatHandler)
local EconomyHandler = require(script.EconomyHandler)
local PetHandler = require(script.PetHandler)
local GameManager = require(script.GameManager)

local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
if not remotesFolder then
    remotesFolder = Instance.new("Folder")
    remotesFolder.Name = "Remotes"
    remotesFolder.Parent = ReplicatedStorage
end

local remoteEvents = {"DealDamage", "BuyItem", "OpenEgg", "EquipWeapon", "TeleportToArena", "TeleportToHub"}
for _, name in ipairs(remoteEvents) do
    if not remotesFolder:FindFirstChild(name) then
        local event = Instance.new("RemoteEvent")
        event.Name = name
        event.Parent = remotesFolder
    end
end

-- set default place IDs (update in studio)
GameManager:SetPlaceIds(0, 0)

print("Game server initialized: remotes ready, modules loaded")
