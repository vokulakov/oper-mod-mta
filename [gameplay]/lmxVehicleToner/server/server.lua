function setVehicleDefaultToner(vehicle)
    if not isElement(vehicle) then
        return
    end

    vehicle:setData('vehicle.isToner', 
	    {
	    	['zad_steklo'] = {type = 'color', r = 10, g = 10, b = 10, a = 255},
	    	['pered_steklo'] = {type = 'color', r = 10, g = 10, b = 10, a = 255},
	    	['lob_steklo'] = {type = 'color', r = 10, g = 10, b = 10, a = 255}
	    }
    ) 

end
