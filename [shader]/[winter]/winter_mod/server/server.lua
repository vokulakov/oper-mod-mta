addEventHandler('onPlayerContact', getRootElement(), function(prev, current)
	if (current) then
		if getElementType(current) ~= 'object' then return end
		if getElementModel(current) == 2263 then
			setPedWalkingStyle(source, 138) 
		end
	else
		if getElementType(prev) ~= 'object' then return end
		if getElementModel(prev) == 2263 then
			setPedWalkingStyle(source, 0) 
		end
	end
end)
--[[
addEventHandler('onPlayerVehicleEnter', getRootElement(), function(veh, seat)
	if seat ~= 0 then return end
	setVehicleHandling(veh, "tractionMultiplier", 0.4)
	setVehicleHandling(veh, "brakeDeceleration", 2.0)
end)
]]