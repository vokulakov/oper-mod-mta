VehicleFunctions = {}


function VehicleFunctions.repairVehicle()
	if not source then
		return
	end

	local vehicle = getPedOccupiedVehicle(source)
	if vehicle then
		fixVehicle(vehicle)
		playSoundFrontEnd(source, 46)
		triggerClientEvent(source, 'operNotification.addNotification', source, "Транспорт починен", 1, false)
	end
end
addEvent('VehicleFunctions.repairVehicle', true)
addEventHandler('VehicleFunctions.repairVehicle', root, VehicleFunctions.repairVehicle)

addCommandHandler('repair', VehicleFunctions.repairVehicle)
addCommandHandler('rp', VehicleFunctions.repairVehicle)

function VehicleFunctions.warpVehicle()
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then
		local x, y, z = getElementPosition(source)
		setElementPosition(vehicle, x+3, y+2, z+1.5)

		triggerClientEvent(source, 'operNotification.addNotification', source, "Транспорт доставлен", 1, true)
	end
end
addEvent('VehicleFunctions.warpVehicle', true)
addEventHandler('VehicleFunctions.warpVehicle', root, VehicleFunctions.warpVehicle)


-- !ИДЕЯ
-- Сделать так, чтобы при поставке на ручник сначала тормозила машина, а потом уже фризилась. 
function VehicleFunctions.handbrake()
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then
		local state = isElementFrozen(vehicle)
		setElementFrozen(vehicle, not state)

		if not state then
			triggerClientEvent(source, 'operSound.playSound', source, 'veh_handbrake')
		end
	end
end
addEvent('VehicleFunctions.handbrake', true)
addEventHandler('VehicleFunctions.handbrake', root, VehicleFunctions.handbrake)

function VehicleFunctions.setVehicleGhost(value)
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then
		local VehiclesProperty = vehicle:getData('vehicle.isProperty')
		VehiclesProperty.ghostmode = value
		vehicle:setData('vehicle.isProperty', VehiclesProperty)

		triggerClientEvent(source, 'VehicleFunctions.setVehicleGhost', vehicle)

		local message = ""
		if value then
			message = "Для вашего транспорта\nактивирован режим 'Анти-таран'"
		else
			message = "Режим 'Анти-таран' отключен"
		end

		triggerClientEvent(source, 'operNotification.addNotification', source, message, 1, true)
	end
end
addEvent('VehicleFunctions.setVehicleGhost', true)
addEventHandler('VehicleFunctions.setVehicleGhost', root, VehicleFunctions.setVehicleGhost)

function VehicleFunctions.setVehicleDamage(value)
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then
		local VehiclesProperty = vehicle:getData('vehicle.isProperty')
		VehiclesProperty.damageproof = value
		vehicle:setData('vehicle.isProperty', VehiclesProperty)

		setVehicleDamageProof(vehicle, value)

		local message = ""
		if value then
			message = "Для вашего транспорта\nотключены повреждения"
		else
			message = "Повреждения включены"
		end

		triggerClientEvent(source, 'operNotification.addNotification', source, message, 1, true)
	end
end
addEvent('VehicleFunctions.setVehicleDamage', true)
addEventHandler('VehicleFunctions.setVehicleDamage', root, VehicleFunctions.setVehicleDamage)

function VehicleFunctions.setSpecialProperty(property, value)
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then
		local VehiclesProperty = vehicle:getData('vehicle.isProperty')
		VehiclesProperty[property] = value
		vehicle:setData('vehicle.isProperty', VehiclesProperty)

		triggerClientEvent(source, 'VehicleFunctions.setSpecialProperty', source, property, value)
	end
end
addEvent('VehicleFunctions.setSpecialProperty', true)
addEventHandler('VehicleFunctions.setSpecialProperty', root, VehicleFunctions.setSpecialProperty)

local VehicleExplosionTimer = {}

function VehicleFunctions.setVehicleExplosion(value)
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then

		local VehiclesProperty = vehicle:getData('vehicle.isProperty')
		VehiclesProperty.explosion = value
		vehicle:setData('vehicle.isProperty', VehiclesProperty)

		if not value and isTimer(VehicleExplosionTimer[vehicle]) then
			killTimer(VehicleExplosionTimer[vehicle])
			VehicleExplosionTimer[vehicle] = nil
			triggerClientEvent(source, 'operNotification.addNotification', source, "Взрыв транспорта включен.\nПри сильных повреждениях,\nтранспорт может взорваться.\nБудьте внимательны!", 1, true)
			return
		end

		VehicleExplosionTimer[vehicle] = setTimer(function(isVehicle)
			if not isElement(isVehicle) then
				if isTimer(VehicleExplosionTimer[isVehicle]) then
					killTimer(VehicleExplosionTimer[isVehicle])
					VehicleExplosionTimer[isVehicle] = nil
				end
				return
			end

			if getElementHealth(isVehicle) <= 255 then
				setElementHealth(isVehicle, 255.5)
				setVehicleDamageProof(isVehicle, true)
				setVehicleEngineState(isVehicle, false)
			end
		end, 50, 0, vehicle)

		triggerClientEvent(source, 'operNotification.addNotification', source, "Для вашего транспорта отключен\nвзрыв. Транспорт не загорится,\nдаже при сильных повреждениях", 1, true)
	end
end
addEvent('VehicleFunctions.setVehicleExplosion', true)
addEventHandler('VehicleFunctions.setVehicleExplosion', root, VehicleFunctions.setVehicleExplosion)

addEventHandler("onVehicleDamage", root, function()
	if getElementHealth(source) <= 255.5 then 
		setVehicleEngineState(source, false)
	else
		if isVehicleDamageProof(source) then
			setVehicleDamageProof(source, false)
		end
	end
end)

function VehicleFunctions.setVehicleEnterAllowed(isDriver, state)
	if not source then
		return
	end

	local vehicle = source:getData('player.isVehicle')
	if vehicle then
		local VehiclesProperty = vehicle:getData('vehicle.isProperty')
		VehiclesProperty.enterAllowed = {isDriver = isDriver, state = state}
		vehicle:setData('vehicle.isProperty', VehiclesProperty)

		local message = ""
		if isDriver then
			if state then
				message = 'Вы запретили игрокам управлять\nвашим транспортным средством'
			else
				message = 'Игроки смогут упарвлять\nвашим транспортным средством'
			end
		elseif not isDriver then
			if state then
				message = 'Вы запретили игрокам садиться\nв ваше транспортное средство'
			else
				message = 'Игроки смогут садиться\nв ваше транспортное средство'
			end
		end

		triggerClientEvent(source, 'operNotification.addNotification', source, message, 1, true)
	end
end
addEvent('VehicleFunctions.setVehicleEnterAllowed', true)
addEventHandler('VehicleFunctions.setVehicleEnterAllowed', root, VehicleFunctions.setVehicleEnterAllowed)