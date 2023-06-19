VehicleAccessories = { }

function VehicleAccessories.addAccessories(vehicle, model, tittle, category, posX, posY, posZ, rotsX, rotsY, rotsZ, scale)
	if not isElement(vehicle) then
		return
	end

	local x, y, z = getElementPosition(vehicle)

    isPreviewObject = createObject(model, x, y, z)
    isPreviewObject.interior = vehicle.interior
    isPreviewObject.dimension = vehicle.dimension
    attachElements(isPreviewObject, vehicle, posX or 0, posY or 0, posZ or 0.3, rotsX or 0, rotsY or 0, rotsZ or 0)
    setObjectScale(isPreviewObject, scale or 1.0, scale or 1.0)

	local posX, posY, posZ, rotsX, rotsY, rotsZ = getElementAttachedOffsets(isPreviewObject)    
   	local isAccessories = vehicle:getData('vehicle.isAccessories') or {}

    table.insert(isAccessories, 
    	{
    		model = model, 
    		tittle = tittle, 
    		category = category,

    		object = isPreviewObject,

    		posX = posX, 
    		posY = posY, 
    		posZ = posZ, 
    		rotsX = rotsX, 
    		rotsY = rotsY, 
    		rotsZ = rotsZ,

    		scale = scale or 1.0
    	}
    )

    vehicle:setData('vehicle.isAccessories', isAccessories)
end
addEvent('operVehicleObject.addVehicleAccessories', true)
addEventHandler('operVehicleObject.addVehicleAccessories', root, VehicleAccessories.addAccessories)

function VehicleAccessories.removeAccessories(vehicle, object)
	if not isElement(vehicle) or not isElement(object) then
		return
	end

	local isAccessories = vehicle:getData('vehicle.isAccessories')

	for i, accessories in ipairs(isAccessories) do
		if accessories.object == object then

			table.remove(isAccessories, i)
			destroyElement(accessories.object)
			break
		end
	end

	vehicle:setData('vehicle.isAccessories', isAccessories)
end
addEvent('operVehicleObject.removeVehicleAccessories', true)
addEventHandler('operVehicleObject.removeVehicleAccessories', root, VehicleAccessories.removeAccessories)

function VehicleAccessories.updateAccessories(vehicle, object, posX, posY, posZ, rotsX, rotsY, rotsZ, scale)
	if not isElement(vehicle) or not isElement(object) then
		return
	end

	local isAccessories = vehicle:getData('vehicle.isAccessories')

	for i, accessories in ipairs(isAccessories) do
		if accessories.object == object then

			setElementAttachedOffsets(object, posX, posY, posZ, rotsX, rotsY, rotsZ)
			setObjectScale(object, scale, scale)

			accessories.object.interior = vehicle.interior
	    	accessories.object.dimension = vehicle.dimension
	    	
			accessories.posX = posX
			accessories.posY = posY
			accessories.posZ = posZ
			accessories.rotsX = rotsX
			accessories.rotsY = rotsY
			accessories.rotsZ = rotsZ

			accessories.scale = scale
			break
		end
	end

	vehicle:setData('vehicle.isAccessories', isAccessories)
end
addEvent('operVehicleObject.updateVehicleAccessories', true)
addEventHandler('operVehicleObject.updateVehicleAccessories', root, VehicleAccessories.updateAccessories)

-- Когда игрок выходит из гаража, необходимо переместить объекты в нулевое измерение
function VehicleAccessories.updateDimension()

	setTimer(function(player)
		local vehicle = player.vehicle

		if not isElement(vehicle) then
			return
		end

		local isAccessories = vehicle:getData('vehicle.isAccessories') or {}
	
		for _, accessories in ipairs(isAccessories) do
			--outputDebugString(accessories.object.interior..' '..accessories.object.dimension)
			accessories.object.interior = player.interior
	    	accessories.object.dimension = player.dimension
		end
	end, 1100, 1, client)

end
addEventHandler('operTuningGarage.playerExitGarage', root, VehicleAccessories.updateDimension)
addEventHandler('operTuningGarage.playerEnterGarage', root, VehicleAccessories.updateDimension)

addEventHandler('onResourceStart', resourceRoot, function()
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		local isAccessories = vehicle:getData('vehicle.isAccessories') or {}
		vehicle:removeData('vehicle.isAccessories')

		for _, accessories in ipairs(isAccessories) do

			VehicleAccessories.addAccessories(
				vehicle, 
				accessories.model, 
				accessories.tittle, 
				accessories.category, 
				accessories.posX, accessories.posY, accessories.posZ, 
				accessories.rotsX, accessories.rotsY, accessories.rotsZ, 
				accessories.scale
			)
		end
	end
end)

addEventHandler('onResourceStop', resourceRoot, function()
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		local isAccessories = vehicle:getData('vehicle.isAccessories') or {}
		for _, accessories in ipairs(isAccessories) do
			destroyElement(accessories.object)
		end

		--vehicle:removeData('vehicle.isAccessories')
	end
end)

addEventHandler("onElementDestroy", root, function()
	if source.type ~= "vehicle" then return end

	local isAccessories = source:getData('vehicle.isAccessories') or {}
	for _, accessories in ipairs(isAccessories) do
		destroyElement(accessories.object)
	end

	source:removeData('vehicle.isAccessories')
end)