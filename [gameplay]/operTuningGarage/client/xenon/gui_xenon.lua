GUI.xenon = {}

GUI.xenon.wnd = GuiWindow(20, sHeight-380-15, 330, 380, "Ксенон", false)
guiWindowSetSizable(GUI.xenon.wnd, false)
guiWindowSetMovable(GUI.xenon.wnd, false)

GUI.xenon.buttonAccept = GuiButton(0, 305, 330, 35, "Установить", false, GUI.xenon.wnd)
guiSetFont(GUI.xenon.buttonAccept, "default-bold-small")
guiSetProperty(GUI.xenon.buttonAccept, "NormalTextColour", "FF21b1ff")

GUI.xenon.buttonExit = GuiButton(0, 345, 330, 25, "Вернуться в главное меню", false, GUI.xenon.wnd)
guiSetFont(GUI.xenon.buttonExit, "default-bold-small")
guiSetProperty(GUI.xenon.buttonExit, "NormalTextColour", "fff01a21")
GUI.xenon.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.xenon.wnd.visible = false

local LIGHT_COLOR = {}

function TuningGarage.setVisibleXenonWindow(visible)

	LIGHT_COLOR['R'], LIGHT_COLOR['G'], LIGHT_COLOR['B'] = getVehicleHeadLightColor(localPlayer.vehicle)

	if not visible then
		colorPickerDestroy()

		setTime(Time.h, Time.m)
        setMinuteDuration(Time.d)

        Time = nil
	else
		local r, g, b = getVehicleHeadLightColor(localPlayer.vehicle, true)
		createColorPicker(tocolor(r, g, b), GUI.xenon.wnd)

		local timehour, timeminute = getTime()
        Time = {h = timehour, m = timeminute, d = getMinuteDuration()}

        setTime(22, 0)
        setMinuteDuration(60000)
	end

	 GUI.xenon.wnd.visible = visible
end

addEventHandler("onClientGUIClick", root, function()

	if not GUI.xenon.wnd.visible then
		return 
	end

	if source == GUI.xenon.buttonExit then -- выход в главное меню

    	setVehicleHeadLightColor(localPlayer.vehicle, LIGHT_COLOR['R'], LIGHT_COLOR['G'], LIGHT_COLOR['B'])

		TuningGarage.setVisibleXenonWindow(false)
		GUI.Window.wnd.visible = true
	elseif source == GUI.xenon.buttonAccept then
		local r, g, b = getVehicleHeadLightColor(localPlayer.vehicle, true)
		LIGHT_COLOR['R'], LIGHT_COLOR['G'], LIGHT_COLOR['B'] = r, g, b
		triggerServerEvent("operTuningGarage.setXenonVehicle", localPlayer, r, g, b)

		TuningGarage.setVisibleXenonWindow(false)
		GUI.Window.wnd.visible = true
	end

end)

addEventHandler('operTuningGarage.onColorPickerChange', root, function(hex, r, g, b)
	if not localPlayer.vehicle then
		return
	end

	if not GUI.xenon.wnd.visible then
		return 
	end

	setVehicleOverrideLights(localPlayer.vehicle, 2)
    setVehicleHeadLightColor(localPlayer.vehicle, r, g, b)
end)