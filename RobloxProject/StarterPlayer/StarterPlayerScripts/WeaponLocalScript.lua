local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local DealDamageRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("DealDamage")

local function fireWeapon(damage)
    local target = mouse.Target
    if target and target.Parent and target.Parent:FindFirstChild("Humanoid") then
        DealDamageRemote:FireServer(damage, target.Parent)
    end
end

local function onToolActivated(tool)
    local data = player and player:FindFirstChild("Data") and player.Data
    local damage = 20
    if data and data.Multipliers then
        damage = damage * data.Multipliers.Damage
    end
    fireWeapon(damage)
end

local function setupTool(tool)
    if tool:IsA("Tool") then
        tool.Activated:Connect(function()
            onToolActivated(tool)
        end)
    end
end

player.CharacterAdded:Connect(function(character)
    local backpack = player:WaitForChild("Backpack")
    for _, tool in ipairs(backpack:GetChildren()) do
        setupTool(tool)
    end
    backpack.ChildAdded:Connect(setupTool)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.R then
        print("Reloading weapon...")
    end
end)
