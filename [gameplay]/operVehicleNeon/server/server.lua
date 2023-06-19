
Neon = {}

Neon.Vehicles = {}

function Neon.addOnVehicle(vehicle)

    if not isElement(vehicle) or Neon.Vehicles[vehicle] then
        return
    end

    local neonData = Config.vehicles[vehicle.model]
	
    if not neonData then
        neonData = Config.vehicles[0]
    end

    local  isColor = vehicle:getData('vehicle.isNeonColor') 
    if not isColor then
        return
    end
	
	Neon.Vehicles[vehicle] = {}

	
    local x, y, z = getElementPosition(vehicle)

    for i, v in ipairs(neonData) do
        local lamp = createObject(isColor, x, y, z)
        lamp.dimension = vehicle.dimension
        lamp.interior = vehicle.interior
        setElementCollisionsEnabled(lamp, false)

        if not Config.isLampVisible then
            setElementAlpha(lamp, 0)
        end

        attachElements(lamp, vehicle, v[1], v[2], v[3])
        table.insert(Neon.Vehicles[vehicle], lamp)
    end

end

function Neon.removeFromVehicle(vehicle)
    if not isElement(vehicle) or not Neon.Vehicles[vehicle] then
        return
    end

    for _, obj in pairs(Neon.Vehicles[vehicle]) do
        detachElements(obj, vehicle)
        destroyElement(obj)
    end

    Neon.Vehicles[vehicle] = nil
end

function Neon.switch(vehicle)
    if not isElement(vehicle) then
        return
    end

    local  isColor = vehicle:getData('vehicle.isNeonColor')

    if not isColor then
        return
    end

    if Neon.Vehicles[vehicle] then
        Neon.removeFromVehicle(vehicle)
    else
        Neon.addOnVehicle(vehicle)
    end    
end

--[[
addCommandHandler('neon', function(player)
    Neon.switch(player.vehicle)
end)
]]

addEventHandler('operTuningGarage.playerEnterGarage', root, function()

    setTimer(function(player)
        local vehicle = player.vehicle
        Neon.removeFromVehicle(vehicle)
        triggerClientEvent(player, 'operVehicleNeon.startPrewiew', player, vehicle, vehicle:getData('vehicle.isNeonColor'))
    end, 1100, 1, client)

end)

addEventHandler('operTuningGarage.playerExitGarage', root, function()
    setTimer(function(player)
        local vehicle = player.vehicle

        Neon.addOnVehicle(vehicle)
        triggerClientEvent(player, 'operVehicleNeon.stopPrewiew', player, vehicle)
    end, 1100, 1, client)
end)

addEventHandler('onResourceStart', resourceRoot, function()
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        Neon.addOnVehicle(vehicle)
    end
end)

addEventHandler('onResourceStop', resourceRoot, function()
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        Neon.removeFromVehicle(vehicle)
        --vehicle:removeData('vehicle.isNeonColor')
    end
end)

addEventHandler("onElementDestroy", root, function()
    if source.type ~= "vehicle" then return end
    Neon.removeFromVehicle(source)
    source:removeData('vehicle.isNeonColor')
end)
