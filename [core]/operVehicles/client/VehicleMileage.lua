Mileage = {}

local previousPosition = Vector3()
local metersMul = 0.84178
local currentMileage = 0

function Mileage.calculate()
	local vehicle = localPlayer.vehicle
	if not vehicle or vehicle.controller ~= localPlayer then
		return
	end

	-- Пробег
	local neux, neuy, neuz = getElementPosition(vehicle)

	if not altx or not alty or not altz then
		altx, alty, altz = getElementPosition(vehicle)
	end
	
	local driveTotal = getDistanceBetweenPoints3D(neux, neuy, neuz, altx, alty, altz) * metersMul -- в метрах
	altx, alty, altz = neux, neuy, neuz

	currentMileage = currentMileage + driveTotal
	vehicle:setData("mileage", currentMileage)

	--dxDrawText(currentMileage, 200, 200, 200, 200)
end 

addEventHandler("onClientPlayerVehicleEnter", root, function()
	if source ~= localPlayer then
		return
	end
	currentMileage = localPlayer.vehicle:getData("mileage") or 0
	addEventHandler("onClientRender", root, Mileage.calculate)
	previousPosition = localPlayer.position
end)

addEventHandler("onClientVehicleStartExit", root, function(thePlayer, seat)
    if thePlayer == localPlayer and seat == 0 then
        removeEventHandler("onClientRender", root, Mileage.calculate)
    end
end)

addEventHandler("onClientPlayerVehicleExit", root, function()
	if source ~= localPlayer then
		return
	end
	removeEventHandler("onClientRender", root, Mileage.calculate)
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" and getPedOccupiedVehicle(localPlayer) == source then
		removeEventHandler("onClientRender", root, Mileage.calculate)
	end
end)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	if not getPedOccupiedVehicle(source) then return end
	removeEventHandler("onClientRender", root, Mileage.calculate)
end)