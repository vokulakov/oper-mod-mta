VehicleVinyls = {}

VehicleVinyls.img = {
	"assets/textures/1.png", 	"assets/textures/2.png", 	"assets/textures/3.png", 	"assets/textures/4.png", 	"assets/textures/5.png", 	"assets/textures/6.png", 
	"assets/textures/7.png", 	"assets/textures/8.png", 	"assets/textures/9.png", 	"assets/textures/10.png", 	"assets/textures/11.png", 	"assets/textures/12.png", 
	"assets/textures/13.png", 	"assets/textures/14.png", 	"assets/textures/15.png", 	"assets/textures/16.png", 	"assets/textures/17.png", 	"assets/textures/18.png",
	"assets/textures/19.png", 	"assets/textures/20.png", 	"assets/textures/21.png", 	"assets/textures/22.png", 	"assets/textures/23.png", 	"assets/textures/24.png",
	"assets/textures/25.png", 	"assets/textures/26.png", 	"assets/textures/27.png", 	"assets/textures/28.png", 	"assets/textures/29.png", 	"assets/textures/30.png",
	"assets/textures/31.png", 	"assets/textures/32.png", 	"assets/textures/33.png", 	"assets/textures/34.png", 	"assets/textures/35.png", 	"assets/textures/36.png",
	"assets/textures/37.png", 	"assets/textures/38.png", 	"assets/textures/39.png", 	"assets/textures/40.png", 	"assets/textures/41.png", 	"assets/textures/42.png",
	"assets/textures/43.png", 	"assets/textures/44.png", 	"assets/textures/45.png", 	"assets/textures/46.png", 	"assets/textures/47.png", 	"assets/textures/48.png",
	"assets/textures/49.png", 	"assets/textures/50.png", 	"assets/textures/51.png", 	"assets/textures/52.png", 	"assets/textures/53.png", 	"assets/textures/54.png",
	"assets/textures/55.png",	"assets/textures/56.png",	"assets/textures/57.png", --[["assets/textures/58.png", --"assets/textures/59.png", --"assets/textures/60.png",]]
--[["assets/textures/61.png", --"assets/textures/62.png",]] "assets/textures/63.png",	"assets/textures/64.png",	"assets/textures/65.png",	"assets/textures/66.png",
	"assets/textures/67.png",	"assets/textures/68.png",	"assets/textures/69.png",	"assets/textures/70.png",	"assets/textures/71.png",	"assets/textures/72.png",
	"assets/textures/73.png",	"assets/textures/74.png",	"assets/textures/75.png",	"assets/textures/76.png",	"assets/textures/77.png",	"assets/textures/78.png",
	"assets/textures/79.png",	"assets/textures/80.png",	"assets/textures/81.png",	"assets/textures/82.png",	"assets/textures/83.png",	"assets/textures/84.png",
	"assets/textures/85.png",--[["assets/textures/86.png",]]"assets/textures/87.png"
}

VehicleVinyls.textures = {}

VehicleVinyls.shader_texture = { 'remap', 'body', 'remap_body' }

function VehicleVinyls.getTexture(txt)
	local renderTarget = dxCreateRenderTarget(512, 512, true)

	dxSetRenderTarget(renderTarget)
		dxDrawImage(0, 0, 512, 512, txt)
	dxSetRenderTarget()

	local texture = dxCreateTexture(dxGetTexturePixels(renderTarget))
	destroyElement(renderTarget)

	return texture
end

VehicleVinyls.vehicles = {}

function VehicleVinyls.setVehicleVinyl(vehicle, vinyl_id)

	if not isElement(vehicle) then
		return 
	end

	if not VehicleVinyls.vehicles[vehicle] then
		VehicleVinyls.vehicles[vehicle] = dxCreateShader("assets/texreplace.fx")
	end

	for _, item in pairs(VehicleVinyls.shader_texture) do
		engineApplyShaderToWorldTexture(VehicleVinyls.vehicles[vehicle], item, vehicle)
	end

	dxSetShaderValue(
		VehicleVinyls.vehicles[vehicle], 
		"TEXTURE_REMAP", 
		VehicleVinyls.getTexture(VehicleVinyls.textures[vinyl_id])
	)

end

function VehicleVinyls.updateVehicleVinul(vehicle, vinyl_id)
	if not isElement(vehicle) then
		return 
	end

	if not VehicleVinyls.vehicles[vehicle] then
		return VehicleVinyls.setVehicleVinyl(vehicle, vinyl_id)
	end

	dxSetShaderValue(
		VehicleVinyls.vehicles[vehicle], 
		"TEXTURE_REMAP", 
		VehicleVinyls.getTexture(VehicleVinyls.textures[vinyl_id])
	)

end

function VehicleVinyls.destroyVehicleVinyl(vehicle)
	if not isElement(vehicle) then
		return
	end

	if not VehicleVinyls.vehicles[vehicle] then
		return
	end

	for _, item in pairs(VehicleVinyls.shader_texture) do
		engineRemoveShaderFromWorldTexture(VehicleVinyls.vehicles[vehicle], item, vehicle)
	end

	destroyElement(VehicleVinyls.vehicles[vehicle])
	VehicleVinyls.vehicles[vehicle] = nil
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, item in pairs(VehicleVinyls.img) do
		table.insert(VehicleVinyls.textures, dxCreateTexture(item))
	end

	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(vehicle) then
			local vinyl_id = vehicle:getData('vehicle.isVinyl')

			if vinyl_id then
				VehicleVinyls.setVehicleVinyl(vehicle, vinyl_id)
			end
		end
	end

end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	for _, texture in pairs(VehicleVinyls.textures) do
		destroyElement(texture)
	end

	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		if VehicleVinyls.vehicles[vehicle] then
			VehicleVinyls.destroyVehicleVinyl(vehicle)
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
		local vinyl_id = source:getData('vehicle.isVinyl')

		if vinyl_id then
			VehicleVinyls.setVehicleVinyl(source, vinyl_id)
		end
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
       	if VehicleVinyls.vehicles[source] then
			VehicleVinyls.destroyVehicleVinyl(source)
		end
    end
end)

addEventHandler("onClientElementDestroy", root, function()
    if source and getElementType(source) == "vehicle" then
       	if VehicleVinyls.vehicles[source] then
			VehicleVinyls.destroyVehicleVinyl(source)
		end
    end
end)


addEventHandler("onClientElementDataChange", root, function(data, _, state)
	if not getElementType(source) == "vehicle" then return end

	if data == 'vehicle.isVinyl' and isElementStreamedIn(source) then
		local vinyl_id = source:getData('vehicle.isVinyl')

		if vinyl_id then
			VehicleVinyls.setVehicleVinyl(source, vinyl_id)
		else
			VehicleVinyls.destroyVehicleVinyl(source)
		end
	end
end)