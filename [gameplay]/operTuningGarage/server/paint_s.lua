addEvent("operTuningGarage.setVehicleColor", true)
addEventHandler("operTuningGarage.setVehicleColor", root, function(r, g, b, r1, g1, b1, r2, g2, b2)
	if not source.vehicle then
        return
    end

	setVehicleColor(source.vehicle, r, g, b, r2, g2, b2)
	source.vehicle:removeData('vehicle.isVinyl')
end)