ShaderPanel = {}

ShaderPanel.isVisible = false

ShaderPanel.wnd = guiCreateWindow(sWidth/2-320/2, sHeight/2-490/2, 320, 490, "Настройка игры", false)
guiWindowSetSizable(ShaderPanel.wnd, false)
guiSetVisible(ShaderPanel.wnd, false)
guiWindowSetMovable(ShaderPanel.wnd, false)

ShaderPanel.tabPanel = guiCreateTabPanel(0, 25, 305, 425, false, ShaderPanel.wnd)
ShaderPanel.tabGraphic = guiCreateTab("Графика", ShaderPanel.tabPanel)
ShaderPanel.tabWeather = guiCreateTab("Погода и время", ShaderPanel.tabPanel)
ShaderPanel.tabOptimization = guiCreateTab("Оптимизация", ShaderPanel.tabPanel)

ShaderPanel.btn_close = guiCreateButton(0, 455, 320, 25, "Закрыть", false, ShaderPanel.wnd)
guiSetFont(ShaderPanel.btn_close, "default-bold-small")
guiSetProperty(ShaderPanel.btn_close, "NormalTextColour", "fff01a21")

-- ОПТИМИЗАЦИЯ --
ShaderPanel.lbl = guiCreateLabel(0, 15, 305, 20, "Оптимизация для слабых ПК", false, ShaderPanel.tabOptimization)
guiSetFont(ShaderPanel.lbl, "default-bold-small")
guiLabelSetColor(ShaderPanel.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(ShaderPanel.lbl, 'center')

ShaderPanel.btn_tyres_smoke = guiCreateCheckBox(10, 35, 320, 20, " Видимость густого дыма", true, false, ShaderPanel.tabOptimization)
guiSetFont(ShaderPanel.btn_tyres_smoke, "default-bold-small")

--ShaderPanel.btn_snow = guiCreateCheckBox(10, 55, 320, 20, " Видимость снега", true, false, ShaderPanel.tabOptimization)
--guiSetFont(ShaderPanel.btn_snow, "default-bold-small")

--ShaderPanel.btn_winter = guiCreateCheckBox(10, 75, 320, 20, " Зимний мод", true, false, ShaderPanel.tabOptimization)
--guiSetFont(ShaderPanel.btn_winter, "default-bold-small")

addEventHandler("onClientGUIClick", root, function()
	if not guiGetVisible(ShaderPanel.wnd) then
		return
	end

	if source == ShaderPanel.btn_tyres_smoke then
		triggerEvent('operVehicleSmoke.update', localPlayer, guiCheckBoxGetSelected(source))
	--elseif source == ShaderPanel.btn_snow then
		--triggerEvent('operWinterMode.setVisibleSnow', localPlayer, guiCheckBoxGetSelected(source))
	--elseif source == ShaderPanel.btn_winter then
		--triggerEvent('operWinterMode.setVisibleWinter', localPlayer, guiCheckBoxGetSelected(source))
	end
end)

-- ГРАФИКА --
ShaderPanel.lbl = guiCreateLabel(0, 15, 305, 20, "Улучшения графики", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.lbl, "default-bold-small")
guiLabelSetColor(ShaderPanel.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(ShaderPanel.lbl, 'center')

ShaderPanel.btn_water = guiCreateCheckBox(10, 35, 150, 20, " Реалистичная вода", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_water, "default-bold-small")

ShaderPanel.btn_sky = guiCreateCheckBox(10, 55, 150, 20, " Реалистичное небо", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_sky, "default-bold-small")

ShaderPanel.btn_vegetation = guiCreateCheckBox(10, 75, 200, 20, " Улучшенная растительность", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_vegetation, "default-bold-small")

ShaderPanel.btn_road = guiCreateCheckBox(10, 95, 150, 20, " Новые дороги", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_road, "default-bold-small")

ShaderPanel.btn_puddles = guiCreateCheckBox(10, 115, 150, 20, " Лужи на дорогах", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_puddles, "default-bold-small")

ShaderPanel.btn_contrast = guiCreateCheckBox(10, 135, 150, 20, " Контрастность", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_contrast, "default-bold-small")

ShaderPanel.btn_blur1 = guiCreateCheckBox(10, 155, 150, 20, " Размытие дальности", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_blur1, "default-bold-small")

ShaderPanel.btn_blur2 = guiCreateCheckBox(10, 175, 200, 20, " Размытие при движении", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_blur2, "default-bold-small")

ShaderPanel.btn_fxaa = guiCreateCheckBox(10, 195, 150, 20, " Сглаживание", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_fxaa, "default-bold-small")

ShaderPanel.btn_vignett = guiCreateCheckBox(10, 215, 150, 20, " Затемнение по краям", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_vignett, "default-bold-small")

ShaderPanel.btn_skidmarks = guiCreateCheckBox(10, 235, 125, 20, " Следы от резины", false, false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_skidmarks, "default-bold-small")

ShaderPanel.btn_skidmarks_1 = guiCreateButton(175, 237, 35, 18, "№1", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_skidmarks_1, "default-bold-small")
guiSetEnabled(ShaderPanel.btn_skidmarks_1, false)

ShaderPanel.btn_skidmarks_2 = guiCreateButton(215, 237, 35, 18, "№2", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_skidmarks_2, "default-bold-small")
guiSetEnabled(ShaderPanel.btn_skidmarks_2, false)

ShaderPanel.btn_skidmarks_3 = guiCreateButton(255, 237, 35, 18, "№3", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_skidmarks_3, "default-bold-small")
guiSetEnabled(ShaderPanel.btn_skidmarks_3, false)

-- ПРОРИСОВКА --
local distance_btn = {}

ShaderPanel.lbl = guiCreateLabel(0, 270, 305, 20, "Дальность прорисовки", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.lbl, "default-bold-small")
guiLabelSetColor(ShaderPanel.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(ShaderPanel.lbl, 'center')

ShaderPanel.btn_d3 = guiCreateRadioButton(10, 290, 150, 16, " Минимальная", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_d3, "default-bold-small")
distance_btn[ShaderPanel.btn_d3] = 300

ShaderPanel.btn_d8 = guiCreateRadioButton(10, 310, 150, 16, " По умолчанию", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_d8, "default-bold-small")
guiRadioButtonSetSelected(ShaderPanel.btn_d8, true)
distance_btn[ShaderPanel.btn_d8] = 800

ShaderPanel.btn_d20 = guiCreateRadioButton(10, 330, 150, 16, " Средняя", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_d20, "default-bold-small")
distance_btn[ShaderPanel.btn_d20] = 2000

ShaderPanel.btn_d30 = guiCreateRadioButton(10, 350, 150, 16, " Высокая", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_d30, "default-bold-small")
distance_btn[ShaderPanel.btn_d30] = 3000

ShaderPanel.btn_d700 = guiCreateRadioButton(10, 370, 150, 16, " Максимальная", false, ShaderPanel.tabGraphic)
guiSetFont(ShaderPanel.btn_d700, "default-bold-small")
distance_btn[ShaderPanel.btn_d700] = 70000

-- ПОГОДА --
local weather_btn = {}
ShaderPanel.lbl = guiCreateLabel(0, 15, 305, 20, "Погода", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.lbl, "default-bold-small")
guiLabelSetColor(ShaderPanel.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(ShaderPanel.lbl, 'center')

ShaderPanel.weather_cloud = guiCreateButton(10, 35, 140, 25, "Туман", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_cloud, "default-bold-small")
weather_btn[ShaderPanel.weather_cloud] = 9

ShaderPanel.weather_rain = guiCreateButton(155, 35, 140, 25, "Дождь", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_rain, "default-bold-small")
weather_btn[ShaderPanel.weather_rain] = 16

ShaderPanel.weather_bluesky = guiCreateButton(10, 65, 285, 25, "Голубое небо", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_bluesky, "default-bold-small")
weather_btn[ShaderPanel.weather_bluesky] = 10

ShaderPanel.weather_sun = guiCreateButton(10, 95, 140, 25, "Солнечно", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_sun, "default-bold-small")
weather_btn[ShaderPanel.weather_sun] = 11

ShaderPanel.weather_hot = guiCreateButton(155, 95, 140, 25, "Жара", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_hot, "default-bold-small")
weather_btn[ShaderPanel.weather_hot] = 18

ShaderPanel.weather_dull = guiCreateButton(10, 125, 285, 25, "Перед дождем", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_dull, "default-bold-small")
weather_btn[ShaderPanel.weather_dull] = 12

ShaderPanel.weather_sand = guiCreateButton(10, 155, 285, 25, "Песчаная буря", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_sand, "default-bold-small")
weather_btn[ShaderPanel.weather_sand] = 19

ShaderPanel.weather_blend = guiCreateCheckBox(10, 185, 235, 30, " Плавная смена погодных условий", false, false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.weather_blend, "default-bold-small")


-- ВРЕМЯ --
local time_btn = {}
ShaderPanel.lbl = guiCreateLabel(0, 230, 305, 20, "Время", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.lbl, "default-bold-small")
guiLabelSetColor(ShaderPanel.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(ShaderPanel.lbl, 'center')

ShaderPanel.btn_12 = guiCreateButton(10, 255, 140, 25, "12:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_12, "default-bold-small")
time_btn[ShaderPanel.btn_12] = {hour = 12, minute = 0}

ShaderPanel.btn_00 = guiCreateButton(155, 255, 140, 25, "00:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_00, "default-bold-small")
time_btn[ShaderPanel.btn_00] = {hour = 0, minute = 0}
--
ShaderPanel.btn_15 = guiCreateButton(10, 280, 140, 25, "15:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_15, "default-bold-small")
time_btn[ShaderPanel.btn_15] = {hour = 15, minute = 0}

ShaderPanel.btn_02 = guiCreateButton(155, 280, 140, 25, "02:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_02, "default-bold-small")
time_btn[ShaderPanel.btn_02] = {hour = 2, minute = 0}
--
ShaderPanel.btn_18 = guiCreateButton(10, 305, 140, 25, "18:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_18, "default-bold-small")
time_btn[ShaderPanel.btn_18] = {hour = 18, minute = 0}

ShaderPanel.btn_05 = guiCreateButton(155, 305, 140, 25, "05:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_05, "default-bold-small")
time_btn[ShaderPanel.btn_05] = {hour = 5, minute = 0}
--
ShaderPanel.btn_22 = guiCreateButton(10, 330, 140, 25, "22:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_22, "default-bold-small")
time_btn[ShaderPanel.btn_22] = {hour = 22, minute = 0}

ShaderPanel.btn_09 = guiCreateButton(155, 330, 140, 25, "09:00", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_09, "default-bold-small")
time_btn[ShaderPanel.btn_09] = {hour = 9, minute = 0}

ShaderPanel.btn_time_freeze = guiCreateCheckBox(10, 355, 140, 30, " Заморозить время", false, false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_time_freeze, "default-bold-small")

ShaderPanel.btn_refresh = guiCreateButton(155, 360, 140, 25, "Сбросить", false, ShaderPanel.tabWeather)
guiSetFont(ShaderPanel.btn_refresh, "default-bold-small")
guiSetProperty(ShaderPanel.btn_refresh, "NormalTextColour", "fff01a21")

function ShaderPanel.setVisible(isVisible)
	guiSetPosition(ShaderPanel.wnd, sWidth/2-320/2, sHeight/2-490/2, false) -- исходное положение 
	guiSetVisible(ShaderPanel.wnd, isVisible)
	showCursor(isVisible)

	if not getElementData(localPlayer, 'operCamHack:isVisible') then
		triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, not isVisible)
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'dashboard', true) -- ну отключать dashboard
		showChat(not isVisible)
		triggerEvent('operShowUI.drawBlurShader', localPlayer, isVisible)
	end
	
	ShaderPanel.isVisible = isVisible
end

bindKey('f6', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    if type(PLAYER_UI) == 'boolean' then return end
	if not PLAYER_UI['dashboard'] then 
		if not getElementData(localPlayer, 'operCamHack:isVisible') then
			return 
		end
	end

	--if localPlayer:getData('operLoginPanel:isVisible') then
		--return
	--end

	local isVisible = guiGetVisible(ShaderPanel.wnd)
	Dashboard.activeWindowShow(ShaderPanel.wnd)
	ShaderPanel.setVisible(not isVisible)
end)

addEventHandler("onClientGUIClick", root, function()
	if not guiGetVisible(ShaderPanel.wnd) then
		return
	end

	if source == ShaderPanel.btn_close then -- закрытие окна
		ShaderPanel.setVisible(false)
	elseif distance_btn[source] then -- дальность прорисовки
		Functions.setFarClipDistance(tonumber(distance_btn[source]))
	elseif weather_btn[source] then -- погодные условия
		Functions.changeWeather(tonumber(weather_btn[source]), guiCheckBoxGetSelected(ShaderPanel.weather_blend))
	elseif time_btn[source] then -- время
		Functions.changeTime(tonumber(time_btn[source].hour), tonumber(time_btn[source]. minute))

	elseif source == ShaderPanel.btn_time_freeze then
		Functions.toggleFreezeTime(guiCheckBoxGetSelected(source))

	elseif source == ShaderPanel.btn_refresh then
		guiCheckBoxSetSelected(ShaderPanel.btn_time_freeze, false)
		Functions.toggleFreezeTime(false)
		Functions.refreshTime()

	elseif source == ShaderPanel.btn_road then 
		if guiCheckBoxGetSelected(source) then
			exports.operShaderRoads.startRoadShader()
		else
			exports.operShaderRoads.stopRoadShader()
		end
	elseif source == ShaderPanel.btn_sky then
		if guiCheckBoxGetSelected(source) then
			exports.operShaderDynamicSky.startDynamicSky()
		else
			exports.operShaderDynamicSky.stopDynamicSky()
		end
	elseif source == ShaderPanel.btn_vegetation then
		if guiCheckBoxGetSelected(source) then
			exports.operShaderVegetation.startShader()
		else
			exports.operShaderVegetation.stopShader()
		end
	elseif source == ShaderPanel.btn_water then
		if guiCheckBoxGetSelected(source) then
			exports.operShaderWater.enableWaterShine()
		else
			exports.operShaderWater.disableWaterShine()
		end 

	-- СЛЕДЫ --
	elseif source == ShaderPanel.btn_skidmarks then
		if guiCheckBoxGetSelected(source) then
			exports.operShaderSkidmarks.startShader()
			guiSetEnabled(ShaderPanel.btn_skidmarks_1, true)
			guiSetEnabled(ShaderPanel.btn_skidmarks_2, true)
			guiSetEnabled(ShaderPanel.btn_skidmarks_3, true)
		else
			exports.operShaderSkidmarks.stopShader()
			guiSetEnabled(ShaderPanel.btn_skidmarks_1, false)
			guiSetEnabled(ShaderPanel.btn_skidmarks_2, false)
			guiSetEnabled(ShaderPanel.btn_skidmarks_3, false)
		end
	elseif source == ShaderPanel.btn_skidmarks_1 then	
		exports.operShaderSkidmarks:setShaderSetting('Black')
	elseif source == ShaderPanel.btn_skidmarks_2 then	
		exports.operShaderSkidmarks:setShaderSetting('Bright')
	elseif source == ShaderPanel.btn_skidmarks_3 then	
		exports.operShaderSkidmarks:setShaderSetting('BrightTwo')
	----------
	elseif source == ShaderPanel.btn_contrast then
		if guiCheckBoxGetSelected(source) then
			exports['operShaderContrast']:enableContrast(1)
		else
			exports['operShaderContrast']:disableContrast(1)
		end
	elseif source == ShaderPanel.btn_puddles then
		if guiCheckBoxGetSelected(source) then
			exports['operShaderPuddles']:enabledPuddles(1)
		else
			exports['operShaderPuddles']:enabledPuddles(0)
		end
	elseif source == ShaderPanel.btn_blur1 then
		if guiCheckBoxGetSelected(source) then
			exports['operShaderDof']:enableDoF()
		else
			exports['operShaderDof']:disableDoF()
		end		
	elseif source == ShaderPanel.btn_blur2 then
		if guiCheckBoxGetSelected(source) then
			exports['operShaderRadialblur']:enableRadialBlur()
		else
			exports['operShaderRadialblur']:disableRadialBlur()
		end		
	elseif source == ShaderPanel.btn_vignett then
		if guiCheckBoxGetSelected(source) then
			exports['operShaderVignette']:startVignette()
		else
			exports['operShaderVignette']:stopVignette()
		end	
	elseif source == ShaderPanel.btn_fxaa then
		if guiCheckBoxGetSelected(source) then
			exports['operShaderFXAA']:enablefxAA(4)
		else
			exports['operShaderFXAA']:disablefxAA()
		end	
	end
end)

