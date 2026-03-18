-- External C# core integration example
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local BASE_URL = "http://127.0.0.1:5000"

local function safeRequest(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("External core request failed:", result)
    end
    return success, result
end

local function requestPlayerStats(player)
    local url = BASE_URL .. "/player/" .. HttpService:UrlEncode(player.UserId)
    local success, response = safeRequest(HttpService.GetAsync, HttpService, url)
    if not success then return end
    local data = HttpService:JSONDecode(response)
    print("ExternalCore stats for", player.Name, data)
    return data
end

local function addPlayerScore(player, add)
    local url = BASE_URL .. "/player/" .. HttpService:UrlEncode(player.UserId) .. "/score"
    local body = HttpService:JSONEncode({ Add = add })
    local success, response = safeRequest(HttpService.PostAsync, HttpService, url, body, Enum.HttpContentType.ApplicationJson)
    if not success then return end
    local data = HttpService:JSONDecode(response)
    print("Updated external score for", player.Name, data)
    return data
end

local function matchmake(player)
    local url = BASE_URL .. "/matchmake"
    local body = HttpService:JSONEncode({ PlayerId = tostring(player.UserId) })
    local success, response = safeRequest(HttpService.PostAsync, HttpService, url, body, Enum.HttpContentType.ApplicationJson)
    if not success then return end
    local data = HttpService:JSONDecode(response)
    print("Matchmade", player.Name, data.matchId)
    return data
end

Players.PlayerAdded:Connect(function(player)
    matchmake(player)
    requestPlayerStats(player)
    addPlayerScore(player, 5)
end)
