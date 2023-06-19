VehicleVinyls = {}

function VehicleVinyls.setVehicleVinyls(vehicle, vinyl_id, currentColorType, r1, g1, b1, r2, g2, b2)
	if not isElement(vehicle) then
		return
	end

	if vinyl_id then -- установка винила
		setVehicleColor(vehicle, 255, 255, 255, 255, 255, 255)
		vehicle:setData('vehicle.colorType', false) 
		vehicle:setData('vehicle.isVinyl', tonumber(vinyl_id))
	else
		vehicle:setData('vehicle.colorType', currentColorType) 
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		vehicle:removeData('vehicle.isVinyl')
	end	

end
addEvent('operVehicleVinyl.setVehicleVinyls', true)
addEventHandler('operVehicleVinyl.setVehicleVinyls', root, VehicleVinyls.setVehicleVinyls)