local screenW, screenH = guiGetScreenSize()

local shadersCars = { }
local timersVeh = { }
local eventsVeh = { }

local texturesRemap = {"remap", "body", "remap_body", "@hite"}

local Settings = { }

local shaders = {
	chameleo = dxCreateShader("assets/fx/chameleon/chameleo.fx", 1, 30),
    matte 	 = dxCreateShader("assets/fx/matte/matte.fx", 1, 30),
    gloss 	 = dxCreateShader("assets/fx/gloss/car_paint.fx", 2, 30, false, "vehicle"),
    chrome   = dxCreateShader("assets/fx/chrome/car_paint.fx", 1, 50, false)
}

local textures = {
	cube_env256   = dxCreateTexture("assets/fx/cube_env256.dds"),
	tempBody 	  = dxCreateTexture("assets/fx/tempBody.png"),
	textureCube   = dxCreateTexture("assets/fx/chrome/reflx.dds"),
	textureFringe = dxCreateTexture("assets/fx/chrome/color.png"),
	smallnoise3d  = dxCreateTexture("assets/fx/smallnoise3d.dds")
}

------------------------------------------------------------
-------------------------- ГЛЯНЕЦ --------------------------
------------------------------------------------------------
Settings.GlossVar = { }

local function setcpRLEffectVehicle()
	local v = Settings.GlossVar
	v.normal = 2.0 -- deformation strength
	v.bumpSize = 0.0 -- for car paint, preferably keep it 0 to prevent flaking (grainy spots like shown at https://i.imgur.com/1nG02ZW.png), true ENB doesn't flake.
	v.bumpIntensity = {0, 0} -- intensity of the bump effect
	v.envIntensity = {0.35, 0.55} -- intensity of the reflection effect
	v.brightnessMul = {1.2, 1.5} -- multiply after brightpass
	v.brightpassPower = {2.5, 2.0} -- 1-5
	v.brightnessAdd = {0.1, 0.1} -- before bright pass
	v.brightpassCutoff = {0.1, 0.1} -- cutoff lower light spectrum
	v.specularValue = {0.0, 0.0} -- gtasa vehicle specular value (0-1)
	v.refTexValue = {0.1, 0.1} -- gtasa reflection texture visibility (the lower, like right now - the more it resembles the "ENB" deep reflection appearance)
	v.uvMul = {1.8, 1.5} -- uv multiply
	v.uvMov = {0.3, 0.21} -- uv move
end

local screenSource = dxCreateScreenSource(screenW, screenH)

addEventHandler("onClientHUDRender", root, function()
    if screenSource then 
        dxUpdateScreenSource(screenSource) 
    end
end)

local function setVehicleGlossColor(veh)
	if not shadersCars[veh] then
		shadersCars[veh] = shaders.gloss
	end

	local v = Settings.GlossVar
	setcpRLEffectVehicle()

	dxSetShaderValue(shadersCars[veh], "sRandomTexture", textures.smallnoise3d)

	dxSetShaderValue(shadersCars[veh], "sNorFac", v.normal)
	dxSetShaderValue(shadersCars[veh], "uvMul", v.uvMul[1], v.uvMul[2])
	dxSetShaderValue(shadersCars[veh], "uvMov", v.uvMov[1], v.uvMov[2])
	dxSetShaderValue(shadersCars[veh], "bumpSize", v.bumpSize)
	dxSetShaderValue(shadersCars[veh], "bumpIntensity", v.bumpIntensity[1])
	dxSetShaderValue(shadersCars[veh], "envIntensity", v.envIntensity[1])
	dxSetShaderValue(shadersCars[veh], "specularValue", v.specularValue[1])
	dxSetShaderValue(shadersCars[veh], "refTexValue", v.refTexValue[1])

	dxSetShaderValue(shadersCars[veh], "sPower", v.brightpassPower[1])
	dxSetShaderValue(shadersCars[veh], "sAdd", v.brightnessAdd[1])
	dxSetShaderValue(shadersCars[veh], "sMul", v.brightnessMul[1])
	dxSetShaderValue(shadersCars[veh], "sCutoff", v.brightpassCutoff[1])

    dxSetShaderValue(shadersCars[veh], "sReflectionTexture", screenSource)
	
	for i, v in ipairs(texturesRemap) do
        engineApplyShaderToWorldTexture(shadersCars[veh], v, veh)
	end


end

------------------------------------------------------------
--------------------------- ХРОМ ---------------------------
------------------------------------------------------------
local function setVehicleChromeColor(veh)
	if not shadersCars[veh] then
		shadersCars[veh] = shaders.chrome
	end

	dxSetShaderValue(shadersCars[veh], "sReflectionTexture", textures.textureCube)
	dxSetShaderValue(shadersCars[veh], "sFringeMap", textures.textureFringe)
	dxSetShaderValue(shadersCars[veh], "gFilmDepth", 0.05)
	dxSetShaderValue(shadersCars[veh], "gFilmIntensity", 0.11)

    for i, v in ipairs(texturesRemap) do
        engineApplyShaderToWorldTexture(shadersCars[veh], v, veh)
    end

    local pntBright = 0.15
    local skyLightIntensity = 0.15

    timersVeh[veh] = setTimer(function()
        --if not #Settings == 0 then setEffectv () end
        local rSkyTop, gSkyTop, bSkyTop, rSkyBott, gSkyBott, bSkyBott = getSkyGradient ()
        local cx, cy, cz = getCameraMatrix()
        if (isLineOfSightClear(cx, cy, cz, cx, cy, cz + 30, true, false, false, true, false, true, false, localPlayer)) then
            pntBright = pntBright + 0.015
        else
            pntBright = pntBright - 0.015
        end
        
       	if pntBright > skyLightIntensity then  pntBright = skyLightIntensity end
		if pntBright < 0 then pntBright = 0 end 
		dxSetShaderValue(shadersCars[veh], "sSkyColorTop", pntBright*rSkyTop/255, pntBright*gSkyTop/255, pntBright*bSkyTop/255)
		dxSetShaderValue(shadersCars[veh], "sSkyColorBott", pntBright*rSkyBott/255, pntBright*gSkyBott/255, pntBright*bSkyBott/255)
    end, 50, 0)
end

------------------------------------------------------------
------------------------- МАТОВЫЙ --------------------------
------------------------------------------------------------
local function setVehicleMatteColor(veh)

	if not shadersCars[veh] then
		shadersCars[veh] = shaders.matte
	end

    dxSetShaderValue(shadersCars[veh], "gTexture", textures.tempBody)

    for i, v in ipairs(texturesRemap) do
        engineApplyShaderToWorldTexture(shadersCars[veh], v, veh)
    end
end

------------------------------------------------------------
------------------------- ХАМЕЛЕОН -------------------------
------------------------------------------------------------
Settings.ChameleonVar = {}

function setEffectChameleon()
    local v = Settings.ChameleonVar

    v.renderDistance = 30 -- Расстояние на котором появляется блеск
    
    v.brightnessFactorPaint = 1

    v.normalZ = 1 -- прочность деформации (0-1,0) 1,0 = самая высокая (Z вектора)

    v.brightnessAdd = 0.5 -- Перед ярким цветом
    v.brightnessMul = 1 -- Умножение после яркого цвета
    v.brightpassCutoff = 0.1 -- 0-1
    v.brightpassPower = 5 -- 1-5
end

local function setVehicleChameleonColor(veh)
	if not shadersCars[veh] then
		shadersCars[veh] = shaders.chameleo
	end

	setEffectChameleon()
	local v = Settings.ChameleonVar

	dxSetShaderValue(shadersCars[veh], "sCutoff", v.brightpassCutoff)
    dxSetShaderValue(shadersCars[veh], "sPower", v.brightpassPower)
    dxSetShaderValue(shadersCars[veh], "sAdd", v.brightnessAdd)
    dxSetShaderValue(shadersCars[veh], "sMul", v.brightnessMul)
    dxSetShaderValue(shadersCars[veh], "sNormZ", v.normalZ)
    dxSetShaderValue(shadersCars[veh], "brightnessFactor", v.brightnessFactorPaint)

    dxSetShaderValue(shadersCars[veh], "sReflectionTexture", textures.cube_env256)
    dxSetShaderValue(shadersCars[veh], "gTexture", textures.tempBody)

    -- ПРИМЕНЕНИЕ ВТОРОГО ЦВЕТА --
    --local RGB = getElementData(veh, "colorTypeRGB")
    --if RGB then
        --local r, g, b = unpack(RGB)
    	--dxSetShaderValue(shadersCars[veh], "paintColor2", {90, 36, 255})
    --end

    for i, v in ipairs(texturesRemap) do
        engineApplyShaderToWorldTexture(shadersCars[veh], v, veh)
	end

end

------------------------------------------------------
local initialColors = {}

local function getVehicleColorByName(vehicle, name)
    local r1, g1, b1, r2, g2, b2 = getVehicleColor(vehicle, true)

    if name == "body" then
        return r1, g1, b1
    elseif name == "additional" then
        return r2, g2, b2
    elseif name == "hlbody" then
    	local RGB = getElementData(vehicle, "vehicle.colorTypeRGB") 

    	if not RGB then
    		return 0.3 * 255, 0.3 * 255, 0.3 * 255
        end

        local r, g, b = unpack(RGB)
        return r, g, b
    end
end

function setupColorPreview() -- СОХРАНЯЕМ ЦВЕТ КРАСКИ ПРИ ВХОДЕ 
	local vehicle = localPlayer.vehicle
    if not vehicle then
        return
    end

    initialColors = {
        body   	   = { getVehicleColorByName(vehicle, "body")   },
        additional = { getVehicleColorByName(vehicle, "additional") },
    	hlbody     = { getVehicleColorByName(vehicle, "hlbody") },
    	colorType  = getElementData(vehicle, 'vehicle.colorType') or false
    }
end

function setVehiclePreviewColor(r, g, b)
	local vehicle = localPlayer.vehicle

    if not vehicle then
        return
    end

    if guiCheckBoxGetSelected(GUI.paint.chekBoxColor1) then -- основной цвет
    	local r1, g1, b1, r2, g2, b2 = getVehicleColor(vehicle, true)
    	setVehicleColor(vehicle, r, g, b, r2, g2, b2)
    end
    
    if guiCheckBoxGetSelected(GUI.paint.chekBoxColor3) then -- дополнительный цвет
        local r1, g1, b1, r2, g2, b2 = getVehicleColor(vehicle, true)
        setVehicleColor(vehicle, r1, g1, b1, r, g, b)
    end

    if guiCheckBoxGetSelected(GUI.paint.chekBoxColor2) then -- цвет блеска
    	vehicle:setData('vehicle.colorTypeRGB', {r / 255, g / 255, b / 255})
    end

end

function resetVehiclePreview()
    if not initialColors.body then
        return
    end

    local vehicle = localPlayer.vehicle

    if not vehicle then
        return
    end

    local r1, g1, b1 = unpack(initialColors.body)
    local r2, g2, b2 = unpack(initialColors.additional)
    setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)

    if initialColors.hlbody then
    	local r3, g3, b3 = unpack(initialColors.hlbody)
   		-- цвет блеска --
   		vehicle:setData('vehicle.colorTypeRGB', {r3, g3, b3})
    end

    if not initialColors.colorType then
    	return vehicle:setData('vehicle.colorType', false)
    end

    vehicle:setData('vehicle.colorType', initialColors.colorType)

end

function setVehiclePreviewFX(colorType) -- ПРЕДПРОСМОТР ПОКРАСКИ
	local vehicle = localPlayer.vehicle

    if not vehicle then
        return
    end

    vehicle:setData('vehicle.colorType', colorType)
end


function removeColors(veh) -- УДАЛЕНИЕ КРАСКИ С ТРАНСПОРТА
    if isTimer(timersVeh[veh]) then killTimer(timersVeh[veh]) end
    if shadersCars[veh] then
        for i, v in ipairs(texturesRemap) do
            engineRemoveShaderFromWorldTexture(shadersCars[veh], v, veh)
        end
    end
    shadersCars[veh] = nil
end


-- СИНХРОНИЗАЦИЯ ПОКРАСКИ --
local function setVehicleColorFX(vehicle)
	if not vehicle then
		return
	end

	local colorType = getElementData(vehicle, 'vehicle.colorType')

	if not colorType then
		return
	end

	if colorType == 'gloss' then
    	setVehicleGlossColor(vehicle)
	elseif colorType == 'matte' then
		setVehicleMatteColor(vehicle)
	elseif colorType == 'chrome' then
		setVehicleChromeColor(vehicle)
	elseif colorType == 'chameleon' then
		setVehicleChameleonColor(vehicle)    	
	end
end

addEventHandler("onClientElementDataChange", root, function(data)
	if getElementType(source) ~= "vehicle" then return end

	if not isElementStreamedIn(source) then
		return
	end

	if data == 'vehicle.colorTypeRGB' then
		if shadersCars[source] then
			local RGB = getElementData(source, "vehicle.colorTypeRGB") 
        	local r, g, b = unpack(RGB)
    		dxSetShaderValue(shadersCars[source], "paintColor2", {r, g, b})
    	end
	end

	if data == 'vehicle.colorType' then
		removeColors(source)
		setVehicleColorFX(source)
	end
end)

addEventHandler("onClientResourceStart", resourceRoot, function ()
    for i, vehicle in ipairs(getElementsByType("vehicle")) do
        if isElementStreamedIn(vehicle) then
			setVehicleColorFX(vehicle)
        end
    end
end)

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
    	removeColors(source)
		setVehicleColorFX(source)
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if getElementType(source) == "vehicle" then
    	if not shadersCars[source] then
    		return
    	end

        removeColors(source)
    end
end)

addEventHandler("onClientElementDestroy", root, function()
    if source and getElementType(source) == "vehicle" then
        if not shadersCars[source] then
            return
        end

        removeColors(source)
    end
end)
----------------------------