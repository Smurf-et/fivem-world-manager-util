local WorldManager = {}
local worlds = {
    ['1v1'] = { -- just a example
        worldBucket = 5,
        worldPlayers = {
            playersAtWorld = 0,
            maxPlayers = 2,
        },
    }
}
local playersWorld = {}

function WorldManager.placePlayerInWorld(playerSteam, gameModeName)
    if worlds[gameModeName] then
        takeOffPlayerFromCurrentWorld(playerSteam)
        if worlds[gameModeName].worldPlayers.playersAtWorld < worlds[gameModeName].worldPlayers.maxPlayers then
            SetPlayerRoutingBucket(getSourceBySteam(playerSteam), worlds[gameModeName].worldBucket)
            playersWorld[playerSteam] = gameModeName
            worlds[gameModeName].worldPlayers.playersAtWorld = parseInt(worlds[gameModeName].worldPlayers.playersAtWorld) + 1 
            return true
        end
    end
    return false
end

function WorldManager.takeOffPlayerFromCurrentWorld(playerSteam)
    if playersWorld[playerSteam] then
        worlds[playersWorld[playerSteam]].worldPlayers.playersAtWorld = parseInt(worlds[playersWorld[playerSteam]].worldPlayers.playersAtWorld) - 1
        playersWorld[playerSteam] = nil
    end
end

return WorldManager