dxShader = dxCreateShader('assets/fso.fx')
isVehicleFSO = {}

function FSO.lights(vehicle, state)
	if not isElement(vehicle) then return end

	local dataFSO = vehicle:getData('vehicle.dataFSO') or false
	if not dataFSO then return end

	if not isVehicleFSO[vehicle] then
		return 
	end

	local mode = vehicle:getData('vehicle.isVehicleModeFSO') or 1

	if state == 'down' or state == 'demo' then
		if mode == 1 then
			flashLightMode1(vehicle, dataFSO)
		elseif mode == 2 then
			flashLightMode2(vehicle, dataFSO)
		elseif mode == 3 then
			flashLightMode3(vehicle, dataFSO)
		elseif mode == 4 then
			flashLightMode4(vehicle, dataFSO)
		end

		if state == 'demo' then
			if isTimer(isVehicleFSO[vehicle].isTimer) then
				killTimer(isVehicleFSO[vehicle].isTimer) 
				isVehicleFSO[vehicle].isTimer = nil
			end
		end
	elseif state == 'up' then
		if isTimer(isVehicleFSO[vehicle].isTimer) then
			killTimer(isVehicleFSO[vehicle].isTimer) 
			isVehicleFSO[vehicle].isTimer = nil
		end
	end
end

function FSO.updateLightsMode(vehicle, mode)
	if not isElement(vehicle) then return end

	local dataFSO = vehicle:getData('vehicle.dataFSO') or false
	if not dataFSO then return end

	vehicle:setData('vehicle.isVehicleModeFSO', tonumber(mode))
end

function FSO.onPlayerPressButton(_, state)
	local vehicle = localPlayer.vehicle
	if not isElement(vehicle) then return end

	if isCursorShowing() then
		setElementData(vehicle, 'vehicle.isVehicleStateFSO', 'up')
		return
	end

	if state == 'down' then
		if isElement(FSO.sound) then
			destroyElement(FSO.sound)
			FSO.sound = nil
		end
		FSO.sound = exports.operSounds:playSound('veh_lightswitch')
	end

	setElementData(vehicle, 'vehicle.isVehicleStateFSO', state)
end

function FSO.updateVisible(vehicle)
	if not isElement(vehicle) then 
		return 
	end

	local dataFSO = vehicle:getData('vehicle.dataFSO') or false

	if not dataFSO then 
		return 
	end

	if not isVehicleFSO[vehicle] then
		isVehicleFSO[vehicle] = {}
	end

	for acces, acces_data in pairs(dataFSO) do

		triggerEvent(
			'operVehicleComponents.setComponentVisible', 
			localPlayer, 
			vehicle, 
			acces, 
			acces_data.visible
		)

		if acces_data.visible then

			if isVehicleFSO[vehicle][acces] then	
				destroyElement(isVehicleFSO[vehicle][acces].lightL)
				destroyElement(isVehicleFSO[vehicle][acces].lightR)

				isVehicleFSO[vehicle][acces] = nil
			end
			
			isVehicleFSO[vehicle][acces] = {}

			local pos = Vector3(vehicle)

			isVehicleFSO[vehicle][acces].lightL = createMarker(pos.x, pos.y, pos.z, "corona", 0.2, 255, 255, 255, 0)
			attachElements(isVehicleFSO[vehicle][acces].lightL, vehicle, acces_data.position[1].x, acces_data.position[1].y, acces_data.position[1].z)

			isVehicleFSO[vehicle][acces].lightR = createMarker(pos.x, pos.y, pos.z, "corona", 0.2, 255, 255, 255, 0)
			attachElements(isVehicleFSO[vehicle][acces].lightR, vehicle, acces_data.position[2].x, acces_data.position[2].y, acces_data.position[2].z)
		else
			if isVehicleFSO[vehicle][acces] then	
				destroyElement(isVehicleFSO[vehicle][acces].lightL)
				destroyElement(isVehicleFSO[vehicle][acces].lightR)

				isVehicleFSO[vehicle][acces] = nil
			end
		end

	end
end

function FSO.addOnVehicle(vehicle, isComponent) 
	if not isElement(vehicle) then
		return
	end

	local model = getElementModel(vehicle)
	local Config = FSO.Config[model] 

	if not Config then return end

	local dataFSO = vehicle:getData('vehicle.dataFSO') or {}

	for _, acces in ipairs(Config) do
		if isComponent == acces.component then
			dataFSO[acces.component] = { visible = true, texture = acces.texture, position = acces.position }
		end
	end

	vehicle:setData('vehicle.dataFSO', dataFSO)

	if localPlayer ~= vehicle:getData('vehicle.isPlayer') then
		return
	end

	unbindKey('l', 'both', FSO.onPlayerPressButton)
	bindKey('l', 'both', FSO.onPlayerPressButton)
end

function FSO.deleteFromVehicle(vehicle, isComponent)
	if not isElement(vehicle) then
		return
	end

	local model = getElementModel(vehicle)
	local Config = FSO.Config[model] 

	if not Config then return end

	local dataFSO = vehicle:getData('vehicle.dataFSO') or {}

	for _, acces in ipairs(Config) do

		if not dataFSO[acces.component] then
			dataFSO[acces.component] = {}
		end
		
		if isComponent == acces.component then
			dataFSO[acces.component].visible = false
			break
		end

		dataFSO[acces.component].visible = dataFSO[acces.component].visible or false
		
	end

	vehicle:setData('vehicle.dataFSO', dataFSO)

	if localPlayer ~= vehicle:getData('vehicle.isPlayer') then
		return
	end

	unbindKey('l', 'both', FSO.onPlayerPressButton)
end


addEventHandler("onClientVehicleEnter", root, function(player, seat)
   	if (player ~= localPlayer) then return end

   	if seat == 0 then
        local currentFSO = source:getData('vehicle.isVehicleStateFSO') or false
        --outputDebugString(currentFSO)
		if currentFSO then
			unbindKey('l', 'both', FSO.onPlayerPressButton)
			bindKey('l', 'both', FSO.onPlayerPressButton)
		else
			unbindKey('l', 'both', FSO.onPlayerPressButton)
		end
	else 
		unbindKey('l', 'both', FSO.onPlayerPressButton)
		setElementData(source, 'vehicle.isVehicleStateFSO', 'up')
    end

end)

addEventHandler("onClientVehicleStartExit", root, function(player, seat)
	if (player == localPlayer and seat == 0) then 

		local currentFSO = source:getData('vehicle.dataFSO') or false

		if currentFSO then
			unbindKey('l', 'both', FSO.onPlayerPressButton)
		end

		setElementData(source, 'vehicle.isVehicleStateFSO', 'up')
	end
end)

-- СИНХРОНИЗАЦИЯ --

addEventHandler("onClientElementDataChange", root, function(data, _, state)
	if not getElementType(source) == "vehicle" then return end

	if data == 'vehicle.dataFSO' and isElementStreamedIn(source) then
		FSO.updateVisible(source)
	end
	
	if data == 'vehicle.isVehicleStateFSO' and isElementStreamedIn(source) then
		FSO.lights(source, state)
	end
end)


addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
    	FSO.updateVisible(source)
    end
end)

-- exports
addEvent('operVehicleFSO.deleteFromVehicle', true)
addEventHandler('operVehicleFSO.deleteFromVehicle', root, FSO.deleteFromVehicle)

addOnVehicle = FSO.addOnVehicle
deleteFromVehicle = FSO.deleteFromVehicle
lights = FSO.lights
updateLightsMode = FSO.updateLightsMode
updateVisible = FSO.updateVisible
--! Бинд слетает, когда снимаем фсо