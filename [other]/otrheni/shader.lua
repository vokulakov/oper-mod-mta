local renderDistance = 500
local filmDepth = 100.08
local filmIntensity = 1000.21
local filmDepthEnable = true
            -- Грязь
	local texturegrun = {
			"predator92body128", "monsterb92body256a", "monstera92body256a", "andromeda92wing","fcr90092body128",
			"hotknifebody128b", "hotknifebody128a", "rcbaron92texpage64", "rcgoblin92texpage128", "rcraider92texpage128", 
			"rctiger92body128","rhino92texpage256", "petrotr92interior128","artict1logos","rumpo92adverts256","dash92interior128",
			"coach92interior128","combinetexpage128","hotdog92body256",
			"raindance92body128", "cargobob92body256", "andromeda92body", "at400_92_256", "nevada92body256",
			"polmavbody128a" , "sparrow92body128" , "hunterbody8bit256a" , "seasparrow92floats64" , 
			"dodo92body8bit256" , "cropdustbody256", "beagle256", "hydrabody256", "rustler92body256", 
			"shamalbody256", "skimmer92body128", "stunt256", "maverick92body128", "leviathnbody8bit256" }

function startCarPaint()
		if cpEffectEnabled then return end
		    -- Шeйдeра
		     myShader, tec = dxCreateShader ( "file/car_paint.fx",1 ,renderDistance ,false)
		     myWind, tec = dxCreateShader ( "file/windows.fx",1 ,renderDistance ,false)
		     myFara, tec = dxCreateShader ( "file/fara.fx",1 ,renderDistance ,false)
		     carbon, tec = dxCreateShader ( "file/carbon.fx",1 ,renderDistance ,false)

		if myShader then
			outputConsole( "Using technique " .. tec )
            -- Тeкстура
			textureCube = dxCreateTexture ( "file/images/reflx.dds" )
			textureWind = dxCreateTexture ( "file/images/reflx.dds" )
			textureCarb = dxCreateTexture ( "file/images/reflx.dds" )
			textureFringe = dxCreateTexture ( "file/images/ColorRamp01.png" )
			-- Шeйдeр
			dxSetShaderValue ( myShader, "sReflectionTexture", textureCube )
			dxSetShaderValue ( myWind, "sReflectionTexture", textureWind )
			dxSetShaderValue ( myFara, "sReflectionTexture", textureWind )
			dxSetShaderValue ( carbon, "sReflectionTexture", textureCarb )
			-- Кузов
			engineApplyShaderToWorldTexture ( myShader, "?emap*" )
			engineApplyShaderToWorldTexture ( myShader, "body" )
			-- Стeкла
			engineApplyShaderToWorldTexture ( myWind, "lob_steklo" )
			engineApplyShaderToWorldTexture ( myWind, "zad_steklo" )
			engineApplyShaderToWorldTexture ( myWind, "pered_steklo" )
			-- Пeрeд фары
			engineApplyShaderToWorldTexture ( myFara, "fara" )
			-- Зад фары
			engineApplyShaderToWorldTexture ( myFara, "farared" )
			-- Стекла - тонер
			engineApplyShaderToWorldTexture ( myWind, "toner" )
			-- Пластик
			engineApplyShaderToWorldTexture ( myWind, "plast1" )
									
			for _,addList in ipairs(texturegrun) do
			engineApplyShaderToWorldTexture (myShader, addList )
		    end

			cpEffectEnabled = true
		else	
			outputChatBox( "Could not create shader. Please use debugscript 3",255,0,0 ) return		
		end
end


function stopCarPaint()
	if not cpEffectEnabled then return end
	engineRemoveShaderFromWorldTexture ( myShader,"*" )
	destroyElement( myShader )
	destroyElement( textureVol )
	destroyElement( textureCube )
	destroyElement( textureFringe )
	myShader = nil
	textureVol = nil
	textureCube = nil
	textureFringe = nil
	cpEffectEnabled = false
end
