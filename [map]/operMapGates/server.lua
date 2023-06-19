-- Шлагбаумы

local barrierturn = {
	{x = 997.70001, y = 1707.6, z = 9.9, rot = 270, colY = 3},
	{x = 997.70001, y = 1758.9, z = 9.9, rot = 90, colY = - 3}
}

local theBarrierturn = {}

addEventHandler('onResourceStart', resourceRoot, function()
	for _, data in ipairs(barrierturn) do
		local barrier = createObject(968, data.x, data.y, data.z + 0.7, 0, -90, data.rot)
		local colSphere = createColSphere(data.x, data.y + data.colY, data.z, 5.0) 

		theBarrierturn[colSphere] = {barrier = barrier}
	end
end)

addEventHandler("onColShapeHit", root, function(player)
	if (player.type == "player") then
		if not player.vehicle or player.vehicle.controller ~= player then
			return
		end
	end

	if not theBarrierturn[source] then return end

	if theBarrierturn[source].isOpen then
		return
	end 

	local x, y, z = getElementPosition(theBarrierturn[source].barrier)
	
	moveObject(theBarrierturn[source].barrier, 2000, x, y, z, 0, 90, 0, "OutBounce")
	triggerClientEvent(player, 'operNotification.addNotification', player, "Шлагбаум открыт на 10 сек.", 1, true)
	theBarrierturn[source].isOpen = true

	setTimer(
		function(sphere)
			local x, y, z = getElementPosition(theBarrierturn[sphere].barrier)
			moveObject(theBarrierturn[sphere].barrier, 2000, x, y, z, 0, -90, 0, "OutBounce")
		end, 10000, 1, source)

	setTimer(
		function(sphere)
			theBarrierturn[sphere].isOpen = false
		end, 13000, 1, source)
end)

--[[
addEventHandler("onColShapeLeave", root, function(player)
	if (player.type == "player") then
		if not player.vehicle or player.vehicle.controller ~= player then
			return
		end
	end

	if not theBarrierturn[source] then return end
	
	if theBarrierturn[source].isOpen then
		if #getElementsWithinColShape(source, "vehicle") > 1 then
			return
		end

		setTimer(
			function(sphere)
				local x, y, z = getElementPosition(theBarrierturn[sphere].barrier)
				moveObject(theBarrierturn[sphere].barrier, 2000, x, y, z, 0, -90, 0, "OutBounce")
			end, 2000, 1, source)

		setTimer(
			function(sphere)
				theBarrierturn[sphere].isOpen = false
			end, 3000, 1, source)

	end
end)
]]

-- ВОРОТА В ОТДЕЛЕ --
local isGateOpen
local theTimer 


local gLeft 	= createObject(901, 963.59997558594, 1780.5, 7.9000000953674)
local gRight 	= createObject(901, 963.59997558594, 1786.5, 7.9000000953674)

local colSphere = createColSphere(963.5, 1783.2, 7.9000000953674, 8.0) 

addEventHandler("onColShapeHit", colSphere, function(player)
	if (player.type == "player") then
		if not player.vehicle or player.vehicle.controller ~= player then
        	return
    	end

    	if isTimer(theTimer) then 
    		killTimer(theTimer)
    		theTimer = nil
    	end

    	if isGateOpen then
    		return
    	end

    	setTimer(
    		function()
    			moveObject(gLeft, 9000, 963.59997558594, 1780.5 - 5, 7.9000000953674)
    			moveObject(gRight, 9000, 963.59997558594, 1786.5 + 5, 7.9000000953674)
    		end,
    	500, 1)

    	triggerClientEvent(player, 'operOtdelGates.playGatesSound', player, true)
    	isGateOpen = true
    end
end)

addEventHandler("onColShapeLeave", colSphere, function(player)
	if (player.type == "player") then
		if not player.vehicle or player.vehicle.controller ~= player then
        	return
    	end
		
		if isGateOpen then
			if #getElementsWithinColShape(colSphere, "vehicle") > 1 then
				return
			end

			theTimer = setTimer(
				function()
					moveObject(gLeft, 10000, 963.59997558594, 1780.5, 7.9000000953674)

    				moveObject(gRight, 10000, 963.59997558594, 1786.5, 7.9000000953674)

    				triggerClientEvent(player, 'operOtdelGates.playGatesSound', player, false)

    				isGateOpen = false
    			end,
    		5000, 1)

		end

	end
end)