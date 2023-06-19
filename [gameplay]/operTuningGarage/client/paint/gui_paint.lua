local currentColorType
local colorType

GUI.paint = {}

GUI.paint.sectionsWindow = GuiWindow(15, sHeight-450-15, 330, 450, "Покраска", false)
guiWindowSetSizable(GUI.paint.sectionsWindow, false)
guiWindowSetMovable(GUI.paint.sectionsWindow, false)

-- ТИП ПОКРАСКИ --
GUI.paint.rButStock = guiCreateRadioButton(0, 300, 100, 20, "Стандартный", false, GUI.paint.sectionsWindow)
GUI.paint.rButGloss = guiCreateRadioButton(0, 320, 100, 20, "Глянец", false, GUI.paint.sectionsWindow)
GUI.paint.rButMatte = guiCreateRadioButton(0, 340, 100, 20, "Матовый", false, GUI.paint.sectionsWindow)
GUI.paint.rButChrome = guiCreateRadioButton(0, 360, 150, 20, "Хром", false, GUI.paint.sectionsWindow)
GUI.paint.rButChameleon = guiCreateRadioButton(0, 380, 150, 20, "Перламутровый", false, GUI.paint.sectionsWindow)
------------------

GUI.paint.chekBoxColor1 = guiCreateCheckBox(170, 300, 90, 20, 'Цвет кузова', true, false, GUI.paint.sectionsWindow)
GUI.paint.chekBoxColor3 = guiCreateCheckBox(170, 320, 150, 20, 'Дополнительный цвет', false, false, GUI.paint.sectionsWindow)
--guiSetEnabled(GUI.paint.chekBoxColor3, false)

GUI.paint.chekBoxColor2 = guiCreateCheckBox(170, 340, 90, 20, 'Цвет блеска', false, false, GUI.paint.sectionsWindow)
--guiSetEnabled(GUI.paint.chekBoxColor2, false)

GUI.paint.buttonPaint = GuiButton(170, 370, 150, 35, "Покрасить", false, GUI.paint.sectionsWindow)
guiSetFont(GUI.paint.buttonPaint, "default-bold-small")
guiSetProperty(GUI.paint.buttonPaint, "NormalTextColour", "FF21b1ff")

GUI.paint.buttonExit = GuiButton(10, 415, 330, 25, "Вернуться в главное меню", false, GUI.paint.sectionsWindow)
guiSetFont(GUI.paint.buttonExit, "default-bold-small")
guiSetProperty(GUI.paint.buttonExit, "NormalTextColour", "fff01a21")
GUI.paint.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.paint.sectionsWindow.visible = false

function TuningGarage.setVisiblePaintWindow(visible)

	if not visible then
		colorPickerDestroy()
	else
		currentColorType = localPlayer.vehicle:getData('vehicle.colorType') 

		if not currentColorType then
			guiRadioButtonSetSelected(GUI.paint.rButStock, true)
			colorType = 'stock'
		else
			if currentColorType == 'matte' then
				guiRadioButtonSetSelected(GUI.paint.rButMatte, true)
			elseif currentColorType == 'gloss' then
				guiRadioButtonSetSelected(GUI.paint.rButGloss, true)
			elseif currentColorType == 'chrome' then
				guiRadioButtonSetSelected(GUI.paint.rButChrome, true)
			elseif currentColorType == 'chameleon' then
				guiRadioButtonSetSelected(GUI.paint.rButChameleon, true)
			end

			colorType = currentColorType
		end

		local r1, g1, b1, r2, g2, b2 = getVehicleColor(localPlayer.vehicle, true)
		createColorPicker(tocolor(r1, g1, b1), GUI.paint.sectionsWindow)
	end

	GUI.paint.sectionsWindow.visible = visible
end

addEventHandler("onClientGUIClick", root, function()

	if not GUI.paint.sectionsWindow.visible then
		return 
	end

	if source == GUI.paint.buttonExit then
		TuningGarage.setVisiblePaintWindow(false)
		resetVehiclePreview() 
		GUI.Window.wnd.visible = true
		return
	elseif source == GUI.paint.buttonPaint then -- нажатие на кнопку 'покрасить'

		if not colorType then
			return
		end

		TuningGarage.setVisiblePaintWindow(false)
		
		local r1, g1, b1, r2, g2, b2 = getVehicleColor(localPlayer.vehicle, true)
		playSound("assets/sound/sound.mp3", false)

		triggerServerEvent('operTuningGarage.setVehicleColor', localPlayer, r1, g1, b1, r2, g2, b2)

		setTimer(function()
			GUI.Window.wnd.visible = true
		end, 3000, 1)

	elseif source == GUI.paint.rButStock or source == GUI.paint.rButGloss or source == GUI.paint.rButMatte or source == GUI.paint.rButChrome or source == GUI.paint.rButChameleon then
	    if source == GUI.paint.rButStock then colorType = 'stock'
	    elseif source == GUI.paint.rButGloss then colorType = 'gloss'
	    elseif source == GUI.paint.rButMatte then colorType = 'matte'
	    elseif source == GUI.paint.rButChrome then colorType = 'chrome'
	    elseif source == GUI.paint.rButChameleon then colorType = 'chameleon'
	    end
	   
	    setVehiclePreviewFX(colorType)
	end
end)

addEventHandler('operTuningGarage.onColorPickerChange', root, function(hex, r, g, b)
	if not GUI.paint.sectionsWindow.visible then
		return 
	end

    setVehiclePreviewColor(r, g, b)
end)
