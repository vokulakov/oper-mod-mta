Plate = {}

function Plate.updateVisible(vehicle)
	if not isElement(vehicle) then return end
	local dataPLATE = vehicle:getData('vehicle.isPlateVisible') or false

	if not dataPLATE then
		return
	end

	for plate, plate_data in pairs(dataPLATE) do

		triggerEvent(
			'operVehicleComponents.setComponentVisible', 
			localPlayer, 
			vehicle, 
			plate, 
			plate_data.visible
		)

	end
end

function Plate.addOnVehicle(vehicle, plate)
	if not isElement(vehicle) then return end

	local dataPLATE = vehicle:getData('vehicle.isPlateVisible') or {}


	if plate == nil then
		dataPLATE['RearBump0']  = {visible = true}
		dataPLATE['FrontBump0'] = {visible = true}
	else
		dataPLATE[plate] = {visible = true}
	end

	vehicle:setData('vehicle.isPlateVisible', dataPLATE)
end

function Plate.deleteFromVehicle(vehicle, plate) 
	if not isElement(vehicle) then return end

	local dataPLATE = vehicle:getData('vehicle.isPlateVisible') or {}

	if plate == nil then
		dataPLATE['RearBump0']  = {visible = false}
		dataPLATE['FrontBump0'] = {visible = false}
	else
		dataPLATE[plate] = {visible = false}
	end

	vehicle:setData('vehicle.isPlateVisible', dataPLATE)
end


addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(vehicle) then
			Number.setVehicleNumberPlate(vehicle)
			Ramka.setVehicleRamka(vehicle)
		end
	end
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		Number.destroyVehicleNumberPlate(vehicle)
		Ramka.destroyVehicleRamka(vehicle)

		Number.isPlateOnVehicle[vehicle] = nil
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
        Plate.updateVisible(source)
        Ramka.setVehicleRamka(source)
        
        Number.setVehicleNumberPlate(source)
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
        Number.destroyVehicleNumberPlate(source)
        Ramka.destroyVehicleRamka(source)
    end
end)

addEventHandler("onClientElementDestroy", root, function()
    if source and getElementType(source) == "vehicle" then
    	Number.destroyVehicleNumberPlate(source)
    	Ramka.destroyVehicleRamka(source)

    	Number.isPlateOnVehicle[source] = nil
    end
end)


addEventHandler("onClientElementDataChange", root, function(data, _, state)
	if not getElementType(source) == "vehicle" then return end

	if data == 'vehicle.isPlateVisible' and isElementStreamedIn(source) then
		Plate.updateVisible(source)
	elseif data == "vehicle.isPlate" and isElementStreamedIn(source) then
		Number.setVehicleNumberPlate(source)
	end

end)


addEvent('operVehiclePlate.deleteFromVehicle', true)
addEventHandler('operVehiclePlate.deleteFromVehicle', root, Plate.deleteFromVehicle)

-- Exports 
addOnVehicle = Plate.addOnVehicle
deleteFromVehicle = Plate.deleteFromVehicle
