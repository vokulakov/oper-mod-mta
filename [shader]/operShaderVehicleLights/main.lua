local texturesimg = {
	{"assets/1.png", "collisionsmoke"},
	{"assets/2.png", "particleskid"},
	{"assets/3.png", "cardebris_01"},
	{"assets/3.png", "cardebris_02"},
	{"assets/3.png", "cardebris_03"},
	{"assets/3.png", "cardebris_04"},
	{"assets/3.png", "cardebris_05"},
	{"assets/Flare.png", "coronastar"},
	{"assets/4.png", "headlight1"},
	{"assets/5.png", "headlight"},
	{"assets/off.png", "vehiclelights128"},
	{"assets/on.png", "vehiclelightson128"},
}

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i = 1, #texturesimg do
		local shader = dxCreateShader("assets/texreplace.fx")
		engineApplyShaderToWorldTexture(shader, texturesimg[i][2])
		dxSetShaderValue(shader, "TEXTURE_REMAP", dxCreateTexture(texturesimg[i][1]))
	end
end)
