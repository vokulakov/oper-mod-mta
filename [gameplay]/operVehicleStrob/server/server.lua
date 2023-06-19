Strob = {}

function Strob.addVehicle(vehicle, strob_type, strob_sec, strob_fls)
	if not isElement(vehicle) then
		return
	end

	if not Strob[vehicle] then
		Strob[vehicle] = {}
	end

	if strob_type == 'police' then
		Strob.addPoliceLights(vehicle, strob_sec)
	elseif strob_type == 'color' then
		Strob[vehicle].isTimer = setTimer(function()
			Strob.addColorStrob(vehicle, strob_fls)
		end, strob_sec, 0)
	end
end

function Strob.addColorStrob(vehicle, strob_fls)
	-- getVehicleOverrideLights(vehicle) == 1 - фары включены
	-- getVehicleOverrideLights(vehicle) == 2 - фары включены

	if not isElement(vehicle) then
		return
	end

	if not strob_fls then
        if (getVehicleOverrideLights(vehicle) ~= 2) then
		    setVehicleOverrideLights(vehicle, 2)
			setVehicleHeadLightColor(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        else	
			setVehicleOverrideLights(vehicle, 2)
			setVehicleHeadLightColor(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))	
        end
	else
		if (getVehicleOverrideLights(vehicle) ~= 2) then
	      	setVehicleOverrideLights(vehicle, 2)
		  	setVehicleHeadLightColor(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        else	
          	setVehicleOverrideLights(vehicle, 1)
		  	setVehicleHeadLightColor(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))	
        end
	end
end

function Strob.removeColorStrob(vehicle)
	if not isElement(vehicle) or not Strob[vehicle] then
		return
	end

	if isTimer(Strob[vehicle].isTimer) then
		killTimer(Strob[vehicle].isTimer)
	end

	setVehicleLightState(vehicle, 0, 0)
	setVehicleLightState(vehicle, 1, 0)
	setVehicleLightState(vehicle, 2, 0)
	setVehicleLightState(vehicle, 3, 0)	

	setVehicleHeadLightColor(vehicle, 255, 255, 255)
	setVehicleOverrideLights(vehicle, 2)

	Strob[vehicle] = nil
end

function Strob.removePoliceLights(vehicle)
	if not isElement(vehicle) or not Strob[vehicle] or not Strob[vehicle]['police'] then
		return
	end

	if isTimer(Strob[vehicle]['police'].isTimer) then
		killTimer(Strob[vehicle]['police'].isTimer)
	end

	setVehicleLightState(vehicle, 0, 0)
	setVehicleLightState(vehicle, 1, 0)
	setVehicleLightState(vehicle, 2, 0)
	setVehicleLightState(vehicle, 3, 0)	

	setVehicleHeadLightColor(vehicle, 255, 255, 255)
	setVehicleOverrideLights(vehicle, 2)

	Strob[vehicle]['police'] = nil
end

function Strob.addPoliceLights(vehicle, level)
	if not isElement(vehicle) then
		return
	end

	Strob[vehicle]['police'] = {}

	Strob[vehicle]['police'].isActive = 0 
	Strob[vehicle]['police'].isState = false

	if level == 1 then
		if (Strob[vehicle]['police'].isActive == 0) then

			Strob[vehicle]['police'].isActive = 1
			setVehicleOverrideLights(vehicle, 2)

			Strob[vehicle]['police'].isTimer = setTimer(function(vehicle)
				if not Strob[vehicle]['police'].isState then
					Strob[vehicle]['police'].isState = true

					setVehicleLightState(vehicle, 1, 0)
					setVehicleLightState(vehicle, 2, 0)
					setVehicleLightState(vehicle, 0, 1)
					setVehicleLightState(vehicle, 3, 1)
					setVehicleHeadLightColor(vehicle, 0, 0, 255)
				else
					setVehicleLightState(vehicle, 3, 0)
					setVehicleLightState(vehicle, 0, 0)
					setVehicleLightState(vehicle, 1, 1)
					setVehicleLightState(vehicle, 2, 1)	
					setVehicleHeadLightColor(vehicle, 255, 0, 0)

					Strob[vehicle]['police'].isState = false
				end
			end, 500, 0, vehicle)

		else
			Strob.removePoliceLights(vehicle)
		end
	elseif level == 2 then
		if (Strob[vehicle]['police'].isActive == 0) then

			Strob[vehicle]['police'].isActive = 1
			Strob[vehicle]['police'].is2LevelCount = 0
			Strob[vehicle]['police'].is2LevelCount_1 = 0

			setVehicleOverrideLights(vehicle, 2)

			Strob[vehicle]['police'].isTimer = setTimer(function(vehicle)

				if (Strob[vehicle]['police'].is2LevelCount == 4) then
					setTimer(function() 
						if not isElement(vehicle) or not Strob[vehicle]['police'] then
							return
						end

						Strob[vehicle]['police'].is2LevelCount = 0 
					end, 1000, 1)

					setTimer(function(vehicle)
						if not isElement(vehicle) or not Strob[vehicle]['police'] then
							return
						end

						if (Strob[vehicle]['police'].is2LevelCount_1 == 1) then
							Strob[vehicle]['police'].is2LevelCount_1 = 0
							setVehicleLightState(vehicle, 1, 0)
							setVehicleLightState(vehicle, 2, 0)
							setVehicleLightState(vehicle, 0, 1)
							setVehicleLightState(vehicle, 3, 1)
							setVehicleHeadLightColor(vehicle, 77, 77, 255)
						else
							setVehicleLightState(vehicle, 3, 0)
							setVehicleLightState(vehicle, 0, 0)
							setVehicleLightState(vehicle, 1, 1)
							setVehicleLightState(vehicle, 2, 1)	
							setVehicleHeadLightColor(vehicle, 255, 77, 77)
							
							Strob[vehicle]['police'].is2LevelCount_1 = 1
						end

					end, 50, 5, vehicle)

					return
				end

				if not Strob[vehicle]['police'].isState then
					Strob[vehicle]['police'].isState = true

					setVehicleLightState(vehicle, 1, 0)
					setVehicleLightState(vehicle, 2, 0)
					setVehicleLightState(vehicle, 0, 1)
					setVehicleLightState(vehicle, 3, 1)
					setVehicleHeadLightColor(vehicle, 0, 0, 255)
				else
					setVehicleLightState(vehicle, 3, 0)
					setVehicleLightState(vehicle, 0, 0)
					setVehicleLightState(vehicle, 1, 1)
					setVehicleLightState(vehicle, 2, 1)	
					setVehicleHeadLightColor(vehicle, 255, 0, 0)

					Strob[vehicle]['police'].isState = false
				end

				Strob[vehicle]['police'].is2LevelCount = Strob[vehicle]['police'].is2LevelCount + 1

			end, 500, 0, vehicle)
		else
			Strob.removePoliceLights(vehicle)
		end
	end
end

function Strob.startPrewiew(vehicle, strob_data)
	if not isElement(vehicle) then
		return
	end

	if Strob[vehicle] then
		if Strob[vehicle]['police'] then
			Strob.removePoliceLights(vehicle)
		end
		
		Strob.removeColorStrob(vehicle)
	end

	if type(strob_data) == 'number' then -- полицейские
		Strob.addVehicle(vehicle, 'police', strob_data)
	else
		Strob.addVehicle(vehicle, 'color', strob_data[1], strob_data[2])
	end
end
addEvent('operVehicleStrob.startPrewiew', true)
addEventHandler('operVehicleStrob.startPrewiew', root, Strob.startPrewiew)

function Strob.stopPrewiew(vehicle)
	if not isElement(vehicle) or not Strob[vehicle] then
		return
	end

	Strob.removePoliceLights(vehicle)
	Strob.removeColorStrob(vehicle)

	local currentStrob = vehicle:getData('vehicle.isStrob') 

	if currentStrob then
		if type(currentStrob) == 'number' then -- полицейские
			Strob.addVehicle(vehicle, 'police', currentStrob)
		else
			Strob.addVehicle(vehicle, 'color', currentStrob[1], currentStrob[2])
		end
	end
end
addEvent('operVehicleStrob.stopPrewiew', true)
addEventHandler('operVehicleStrob.stopPrewiew', root, Strob.stopPrewiew)

function Strob.setVehicle(vehicle, strob_data)
	if not isElement(vehicle) then
		return
	end

	Strob.removePoliceLights(vehicle)
	Strob.removeColorStrob(vehicle)

	if type(strob_data) == 'number' then -- полицейские
		Strob.addVehicle(vehicle, 'police', strob_data)
	elseif type(strob_data) == 'table' then
		Strob.addVehicle(vehicle, 'color', strob_data[1], strob_data[2])
	end

	vehicle:setData('vehicle.isStrob', strob_data)
end
addEvent('operVehicleStrob.setVehicle', true)
addEventHandler('operVehicleStrob.setVehicle', root, Strob.setVehicle)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
	for _, v in ipairs(getElementsByType("vehicle")) do
		local currentStrob = v:getData('vehicle.isStrob') 

		if currentStrob then
			if type(currentStrob) == 'number' then -- полицейские
				Strob.addVehicle(v, 'police', currentStrob)
			else
				Strob.addVehicle(v, 'color', currentStrob[1], currentStrob[2])
			end
		end
	end
end)

addEventHandler("onElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		local currentStrob = source:getData('vehicle.isStrob') 

		if currentStrob then
			Strob.removePoliceLights(source)
			Strob.removeColorStrob(source)

			source:removeData('vehicle.isStrob')
		end
	end
end)
