GUI.plate = {}

GUI.plate.data = exports.operVehiclePlate:getPlateTable()
GUI.plate.currentID = 1
GUI.plate.maxID = #GUI.plate.data

GUI.plate.wnd = GuiWindow(15, sHeight/2-470/2, 300, 470, "Номерные знаки", false)
guiWindowSetSizable(GUI.plate.wnd, false)
guiWindowSetMovable(GUI.plate.wnd, false)

GUI.plate.img_bg = guiCreateStaticImage(0, 25, 495/1.7, 138/1.7, "assets/img/bg_plate.png", false, GUI.plate.wnd)

GUI.plate.tabPanel = guiCreateTabPanel(0, 110, 285, 245, false, GUI.plate.wnd)
GUI.plate.tab1 = guiCreateTab("Номер", GUI.plate.tabPanel)
GUI.plate.tab2 = guiCreateTab("Рамка", GUI.plate.tabPanel)
guiSetEnabled(GUI.plate.tab2, false)

-- НОМЕРНОЙ ЗНАК --

GUI.plate.lbl = guiCreateLabel(0, 360, 285, 20, "Отображение номерных знаков", false, GUI.plate.wnd)
guiSetFont(GUI.plate.lbl, "default-bold-small")
guiLabelSetColor(GUI.plate.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.plate.lbl, 'center')

GUI.plate.chekBoxRearPlate = guiCreateCheckBox(10, 380, 140, 20, ' Задний номер', false, false, GUI.plate.wnd)
guiSetFont(GUI.plate.chekBoxRearPlate, "default-bold-small")

GUI.plate.chekBoxFrontPlate = guiCreateCheckBox(10, 400, 140, 20, ' Передний номер', false, false, GUI.plate.wnd)
guiSetFont(GUI.plate.chekBoxFrontPlate, "default-bold-small")

GUI.plate.lbl = guiCreateLabel(0, 10, 285, 20, "Тип номерного знака", false, GUI.plate.tab1)
guiSetFont(GUI.plate.lbl, "default-bold-small")
guiLabelSetColor(GUI.plate.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.plate.lbl, 'center')

GUI.plate.lbl_info = guiCreateLabel(0, 30, 285, 70, GUI.plate.data[GUI.plate.currentID].name.."\n"..GUI.plate.data[GUI.plate.currentID].example, false, GUI.plate.tab1)
guiSetFont(GUI.plate.lbl_info, "default-bold-small")
--guiLabelSetColor(GUI.plate.lbl_info, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.plate.lbl_info, 'center')

-- --

GUI.plate.buttonPrev = GuiButton(10, 70, 60, 32, "<", false, GUI.plate.tab1)
guiSetFont(GUI.plate.buttonPrev, "default-bold-small")
guiSetProperty(GUI.plate.buttonPrev, "NormalTextColour", "FF21b1ff")

GUI.plate.img_plate = exports.operVehiclePlate:createStaticImagePlate(285/2-128/2, 70, 128, 32, GUI.plate.data[GUI.plate.currentID].path, GUI.plate.tab1)

GUI.plate.buttonNext = GuiButton(215, 70, 60, 32, ">", false, GUI.plate.tab1)
guiSetFont(GUI.plate.buttonNext, "default-bold-small")
guiSetProperty(GUI.plate.buttonNext, "NormalTextColour", "FF21b1ff")

-- --

GUI.plate.lbl = guiCreateLabel(0, 110, 285, 20, "Регистрационный номер", false, GUI.plate.tab1)
guiSetFont(GUI.plate.lbl, "default-bold-small")
guiLabelSetColor(GUI.plate.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.plate.lbl, 'center')

GUI.plate.edit = guiCreateEdit(285/2-128/2, 130, 128, 32, '', false, GUI.plate.tab1)
guiSetAlpha(GUI.plate.edit, 0.5)
guiSetEnabled(GUI.plate.edit, false)

-- --

GUI.plate.buttonAccept = GuiButton(10, 175, 265, 35, "Установить номерные знаки", false, GUI.plate.tab1)
guiSetFont(GUI.plate.buttonAccept, "default-bold-small")
guiSetProperty(GUI.plate.buttonAccept, "NormalTextColour", "FF21b1ff")
guiSetEnabled(GUI.plate.buttonAccept, false)

--GUI.plate.buttonRemove = GuiButton(10, 235, 265, 25, "Снять номерные знаки", false, GUI.plate.tab1) 
--guiSetFont(GUI.plate.buttonRemove, "default-bold-small")

GUI.plate.buttonExit = GuiButton(0, 435, 330, 25, "Вернуться в главное меню", false, GUI.plate.wnd)
guiSetFont(GUI.plate.buttonExit, "default-bold-small")
guiSetProperty(GUI.plate.buttonExit, "NormalTextColour", "fff01a21")
GUI.plate.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.plate.wnd.visible = false

function TuningGarage.setVisiblePlateWindow(visible)

	if visible then
		GUI.plate.updateWindow()
	end

	visible = not GUI.plate.wnd.visible

	GUI.plate.wnd.visible = visible

end



function GUI.plate.updateWindow() -- обновление окна
	guiSetText(GUI.plate.lbl_info, GUI.plate.data[GUI.plate.currentID].name.."\n"..GUI.plate.data[GUI.plate.currentID].example)
	exports.operVehiclePlate:loadStaticImagePlate(GUI.plate.img_plate, GUI.plate.data[GUI.plate.currentID].path)

	guiSetEnabled(GUI.plate.edit, not GUI.plate.data[GUI.plate.currentID].isPicture)
	guiSetText(GUI.plate.edit, "")
	guiEditSetMaxLength(GUI.plate.edit, GUI.plate.data[GUI.plate.currentID].editLength or 8)

	if guiGetEnabled(GUI.plate.edit) then
		guiSetAlpha(GUI.plate.edit, 1)
	else
		guiSetAlpha(GUI.plate.edit, 0.5)
	end

	if guiCheckBoxGetSelected(GUI.plate.chekBoxRearPlate) or guiCheckBoxGetSelected(GUI.plate.chekBoxFrontPlate) then
		guiSetEnabled(GUI.plate.buttonAccept, true)
	else
		guiSetEnabled(GUI.plate.buttonAccept, false)
	end
end

--bindKey('6', 'down', TuningGarage.setVisiblePlateWindow)


addEventHandler('onClientGUIChanged', GUI.plate.edit, function() -- форматирование ввода
	if not GUI.plate.wnd.visible or source ~= GUI.plate.edit or not GUI.plate.data[GUI.plate.currentID].isFormat then
		return 
	end

	local str = guiGetText(source)
    local text = str:gsub("[^QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890-]", "")
    guiSetText(source, utf8.upper(text))

end)

addEventHandler("onClientGUIClick", root, function()

	if not GUI.plate.wnd.visible then
		return 
	end

	if source == GUI.plate.buttonAccept then -- установить номерной знак
		exports.operVehiclePlate:applyVehicleNumberPlate(localPlayer.vehicle, GUI.plate.currentID, guiGetText(GUI.plate.edit))

		return
	elseif source == GUI.plate.buttonExit then
		TuningGarage.setVisiblePlateWindow(false)
		GUI.Window.wnd.visible = true
		return
	elseif source == GUI.plate.buttonPrev then
		if GUI.plate.currentID <= GUI.plate.maxID and GUI.plate.currentID ~= 1 then
			GUI.plate.currentID = GUI.plate.currentID - 1
		elseif GUI.plate.currentID == 1 then
			GUI.plate.currentID = GUI.plate.maxID
		end
		GUI.plate.updateWindow()
	elseif source == GUI.plate.buttonNext then
		if GUI.plate.currentID < GUI.plate.maxID then
			GUI.plate.currentID = GUI.plate.currentID + 1
		elseif GUI.plate.currentID == GUI.plate.maxID then
			GUI.plate.currentID = 1
		end
		GUI.plate.updateWindow()
	-- отображение номерных знаков
	elseif source == GUI.plate.chekBoxRearPlate or source == GUI.plate.chekBoxFrontPlate then 
		local stateRearPlate, stateFrontPlate = guiCheckBoxGetSelected(GUI.plate.chekBoxRearPlate), guiCheckBoxGetSelected(GUI.plate.chekBoxFrontPlate)

		if stateRearPlate then
			exports.operVehiclePlate:addOnVehicle(localPlayer.vehicle, 'RearBump0')
		else
			exports.operVehiclePlate:deleteFromVehicle(localPlayer.vehicle, 'RearBump0')
		end

		if stateFrontPlate then
			exports.operVehiclePlate:addOnVehicle(localPlayer.vehicle, 'FrontBump0')
		else
			exports.operVehiclePlate:deleteFromVehicle(localPlayer.vehicle, 'FrontBump0')
		end
		GUI.plate.updateWindow()
	end

end)
