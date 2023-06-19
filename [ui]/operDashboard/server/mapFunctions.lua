function warpMeIntoVehicle(vehicle)

	if not isElement(vehicle) then return end

	if getPedOccupiedVehicle(source) then
		triggerClientEvent(source, 'operNotification.addNotification', source, "Вы должны выйти из автомобиля!", 2, true)
		-- Выйдите из своего автомобиля первым.
		--outputChatBox('Get out of your vehicle first.', source, 255,0,0)
		return
	end

	local interior = getElementInterior(vehicle)
	local numseats = getVehicleMaxPassengers(vehicle)
	local driver = getVehicleController(vehicle)


	if exports.operTuningGarage:isPlayerInTuning(driver) then
		triggerClientEvent(source, 'operNotification.addNotification', source, "Игрок находится в гараже\nтелепортация невозможна!", 2, true)
		return
	end
	
	for i=0,numseats do
		if not getVehicleOccupant(vehicle, i) then
			setElementInterior(source, interior)
			setCameraInterior(source, interior)
			warpPedIntoVehicle(source, vehicle, i)
			return
		end
	end
	if isElement(driver) then
		triggerClientEvent(source, 'operNotification.addNotification', source, "К сожалению, в автомобиле игрока\nне осталось свободных мест", 2, true)
		-- Свободных мест не осталось в автомобиле
		--outputChatBox('No free seats left in ' .. getPlayerName(driver) .. '\'s vehicle.', source, 255, 0, 0)
	end

end
addEvent('mapFunctions.warpMeIntoVehicle', true)
addEventHandler('mapFunctions.warpMeIntoVehicle', root, warpMeIntoVehicle)

function fadeVehiclePassengersCamera(toggle)
	local vehicle = getPedOccupiedVehicle(source)
	if not vehicle then
		return
	end
	local player
	for i=0,getVehicleMaxPassengers(vehicle) do
		player = getVehicleOccupant(vehicle, i)
		if player then
			fadeCamera(player, toggle)
		end
	end
end
addEvent('mapFunctions.fadeVehiclePassengersCamera', true)
addEventHandler('mapFunctions.fadeVehiclePassengersCamera', root, fadeVehiclePassengersCamera)

function _setElementInterior(element, int)
	if not element then
		return
	end

	setElementInterior(element, int)
end
addEvent('mapFunctions.setElementInterior', true)
addEventHandler('mapFunctions.setElementInterior', root, _setElementInterior)