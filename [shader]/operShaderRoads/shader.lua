Roads = {}

Roads.shaders = {}
Roads.isVisible = false

local textures = {
	'vegasdirtyroad3_256.png', 'Tar_1line256HVblend2.png', 'snpedtest1BLND.png', 'desert_1line256.png', 'crossing2_law.png',
	'crossing_law.png', 'dt_road_stoplinea.png', 'Tar_freewyleft.png', 'Tar_freewyright.png', 'Tar_1line256HV.png',
	'sf_junction2.png', 'vegastriproad1_256.png', 'sl_freew2road1.png', 'cos_hiwaymid_256.png',
	'hiwayend_256.png', 'roadnew4_256.png', 'sf_junction1.png', 'des_oldrunway.png'
}

local road_txt = {
	['vegasdirtyroad3_256'] = { 'vegasdirtyroad3_256' },

	['Tar_1line256HVblend2'] = { 'vegasdirtyroad3_256', 'Tar_1line256HVblend2', 'Tar_1line256HVblenddrt', 'Tar_1line256HVblenddrtdot', 
		'Tar_1line256HVgtravel', 'Tar_1line256HVlightsand', 'Tar_lineslipway', 'Tar_venturasjoin', 'conc_slabgrey_256128'
	},

	['snpedtest1BLND'] = { 'ws_freeway3blend', 'snpedtest1BLND', 'vegastriproad1_256' },

	['desert_1line256'] = { 'desert_1line256', 'desert_1linetar', 'roaddgrassblnd' },

	['crossing2_law'] = { 'crossing2_law', 'lasunion994', 'motocross_256' },

	['crossing_law'] = { 'crossing_law', 'crossing_law2', 'crossing_law3', 'sf_junction5' },

	['dt_road_stoplinea'] = { 'dt_road_stoplinea' },

	['Tar_freewyleft'] = { 'Tar_freewyleft' },


	['Tar_freewyright'] = { 'Tar_freewyright' },

	['Tar_1line256HV'] = { 'Tar_1line256HV', 'Tar_1linefreewy', 'des_1line256', 'des_1lineend', 'des_1linetar' },

	['sf_junction2'] = { 'sf_junction2' },

	['vegastriproad1_256'] = { 'vegastriproad1_256', 'ws_freeway3', 'cuntroad01_law', 'roadnew4blend_256', 'sf_road5', 'sl_roadbutt1', 'snpedtest1' },

	['sl_freew2road1'] = { 'sl_freew2road1', 'snpedtest1blend', 'ws_carpark3' },

	['cos_hiwaymid_256'] = { 'cos_hiwaymid_256', 'sf_road5' },

	['hiwayend_256'] = { 'hiwayend_256', 'hiwaymidlle_256', 'vegasroad2_256' },

	['roadnew4_256'] = { 'roadnew4_256', 'roadnew4_512', 'vegasroad1_256', 'dt_road', 'vgsN_road2sand01', 'hiwayoutside_256', 'vegasdirtyroad1_256', 
		'vegasdirtyroad2_256', 'vegasroad3_256' 
	},

	['sf_junction1'] = { 'sf_junction1', 'sf_junction3' },

	['des_oldrunway'] = { 'des_panelconc', 'plaintarmac1' }
}


function startRoadShader()
	if Roads.isVisible then
		return
	end

	for _, txt in pairs(textures) do

		local shader = dxCreateShader("shader.fx")
		if shader then 
			local texture = dxCreateTexture("img/"..txt, "dxt3")
	
			dxSetShaderValue(shader, "gTexture", texture)

			local shaderRoads = {}
			for _, road in ipairs(road_txt[string.gsub(txt, ".png", "")]) do
				table.insert(shaderRoads, road)
				engineApplyShaderToWorldTexture(shader, road)
			end

			table.insert(Roads.shaders, {shader = shader, texture = texture, road = shaderRoads})
		end
	end

	Roads.isVisible = true
end


function stopRoadShader()
	if not Roads.isVisible then
		return
	end

	for i, shader in ipairs(Roads.shaders) do
		for _, road in ipairs(shader.road) do
			engineRemoveShaderFromWorldTexture(shader.shader, road)
		end

		destroyElement(shader.shader)
		destroyElement(shader.texture)

	end

	Roads.shaders = {}
	Roads.isVisible = false
end
