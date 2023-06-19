local playersInTuning = {}

local function playerExitGarage(player)
    if not isElement(player) then
        return
    end
    if not playersInTuning[player] then
        return
    end
    if player.vehicle then
        player.vehicle.interior = 0
        player.vehicle.dimension = 0
        player.vehicle.engineState = true
    else
        player.dimension = 0
    end
    player.interior = 0
    playersInTuning[player] = nil
    clearPlayerDimension(player)

    triggerClientEvent(player, "operTuningGarage.playerExitGarage", resourceRoot)
    fadeCamera(player, true, 1)
end

addEvent("operTuningGarage.playerExitGarage", true)
addEventHandler("operTuningGarage.playerExitGarage", resourceRoot, function (...)
    fadeCamera(client, false, 1)
    setTimer(playerExitGarage, 1100, 1, client, ...)
end)

--[[
addEvent("operTuningGarage.getServerTime", true)
addEventHandler("operTuningGarage.getServerTime", root, function()
    local TIME = getRealTime()
    triggerClientEvent(source, "operTuningGarage.setServerTime", source, TIME.hour, TIME.minute, getMinuteDuration())
end)
]]

local function playerEnterGarage(player)
    if not isElement(player) or not player.vehicle then
        return
    end
    -- Позиция
    player.vehicle.position = Config.garageVehiclePosition
    player.vehicle.rotation = Config.garageVehicleRotation
    -- Интерьер
    player.interior = Config.garageInterior
    player.vehicle.interior = Config.garageInterior

    local dimension = getDimensionForPlayer(player)
    player.dimension = dimension
    player.vehicle.dimension = dimension

    player.vehicle.velocity = Vector3()
    player.vehicle.turnVelocity = Vector3()
    player.vehicle.engineState = false

    triggerClientEvent(player, "operTuningGarage.playerEnterGarage", resourceRoot, true)
    fadeCamera(player, true, 1)
end

addEvent("operTuningGarage.playerEnterGarage", true)
addEventHandler("operTuningGarage.playerEnterGarage", resourceRoot, function()
	if client.dimension ~= 0 then
        return
    end

    if not client.vehicle or client.vehicle.controller ~= client then
        return
    end

    if not Config.allowedVehicleTypes[client.vehicle.vehicleType] then
        return
    end

    -- Высадить пассажиров
    for seat, player in pairs(client.vehicle.occupants) do
        if player ~= client then
            player.vehicle = nil
        end
    end

    playersInTuning[client] = true
   	fadeCamera(client, false, 1)
    setTimer(playerEnterGarage, 1100, 1, client)
end)

function isPlayerInTuning(player)
    if not isElement(player) then
        return
    end

    return playersInTuning[player]
end
-- Выбор свободного dimension для игрока

local dimensionsOffset = 2000
local usedDimensions = {}

function getDimensionForPlayer(player)
    if not isElement(player) then
        return 0
    end
    local maxPlayers = getMaxPlayers()
    for i = 1, maxPlayers do
        if not isElement(usedDimensions[i]) or usedDimensions[i] == player then
            usedDimensions[i] = player
            return dimensionsOffset + i
        end
    end
end

function clearPlayerDimension(player)
    if not isElement(player) then
        return
    end
    if isElement(usedDimensions[player.dimension - dimensionsOffset]) then
        usedDimensions[player.dimension - dimensionsOffset] = nil
    end
end

addEventHandler("onResourceStop", resourceRoot, function ()
    for i = 1, getMaxPlayers() do
        if isElement(usedDimensions[i]) then
            usedDimensions[i].dimension = 0
            usedDimensions[i].interior = 0
            if usedDimensions[i].vehicle then
                usedDimensions[i].vehicle.dimension = 0
                usedDimensions[i].vehicle.interior = 0
            end
        end
    end
end)

