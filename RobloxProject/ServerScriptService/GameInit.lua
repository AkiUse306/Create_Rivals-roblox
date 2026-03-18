local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(script.DataManager)
local RemoteInit = require(script.RemoteInit)
local CombatHandler = require(script.CombatHandler)
local EconomyHandler = require(script.EconomyHandler)
local PetHandler = require(script.PetHandler)
local TeleportHandler = require(script.TeleportHandler)
local GraphicsService = require(script.GraphicsService)
local GameManager = require(script.GameManager)

RemoteInit:CreateRemotes()

-- set default place IDs (update in studio)
GameManager:SetPlaceIds(0, 0)

print("Game server initialized: remotes ready, modules loaded")
