local SOUNDS = { }

addEvent('operVehicleSystem.doToggleLights', true)
addEventHandler('operVehicleSystem.doToggleLights', root, function()
	if isElement(SOUNDS.light) then
		destroyElement(SOUNDS.light)
	end

	SOUNDS.light = exports.operSounds:playSound('veh_lightswitch')
end)

addEvent('operVehicleSystem.doToggleLocked', true)
addEventHandler('operVehicleSystem.doToggleLocked', root, function()
	if isElement(SOUNDS.lock) then
		destroyElement(SOUNDS.lock)
	end

	SOUNDS.lock = exports.operSounds:playSound('veh_doorlock')
end)

addEvent('operVehicleSystem.doToggleEngine', true)
addEventHandler('operVehicleSystem.doToggleEngine', root, function()
	if isElement(SOUNDS.engine) then
		destroyElement(SOUNDS.engine)
	end

	SOUNDS.engine = exports.operSounds:playSound('veh_starter_car')
end)
