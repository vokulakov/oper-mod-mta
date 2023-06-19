local function setupVehicleHandling(vehicle)
	if not isElement(vehicle) then
		return false
	end
	local vehicleName = getVehicleNameFromModel(vehicle.model):upper()
	local activeHandling = vehicle:getData("activeHandling")
	if not activeHandling then
		activeHandling = "street"
		vehicle:setData("activeHandling", activeHandling)
	end

	local handlingLevel = 1
	local handlingsTable = getVehicleHandlingTable(vehicleName, activeHandling, handlingLevel)
	if not handlingsTable then
		return false
	end

	for k, v in pairs(handlingsTable) do
		setVehicleHandling(vehicle, k, v, false)
	end
	--updateVehicleSuspension(vehicle)
end

addEventHandler("onElementModelChange", root, function()
	if source.type ~= "vehicle" then
		return
	end
	outputDebugString('\nWarning! Handling таким методом не применяется.', 0, 170, 160, 0)
end)

---[[ 
addEventHandler('onElementStartSync', root, function()
	if source.type ~= "vehicle" then
		return
	end
	
	source:setData("activeHandling", "street")
end)
--]]

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getElementsByType("vehicle")) do
		v:setData("activeHandling", "street")
	end
end)

addEventHandler("onResourceStop", resourceRoot, function()
	for i, v in ipairs(getElementsByType("vehicle")) do
		if v:getData('activeHandling') then
			v:removeData('activeHandling')
		end
	end
end)


addEventHandler("onElementDataChange", root, function (dataName)
	if source.type ~= "vehicle" then
		return
	end
	if dataName == "activeHandling" then
		setupVehicleHandling(source)
	end
end)
