--[[
addEvent('operVehicleFSO.deleteFromVehicle', true)
addEventHandler('operVehicleFSO.deleteFromVehicle', root, function(vehicle)
	if not isElement(vehicle) then return end
	triggerClientEvent(source, 'operVehicleFSO.deleteFromVehicle', source, vehicle)
end)
]]