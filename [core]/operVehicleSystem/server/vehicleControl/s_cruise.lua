addEvent("operVehicleSystem.enableVehicleCruiseSpeed", true)
addEventHandler ("operVehicleSystem.enableVehicleCruiseSpeed", getRootElement (), function (state) 
	if state then 
		setElementSyncer (source, getVehicleController (source))
	else 		
		setElementSyncer (source, true)
	end
end)


addEventHandler("onVehicleStartExit", root, function(thePlayer, seat)
	if getElementData(source, "vehicle.cruiseSpeedEnabled") and seat == 0 then
		triggerClientEvent(thePlayer, "operVehicleSystem.toggleCruiseSpeed", thePlayer) 
	end
end)