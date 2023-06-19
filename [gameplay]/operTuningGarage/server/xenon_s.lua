addEvent("operTuningGarage.setXenonVehicle", true)
addEventHandler("operTuningGarage.setXenonVehicle", root, function(r, g, b)
	local vehicle = source.vehicle

	if not vehicle then 
		return 
	end
	
	setVehicleHeadLightColor(vehicle, r, g, b)

	--outputDebugString(r..' '..g..' '..b)
	setElementData(vehicle, 'vehicle.vehLightColor', {r, g, b})
	setElementData(vehicle, 'vehicle.vehLightState', 0)
	setVehicleOverrideLights(vehicle, 1)
end)