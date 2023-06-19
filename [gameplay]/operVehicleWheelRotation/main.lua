local vehicles = { }

addEventHandler('onClientRender', root, function()
	for vehicle, wheelsData in pairs(vehicles) do
		if not vehicle then return end
		local r_wrx, r_wry, r_wrz = getVehicleComponentRotation(vehicle, 'wheel_rf_dummy')
		if wheelsData[1] then
			setVehicleComponentRotation(vehicle, 'wheel_rf_dummy', wheelsData[1], wheelsData[2], wheelsData[3])
			setVehicleComponentRotation(vehicle, 'wheel_lf_dummy', wheelsData[4], wheelsData[5], wheelsData[6])
		end
	end
end)

addEventHandler("onClientVehicleStartExit", root, function(player, seat)
	if seat ~= 0 then return end

	local r_wrx, r_wry, r_wrz = getVehicleComponentRotation(source, 'wheel_rf_dummy')
	local l_wrx, l_wry, l_wrz = getVehicleComponentRotation(source, 'wheel_lf_dummy')

	setElementData(source, 'wheel_rotation.Data', {r_wrx, r_wry, r_wrz, l_wrx, l_wry, l_wrz})
	vehicles[source] = {r_wrx, r_wry, r_wrz, l_wrx, l_wry, l_wrz}
end)

addEventHandler("onClientVehicleEnter", root, function(player, seat)
	if seat ~= 0 then return end

	setElementData(source, 'wheel_rotation.Data', false)
	vehicles[source] = nil
end)

addEventHandler("onClientElementDestroy", root, function ()
	if getElementType(source) == "vehicle" then
		local data = getElementData(source, 'wheel_rotation.Data')
		if type(data) == 'table' and vehicles[source] then
			vehicles[source] = nil
		end
	end
end)

-- Вносим в обработчик авто, попавшие в стрим
addEventHandler('onClientElementStreamIn', root, function()
	if source:getType() == 'vehicle' then
		local data = getElementData(source, 'wheel_rotation.Data')
		if type(data) == 'table' and not vehicles[source] then
			vehicles[source] = {data[1], data[2], data[3], data[4], data[5], data[6]}
		end
	end
end)

-- Убираем из обработчика авто, вышедшие из стрима
addEventHandler('onClientElementStreamOut', root, function()
	if source:getType() == 'vehicle' then
		local data = getElementData(source, 'wheel_rotation.Data')
		if type(data) == 'table' and vehicles[source] then
			vehicles[source] = nil
		end
	end
end)

-- Вносим в обработчик авто из стрима при вклчении
addEventHandler('onClientResourceStart', resourceRoot, function()
	for key, vehicle in pairs(getElementsByType('vehicle', root, true)) do
		local data = getElementData(vehicle, 'wheel_rotation.Data')
		if type(data) == 'table' then
			vehicles[vehicle] = {data[1], data[2], data[3], data[4], data[5], data[6]}
		end
	end
end)
