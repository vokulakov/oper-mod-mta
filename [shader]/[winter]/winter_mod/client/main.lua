Winter = {}
Textures = {}
Shaders = {}

local isWinterVisible = false

function Winter.start()

	if isWinterVisible then
		return
	end

	for texture, _ in pairs(TEXTURES_SNOW) do
		local sh = dxCreateShader('assets/shaders/shader.fx')
		table.insert(Shaders, sh)
		for _, texname in ipairs(TEXTURES_SNOW[texture]) do
			local txt = dxCreateTexture(texture)

			dxSetShaderValue(sh, "gTexture", txt)
			engineApplyShaderToWorldTexture(sh, texname)

			table.insert(Textures, {texture = txt, shader = sh, texture_name = texname})
		end
	end

		-- РАСТИТЕЛЬНОСТЬ --
	for _, texname in ipairs(TEXTURES) do
		local sh = dxCreateShader('assets/shaders/shader.fx')
		local txt = dxCreateTexture(texname[1])

		dxSetShaderValue(sh, "gTexture", txt)
		engineApplyShaderToWorldTexture(sh, texname[2])

		table.insert(Textures, {texture = txt, shader = sh, texture_name = texname[2]})
		table.insert(Shaders, sh)
	end

	isWinterVisible = true
end

function Winter.stop()
	if not isWinterVisible then
		return
	end

	for _, data in ipairs(Textures) do 
		engineRemoveShaderFromWorldTexture(data.shader, data.texture_name)

	--	destroyElement(data.shader)
		destroyElement(data.texture)
	end

	for _, shader in pairs(Shaders) do
		destroyElement(shader)
	end

	Textures = {}
	Shaders = {}

	isWinterVisible = false
end

addEventHandler('onClientResourceStart', resourceRoot, Winter.start)

addEvent('operWinterMode.setVisibleWinter', true)
addEventHandler('operWinterMode.setVisibleWinter', root, function(state)
	if state then
		Winter.start()
	else
		Winter.stop()
	end
end)