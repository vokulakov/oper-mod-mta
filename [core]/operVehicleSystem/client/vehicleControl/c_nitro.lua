VehiclesNitro = {}

function VehiclesNitro.toggleNOS(_, state)
	local veh = localPlayer.vehicle

	if not isElement(veh) then
		return
	end

	if state == "up" then
		removeVehicleUpgrade(veh, 1010)
		setControlState("vehicle_fire", false)
	else
		addVehicleUpgrade(veh, 1010)
	end
end

addEvent('operVehicleSystem.onRealDriveBySwitch', true)
addEventHandler('operVehicleSystem.onRealDriveBySwitch', root, function()
	bindKey("vehicle_fire", "both", VehiclesNitro.toggleNOS)
	bindKey("vehicle_secondary_fire", "both", VehiclesNitro.toggleNOS)
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	bindKey("vehicle_fire", "both", VehiclesNitro.toggleNOS)
	bindKey("vehicle_secondary_fire", "both", VehiclesNitro.toggleNOS)
end)
