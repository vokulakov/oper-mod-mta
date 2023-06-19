addEventHandler( "onClientResourceStart", getResourceRootElement(), function()
    bindKey("vehicle_fire", "both", toggleNOS)
    bindKey("vehicle_secondary_fire", "both", toggleNOS)
    
    nitroShader = dxCreateShader("nitro.fx")
    engineApplyShaderToWorldTexture(nitroShader,"smoke")
    dxSetShaderValue(nitroShader, "gNitroColor", 0, 0, 0) -- Цвет R, G, B.
end)

function toggleNOS(key, state)
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if veh and not isEditingPosition then
		if state == "up" then
			removeVehicleUpgrade(veh, 1010)
			setPedControlState(localPlayer, "vehicle_fire", false)
		else
			addVehicleUpgrade(veh, 1010)
		end
	end
end
