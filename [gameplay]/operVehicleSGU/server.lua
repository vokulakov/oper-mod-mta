function createSound(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	if (isPedInVehicle(thePlayer)) then
		local vehicle = getPedOccupiedVehicle(thePlayer)
		triggerClientEvent(root, "playTheSound", root, x, y, z, vehicle)
	end
end

function createSound2(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	if (isPedInVehicle(thePlayer)) then
		local vehicle = getPedOccupiedVehicle(thePlayer)
		triggerClientEvent(root, "playTheSound2", root, x, y, z, vehicle)
	end
end

function createSound3(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	if (isPedInVehicle(thePlayer)) then
		local vehicle = getPedOccupiedVehicle(thePlayer)
		triggerClientEvent(root, "playTheSound3", root, x, y, z, vehicle)
	end
end

function createSound4(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	if (isPedInVehicle(thePlayer)) then
		local vehicle = getPedOccupiedVehicle(thePlayer)
		triggerClientEvent(root, "playTheSound4", root, x, y, z, vehicle)
	end
end

function deleteSound(thePlayer)
    triggerClientEvent("stopTheSound", root)
end

function deleteSound2(thePlayer)
    triggerClientEvent("stopTheSound2", root)
end

function deleteSound3(thePlayer)
    triggerClientEvent("stopTheSound3", root)
end

function deleteSound4(thePlayer)
    triggerClientEvent("stopTheSound4", root)
end

--[[
function bindKeys()
    bindKey(source, "m", "down", createSound)
    bindKey(source, ",", "down", createSound2)
    bindKey(source, ".", "down", createSound3)
    bindKey(source, "/", "down", createSound4)
	bindKey(source, "m", "up", deleteSound)
    bindKey(source, ",", "up", deleteSound2)
    bindKey(source, ".", "up", deleteSound3)
    bindKey(source, "/", "up", deleteSound4)
end
addEventHandler("onPlayerJoin", getRootElement(), bindKeys)
--]]


addEventHandler("onPlayerVehicleEnter", root, function(vehicle, seat)
	if seat ~= 0 then
		return
	end

	bindKey(source, "m", "down", createSound)
    bindKey(source, ",", "down", createSound2)
    bindKey(source, ".", "down", createSound3)
    bindKey(source, "/", "down", createSound4)
	bindKey(source, "m", "up", deleteSound)
    bindKey(source, ",", "up", deleteSound2)
    bindKey(source, ".", "up", deleteSound3)
    bindKey(source, "/", "up", deleteSound4)
end)

addEventHandler("onPlayerVehicleExit", root, function()
	unbindKey(source, "m", "down", createSound)
    unbindKey(source, ",", "down", createSound2)
    unbindKey(source, ".", "down", createSound3)
    unbindKey(source, "/", "down", createSound4)
	unbindKey(source, "m", "up", deleteSound)
    unbindKey(source, ",", "up", deleteSound2)
    unbindKey(source, ".", "up", deleteSound3)
    unbindKey(source, "/", "up", deleteSound4)
end)