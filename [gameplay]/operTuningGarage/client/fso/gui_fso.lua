GUI.fso = {}

GUI.fso.wnd = GuiWindow(20, sHeight/2-270/2, 230, 270, "Вспышки ФСО", false)
guiWindowSetSizable(GUI.fso.wnd, false)
guiWindowSetMovable(GUI.fso.wnd, false)


GUI.fso.gridlist = guiCreateGridList(0, 25, 230, 125, false, GUI.fso.wnd)
guiGridListSetSortingEnabled(GUI.fso.gridlist, false)
local column = guiGridListAddColumn(GUI.fso.gridlist, "Режимы работы", 0.8)

GUI.fso.lbl = guiCreateLabel(0, 160, 230, 20, "Установка вспышек ФСО", false, GUI.fso.wnd)
guiSetFont(GUI.fso.lbl, "default-bold-small")
guiLabelSetColor(GUI.fso.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.fso.lbl, 'center')

GUI.fso.chekBoxFso_1 = guiCreateCheckBox(0, 180, 140, 20, ' Ряд №1', false, false, GUI.fso.wnd)
guiSetFont(GUI.fso.chekBoxFso_1, "default-bold-small")

GUI.fso.chekBoxFso_2 = guiCreateCheckBox(0, 200, 140, 20, ' Ряд №2', false, false, GUI.fso.wnd)
guiSetFont(GUI.fso.chekBoxFso_2, "default-bold-small")

--GUI.fso.buttonAccept = GuiButton(0, 235, 230, 35, "Установить", false, GUI.fso.wnd)
--guiSetFont(GUI.fso.buttonAccept, "default-bold-small")
--guiSetProperty(GUI.fso.buttonAccept, "NormalTextColour", "FF21b1ff")

GUI.fso.buttonExit = GuiButton(0, 235, 230, 25, "Вернуться в главное меню", false, GUI.fso.wnd)
guiSetFont(GUI.fso.buttonExit, "default-bold-small")
guiSetProperty(GUI.fso.buttonExit, "NormalTextColour", "fff01a21")
GUI.fso.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.fso.wnd.visible = false

local FsoModes = {
	{'#1'},
	{'#2'},
	{'#3'},
	{'#4'},
}

function GUI.fso.updateGridList()
	guiGridListClear(GUI.fso.gridlist)

	local currentMode = localPlayer.vehicle:getData('vehicle.isVehicleModeFSO') or 1

	for i, mode in pairs(FsoModes) do
		local row = guiGridListAddRow(GUI.fso.gridlist)

		guiGridListSetItemText(GUI.fso.gridlist, row, 1, mode[1], false, false)
		guiGridListSetItemData(GUI.fso.gridlist, row, 1, i)

		if i == currentMode then
			guiGridListSetItemColor(GUI.fso.gridlist, row, 1, 33, 177, 255)
		end
	end
end

function TuningGarage.setVisibleFSOWindow(visible)

	if visible then
		GUI.fso.updateGridList()

		local dataFSO = localPlayer.vehicle:getData('vehicle.dataFSO') or {}

		

		if dataFSO['Acces2'] then
			guiCheckBoxSetSelected(GUI.fso.chekBoxFso_1, dataFSO['Acces2'].visible or false)
			guiSetEnabled(GUI.fso.chekBoxFso_1, true)
		else
			guiSetEnabled(GUI.fso.chekBoxFso_1, false)
		end

		if dataFSO['Acces1'] then
			guiCheckBoxSetSelected(GUI.fso.chekBoxFso_2, dataFSO['Acces1'].visible or false)
			guiSetEnabled(GUI.fso.chekBoxFso_2, true)
		else
			guiSetEnabled(GUI.fso.chekBoxFso_2, false)
		end
	end

	GUI.fso.wnd.visible = visible
end
--[[
bindKey('7', 'down', function()
	TuningGarage.setVisibleFSOWindow(not GUI.fso.wnd.visible)
	showCursor(GUI.fso.wnd.visible)
end)
--]]
addEventHandler("onClientGUIClick", root, function()

	if not GUI.fso.wnd.visible then
		return 
	end

	if source == GUI.fso.chekBoxFso_1 then -- вспышки за решеткой
		local state = guiCheckBoxGetSelected(source)
		if state then
			exports.operVehicleFSO:addOnVehicle(localPlayer.vehicle, 'Acces2') 
			exports.operVehicleFSO:lights(localPlayer.vehicle, 'demo')
		else
			exports.operVehicleFSO:deleteFromVehicle(localPlayer.vehicle, 'Acces2')
		end
	elseif source == GUI.fso.chekBoxFso_2 then	 -- вспышки в бампере
		local state = guiCheckBoxGetSelected(source)
		if state then
			exports.operVehicleFSO:addOnVehicle(localPlayer.vehicle, 'Acces1')
			exports.operVehicleFSO:lights(localPlayer.vehicle, 'demo') 
		else
			exports.operVehicleFSO:deleteFromVehicle(localPlayer.vehicle, 'Acces1')
		end
	elseif source == GUI.fso.buttonExit then
		GUI.fso.wnd.visible = false
    	GUI.Window.wnd.visible = true
	end

end)

addEventHandler("onClientGUIDoubleClick", root, function()

	if not GUI.fso.wnd.visible then
		return 
	end

	local sel = guiGridListGetSelectedItem(GUI.fso.gridlist)
    local item = guiGridListGetItemData(GUI.fso.gridlist, sel, 1) or ""

    if source == GUI.fso.gridlist and item ~= "" and type(item) == 'number' then
    	exports.operVehicleFSO:updateLightsMode(localPlayer.vehicle, item)
    	exports.operVehicleFSO:lights(localPlayer.vehicle, 'demo')

    	GUI.fso.updateGridList()
    end
end)