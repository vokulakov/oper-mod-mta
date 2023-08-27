local function playerBindKey(plr)
	bindKey(plr, "k", "down", doToggleLocked) -- закрытие дверей
	bindKey(plr, "1", "down", doToggleLights) -- фары
	bindKey(plr, "2", "down", doToggleEngine) -- двигатель
	bindKey(plr, "3", "down", doToggleLightsFlash) -- мигание фарами
end

addEventHandler("onResourceStart", resourceRoot, function()
	for _, p in ipairs(getElementsByType("player")) do
		playerBindKey(p)
	end
end)

addEventHandler("onPlayerJoin", root, function()
	playerBindKey(source)
end)


function doToggleLocked(player)
	local veh = getPedOccupiedVehicle(player)
	if not veh or getPedOccupiedVehicleSeat(player) ~= 0 then
		veh = player:getData('player.isVehicle')
		if not isElement(veh) then 
			return
		end
	end

	if isVehicleLocked(veh) then
        setVehicleLocked(veh, false) 
    else                           
        setVehicleLocked(veh, true)
    end

    triggerClientEvent(player, 'operVehicleSystem.doToggleLocked', player)
end

addEventHandler("onVehicleStartExit", root, function(player, seat)
	if isVehicleLocked(source) then 

		triggerClientEvent(
			player, 
			'operNotification.addNotification', 
			player, 
			"Откройте двери!\nНажмите клавишу 'K'", 
			2, 
			true
		)

		cancelEvent() 
		return
	end -- если двери заблокированы, то игрок не сможет выйти!
end)

function doToggleEngine(player)
	local veh = getPedOccupiedVehicle(player)
	if not veh or getPedOccupiedVehicleSeat(player) ~= 0 then return end

	if getVehicleEngineState(veh) then
		setVehicleEngineState(veh, false)
		if getElementData(veh, "vehicle.cruiseSpeedEnabled" ) then
			triggerClientEvent (player, "operVehicleSystem.toggleCruiseSpeed", player) 
		end
		--triggerEvent('exv_fueling.onPlayerEngineSwitch', player, veh) -- EXPORT К СИСТЕМЕ ЗАПРАВКИ
	else
		triggerClientEvent(player, 'operVehicleSystem.doToggleEngine', player)
		setTimer(setVehicleEngineState, 1200, 1, veh, true)
	end

end

local lightsTimer = { }

local function setVehicleLightOn(veh, rl, gl, bl)
	if not isElement(veh) then 
		if isTimer(lightsTimer[veh]) then
			killTimer(lightsTimer[veh])
			lightsTimer[veh] = nil
		end
		return 
	end
	local colorLight = {255, 255, 255}
	
	colorLight = getElementData(veh, 'vehicle.vehLightColor') or {255, 255, 255}

	if rl <= colorLight[1] and rl <= 245 then rl = rl + 10
	else rl = colorLight[1]
	end

	if gl <= colorLight[2] and gl <= 245 then gl = gl + 10 
	else gl = colorLight[2]
	end

	if bl <= colorLight[3] and bl <= 245 then bl = bl + 10
	else bl = colorLight[3] 
	end

	setVehicleHeadLightColor(veh, rl, gl, bl)
	if rl == colorLight[1] and gl == colorLight[2] and bl == colorLight[3] then
		if isTimer(lightsTimer[veh]) then
			killTimer(lightsTimer[veh])
			lightsTimer[veh] = nil
		end
		return
	end

	lightsTimer[veh] = setTimer(setVehicleLightOn, 50, 1, veh, rl, gl, bl)
end

local function setVehicleLightOff(veh, rl, gl, bl)
	if not isElement(veh) then 
		if isTimer(lightsTimer[veh]) then
			killTimer(lightsTimer[veh])
			lightsTimer[veh] = nil
		end
		return 
	end

	if rl >= 15 then rl = rl - 15
	else rl = 0
	end

	if gl >= 15 then gl = gl - 15 
	else gl = 0
	end

	if bl >= 15 then bl = bl - 15
	else bl = 0
	end

	setVehicleHeadLightColor(veh, rl, gl, bl)

	if rl == 0 and gl == 0 and bl == 0 then
		if isTimer(lightsTimer[veh]) then
			killTimer(lightsTimer[veh])
			lightsTimer[veh] = nil
		end
		setVehicleOverrideLights(veh, 1)
		return
	end

	lightsTimer[veh] = setTimer(setVehicleLightOff, 50, 1, veh, rl, gl, bl)
end

function doToggleLights(player)
	local veh = getPedOccupiedVehicle(player)
	if not veh or getPedOccupiedVehicleSeat(player) ~= 0 then return end

	local light = tonumber(getElementData(veh, 'vehicle.vehLightState')) or 0

	if light == 0 then

		if isTimer(lightsTimer[veh]) then
			killTimer(lightsTimer[veh])
			lightsTimer[veh] = nil
		end

		local rl, gl, bl = getVehicleHeadLightColor(veh)
		setElementData(veh, 'vehicle.vehLightState', 1)
		setElementData(veh, 'vehicle.vehLightCurrentState', 0)

		local colorLight = getElementData(veh, 'vehicle.vehLightColor')
		if colorLight then
			rl, gl, bl = colorLight[1], colorLight[2], colorLight[3]
		end

		if rl == 0 and gl == 0 and bl == 0 then
			rl = 255 gl = 255 bl = 255
		end

		setElementData(veh, 'vehicle.vehLightColor', {rl, gl, bl})

		setVehicleHeadLightColor(veh, 0, 0, 0)
		setVehicleOverrideLights(veh, 2)
	elseif light == 1 then
		setVehicleOverrideLights(veh, 2)
		setVehicleHeadLightColor(veh, 0, 0, 0)

		-- ИМИТАЦИЯ РАЗЖИГАНИЯ КСЕНОНА --
		lightsTimer[veh] = setTimer(setVehicleLightOn, 50, 1, veh, 0, 0, 0)
		---------------------------------
		
		setElementData(veh, 'vehicle.vehLightState', 2)
		setElementData(veh, 'vehicle.vehLightCurrentState', 1)
	elseif light == 2 then

		if isTimer(lightsTimer[veh]) then
			killTimer(lightsTimer[veh])
			lightsTimer[veh] = nil
		end

		local colorLight = getElementData(veh, 'vehicle.vehLightColor') or {255, 255, 255}

		lightsTimer[veh] = setTimer(setVehicleLightOff, 50, 1, veh, colorLight[1], colorLight[2], colorLight[3])
		setElementData(veh, 'vehicle.vehLightState', 0)
		setElementData(veh, 'vehicle.vehLightCurrentState', 2)
	end

	triggerClientEvent(player, 'operVehicleSystem.doToggleLights', player)
end

function doToggleLightsFlash(player)
	local veh = getPedOccupiedVehicle(player)
	if not veh or getPedOccupiedVehicleSeat(player) ~= 0 then return end

	local light = tonumber(getElementData(veh, 'vehicle.vehLightCurrentState')) or 2
	local colorLight = getElementData(veh, 'vehicle.vehLightColor') or {255, 255, 255}

	setVehicleOverrideLights(veh, 2)
	setVehicleHeadLightColor(veh, 0, 0, 0)

	setTimer(setVehicleHeadLightColor, 50, 1, veh, colorLight[1], colorLight[2], colorLight[3])


	-- --
	setTimer(setVehicleHeadLightColor, 150, 1, veh, 0, 0, 0)
	--setTimer(setVehicleOverrideLights, 150, 1, veh, 1)

	--[[
	setTimer(function(_veh, _light, _colorLight)

		setVehicleHeadLightColor(_veh, _colorLight[1], _colorLight[2], _colorLight[3])

		if _light == 2 then
			setVehicleOverrideLights(_veh, 1)
		else
			setVehicleOverrideLights(_veh, 2)
		end

	end, 150, 1, veh, light, colorLight)
	]]

	setTimer(function()
		if light == 0 then
			setVehicleHeadLightColor(veh, 0, 0, 0)
			setVehicleOverrideLights(veh, 2)
		elseif light == 1 then
			setVehicleHeadLightColor(veh, colorLight[1], colorLight[2], colorLight[3])
			setVehicleOverrideLights(veh, 2)
		elseif light == 2 then
			setVehicleHeadLightColor(veh, colorLight[1], colorLight[2], colorLight[3])
			setVehicleOverrideLights(veh, 1)
		end
	end, 200, 1)

	-- --

	triggerClientEvent(player, 'operVehicleSystem.doToggleLights', player)
end