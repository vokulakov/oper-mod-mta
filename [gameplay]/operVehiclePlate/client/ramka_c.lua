Ramka = {}

Ramka.shaders = {}
-- ram
-- nomer
Ramka.textures = {
	ram_0 = dxCreateTexture("assets/texture/ram/ram_0.png"),
	ram_1 = dxCreateTexture("assets/texture/ram/ram_1.png"),
	ram_2 = dxCreateTexture("assets/texture/ram/ram_2.png"),
	ram_3 = dxCreateTexture("assets/texture/ram/ram_3.png"),
	ram_4 = dxCreateTexture("assets/texture/ram/ram_4.png")
	
}

function Ramka.getTexture()
	local renderTarget = dxCreateRenderTarget(1024, 256, true)
	dxSetRenderTarget(renderTarget)
		dxDrawImage(0, -4, 1024, 256, Ramka.textures.ram_0)
	dxSetRenderTarget()

	local texture = dxCreateTexture(dxGetTexturePixels(renderTarget))
	destroyElement(renderTarget)

	return texture
end


function Ramka.setVehicleRamka(vehicle)
	if not isElement(vehicle) then
		return
	end

	if not Ramka.shaders[vehicle] then
		Ramka.shaders[vehicle] = dxCreateShader("assets/texreplace.fx")
	end


	engineApplyShaderToWorldTexture(Ramka.shaders[vehicle], "ram", vehicle)


	dxSetShaderValue(Ramka.shaders[vehicle], "gTexture", Ramka.getTexture())
end

function Ramka.destroyVehicleRamka(vehicle)
	if not isElement(vehicle) then
		return
	end

	if not Ramka.shaders[vehicle] then
		return
	end

	engineRemoveShaderFromWorldTexture(Ramka.shaders[vehicle], "ram", vehicle)
	destroyElement(Ramka.shaders[vehicle])

	Ramka.shaders[vehicle] = nil
end