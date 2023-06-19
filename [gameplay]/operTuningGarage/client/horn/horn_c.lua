local isVehicleHorn = { }

local function addVehicleSound(veh, horn)
	if not veh then return end

	local x, y, z = getElementPosition(veh)
	local sound = exports.operSounds:playSound3D(horn, x, y, z, true)

	setSoundVolume(sound, 1.3)
	setSoundMaxDistance(sound, 100) 
	attachElements(sound, veh)

	return sound
end

local function updateVehicleHorn(veh, state)
	if not veh then return end

	local horn = veh:getData('vehicle.isHorn') or false
	if not horn then return end
	
	if not isVehicleHorn[veh] and state == 'down' then
		isVehicleHorn[veh] = { }

		isVehicleHorn[veh].sound = addVehicleSound(veh, horn)
		isVehicleHorn[veh].player = getVehicleOccupant(veh)
		return
	end
	
	if isVehicleHorn[veh] and state == 'up' then
		if isElement(isVehicleHorn[veh].sound) then
			stopSound(isVehicleHorn[veh].sound)
		end
		isVehicleHorn[veh] = nil
		return 
	end
end

local function onVehicleHorn(_, state)
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end

	if isCursorShowing() then
		setElementData(veh, 'vehicle.isVehicleHornState', 'up')
		return
	end

	setElementData(veh, 'vehicle.isVehicleHornState', state)
end

addEventHandler("onClientElementDataChange", root, function(data, _, state)
	if not getElementType(source) == "vehicle" then return end
	local currentHorn = source:getData('vehicle.isHorn') or false
	if not currentHorn then return end

	if isElementStreamedIn(source) and data == 'vehicle.isVehicleHornState' then
		updateVehicleHorn(source, state)
	end
end)

function TuningGarage.setVehicleHorn(veh)
	local currentHorn = veh:getData('vehicle.isHorn') or false

	toggleControl("horn", false)
	
	if not currentHorn then
		toggleControl("horn", true)
		unbindKey('h', 'both', onVehicleHorn)
		return
	end


	unbindKey('h', 'both', onVehicleHorn)
	bindKey('h', 'both', onVehicleHorn)
end

addEvent('operTuningGarage.setVehicleDefaultHorn', true)
addEventHandler('operTuningGarage.setVehicleDefaultHorn', root, function(vehicle)
	if not isElement(vehicle) then
		return
	end

	vehicle:setData('vehicle.isHorn', 'veh_horn_sound_1')
    TuningGarage.setVehicleHorn(vehicle)
end)

addEventHandler("onClientVehicleEnter", root, function(player, seat)
   	if (player ~= localPlayer) then return end

   	if seat == 0 then
        toggleControl("horn", false)

        local currentHorn = source:getData('vehicle.isHorn') or false

		if currentHorn then
			unbindKey('h', 'both', onVehicleHorn)
			bindKey('h', 'both', onVehicleHorn)
		else
			toggleControl("horn", true)
			unbindKey('h', 'both', onVehicleHorn)
		end
	else 
		unbindKey('h', 'both', onVehicleHorn)
		setElementData(source, 'vehicle.isVehicleHornState', 'up')
    end

end)

addEventHandler("onClientVehicleStartExit", root, function(player, seat)
	if (player == localPlayer and seat == 0) then 

		local currentHorn = source:getData('vehicle.isHorn') or false

		if currentHorn then
			unbindKey('h', 'both', onVehicleHorn)
		end

		setElementData(source, 'vehicle.isVehicleHornState', 'up')
	end
end)

local function NEW_FUNCTION(vehicle)
	local driver = getVehicleOccupant(vehicle)
	local veh = getPedOccupiedVehicle(localPlayer)

	if not veh or not driver then
		return false
	end

	if not isVehicleHorn[vehicle] then 
		return
	end

	if getPedOccupiedVehicleSeat(localPlayer) == 0 then
		if isVehicleHorn[vehicle].player ~= driver then
			return false
		end
	end

	return true
end

addEventHandler("onClientElementDestroy", root, function()
    if source and getElementType(source) == "vehicle" then

    	local currentHorn = source:getData('vehicle.isHorn') or false

		if not currentHorn then
			return
		end

		if NEW_FUNCTION(source) then
 			unbindKey('h', 'both', onVehicleHorn)
		end

		setElementData(source, 'vehicle.isVehicleHornState', 'up')
    end
end)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	local veh = getPedOccupiedVehicle(localPlayer)

	if not veh then
		return
	end

	local currentHorn = veh:getData('vehicle.isHorn') or false

    if not currentHorn then
    	return
    end

    setElementData(veh, 'vehicle.isVehicleHornState', 'up')
end)

addEventHandler("onClientResourceStart", resourceRoot, function ()
    local veh = getPedOccupiedVehicle(localPlayer)
    
    if not veh then
    	return
    end

    local currentHorn = veh:getData('vehicle.isHorn') or false
    if veh and currentHorn and getPedOccupiedVehicleSeat(localPlayer) == 0 then
        toggleControl("horn", false)
        unbindKey('h', 'both', onVehicleHorn)
		bindKey('h', 'both', onVehicleHorn)
    end
end)

addEventHandler("onClientElementModelChange", root, function(oldModel)
	if source and getElementType(source) == "vehicle" then

		local currentHorn = source:getData('vehicle.isHorn') or false

		if not currentHorn then
			return
		end
		triggerServerEvent('operTuningGarage.hornBreakModelChange', source, oldModel)
	end
end)
