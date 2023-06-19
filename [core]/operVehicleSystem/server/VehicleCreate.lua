VehicleCreate = {}

local Vehicles = {}

function VehicleCreate.spawnVehicle(player, model)
	if not player then
		return
	end

	VehicleCreate.removeVehicle(player)

	local px, py, pz, prot
	local element = getPedOccupiedVehicle(player) or player
	local px,py,pz = getElementPosition(element)
	local _,_,prot = getElementRotation(element)
	local posVector = Vector3(px, py, pz+2)
	local rotVector = Vector3(0, 0, prot)
	local vehMatrix = Matrix(posVector, rotVector)

	if not model then return end

	local vehPos = posVector
	local vehicle = Vehicle(model, vehPos, rotVector) or false

	if vehicle then
		vehicle.interior = source.interior
		vehicle.dimension = source.dimension
		if vehicle.vehicleType == "Bike" then vehicle.velocity = Vector3(0, 0, -0.01) end

		setVehicleColor(vehicle, 0, 0, 0, 0)

		setVehicleOverrideLights(vehicle, 1) -- отключаем фары, чтобы при смене времени автоматические не загорались
		setVehicleEngineState(vehicle, false)

		local colSphere = createColSphere(px, py, pz, 20.0) 
		attachElements(colSphere, vehicle, 0, 0, 0)

		element:setData('player.isVehicle', vehicle)
		vehicle:setData('vehicle.isPlayer', element)
		vehicle:setData('vehicle.isProperty', {})
		vehicle:setData('vehicle.isColSphere', colSphere)

		exports.lmxVehicleToner:setVehicleDefaultToner(vehicle) -- тонировка

		warpPedIntoVehicle(element, vehicle, 0)  

		triggerClientEvent(element, 'operVehicleFSO.deleteFromVehicle', element, vehicle) -- снимаем ФСО
		triggerClientEvent(element, 'operVehiclePlate.deleteFromVehicle', element, vehicle) -- снимаем НОМЕРА
		triggerClientEvent(element, 'operTuningGarage.setVehicleDefaultHorn', element, vehicle)

		Vehicles[element] = vehicle

		local Names = getVehiclesNameList()
		local name =  Names[model] or getVehicleNameFromModel(model)
		triggerClientEvent(element, 'operNotification.addNotification', element, name.." создан.\nНажмите 'F2' для открытия меню\nуправления транспортом.", 1, true)
	end
end
addEvent('operVehicleSystem.spawnVehicle', true)
addEventHandler('operVehicleSystem.spawnVehicle', root, VehicleCreate.spawnVehicle)


function VehicleCreate.removeVehicle(player)
	if not player then
		return
	end

	if not isElement(Vehicles[player]) then
		return
	end

	local Names = getVehiclesNameList()
	local model = getElementModel(Vehicles[player])
	local name =  Names[model] or getVehicleNameFromModel(model)

	local colSphere = Vehicles[player]:getData('vehicle.isColSphere')
	destroyElement(colSphere)

	player:removeData('player.isVehicle')
	Vehicles[player]:removeData('vehicle.isPlayer')
	Vehicles[player]:removeData('vehicle.isProperty')
	Vehicles[player]:removeData('vehicle.isColSphere')

	destroyElement(Vehicles[player])

	Vehicles[player] = nil

	
	triggerClientEvent(player, 'operNotification.addNotification', player, name.." убран!", 1, true)
end
addEvent('operVehicleSystem.removeVehicle', true)
addEventHandler('operVehicleSystem.removeVehicle', root, VehicleCreate.removeVehicle)


addEventHandler("onPlayerQuit", root, function()
	VehicleCreate.removeVehicle(source)
end)

addEventHandler("onVehicleExplode", root, function()
	local player = source:getData('vehicle.isPlayer')

	if not isElement(player) then
		return
	end

	VehicleCreate.removeVehicle(player)
end)

addEventHandler("onElementDestroy", root, function()
	if source.type ~= "vehicle" then return end

	local player = source:getData('vehicle.isPlayer')

	if not isElement(player) then
		return
	end

	VehicleCreate.removeVehicle(player)
end)

addEventHandler("onResourceStop", resourceRoot, function()

	for _, player in ipairs(getElementsByType("player")) do
		if isElement(Vehicles[player]) then
			VehicleCreate.removeVehicle(player)
		end
	end

end)

setTimer(function()
	local state = false
	local count = 0

	for _, veh in ipairs(getElementsByType("vehicle", resourceRoot)) do
		if not isElement(veh:getData('vehicle.isPlayer')) then

			local colSphere = veh:getData('vehicle.isColSphere')
			destroyElement(colSphere)

			veh:removeData('vehicle.isPlayer')
			veh:removeData('vehicle.isProperty')
			veh:removeData('vehicle.isColSphere')
			
			state = true
			count = count + 1
			destroyElement(veh)
		end
	end

	if state then
		outputDebugString('\nСистема удалила транспорт! ['..count..']', 0, 170, 160, 0)
	end

end, 300000, 0)