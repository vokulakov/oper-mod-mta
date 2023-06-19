GUI.horn = {}

local horn_sound = {
	{'Сигнал #1', 'veh_horn_sound_1'},
	{'Сигнал #2', 'veh_horn_sound_2'},
	{'Сигнал #3', 'veh_horn_sound_3'},
	{'Сигнал #4', 'veh_horn_sound_4'},
	{'Сигнал #5', 'veh_horn_sound_5'},
	{'Сигнал #6', 'veh_horn_sound_6'},
	{'Сигнал #7', 'veh_horn_sound_7'},
	{'Сигнал #8', 'veh_horn_sound_8'},
}

local isHornListen

GUI.horn.wnd = GuiWindow(20, sHeight/2-300/2, 230, 300, "Сигнал", false)
guiWindowSetSizable(GUI.horn.wnd, false)
guiWindowSetMovable(GUI.horn.wnd, false)

GUI.horn.gridlist = guiCreateGridList(0, 30, 230, 180, false, GUI.horn.wnd)
guiGridListSetSortingEnabled(GUI.horn.gridlist, false)
local column = guiGridListAddColumn(GUI.horn.gridlist, "Сигналы", 0.8)

GUI.horn.buttonAccept = GuiButton(0, 225, 230, 35, "Установить", false, GUI.horn.wnd)
guiSetFont(GUI.horn.buttonAccept, "default-bold-small")
guiSetProperty(GUI.horn.buttonAccept, "NormalTextColour", "FF21b1ff")

GUI.horn.buttonExit = GuiButton(0, 265, 230, 25, "Вернуться в главное меню", false, GUI.horn.wnd)
guiSetFont(GUI.horn.buttonExit, "default-bold-small")
guiSetProperty(GUI.horn.buttonExit, "NormalTextColour", "fff01a21")
GUI.horn.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.horn.wnd.visible = false

function GUI.horn.updateGridList()
	guiGridListClear(GUI.horn.gridlist)

	local currentHorn = localPlayer.vehicle:getData('vehicle.isHorn') or false

	for id, horn in pairs(horn_sound) do
		local row = guiGridListAddRow(GUI.horn.gridlist)

		guiGridListSetItemText(GUI.horn.gridlist, row, 1, horn[1], false, false)
		guiGridListSetItemData(GUI.horn.gridlist, row, 1, horn[2])

		if horn[2] == currentHorn then
			guiGridListSetItemColor(GUI.horn.gridlist, row, 1, 33, 177, 255)
		end
	end
end

function TuningGarage.setVisibleHornWindow(visible)

	if visible then
		GUI.horn.updateGridList()
	end

	GUI.horn.wnd.visible = visible
end

--TuningGarage.setVisibleHornWindow(true)

addEventHandler("onClientGUIClick", root, function()

	if not GUI.horn.wnd.visible then
		return 
	end

	local sel = guiGridListGetSelectedItem(GUI.horn.gridlist)
    local item = guiGridListGetItemData(GUI.horn.gridlist, sel, 1) or ""

    if source == GUI.horn.gridlist and item ~= "" and type(item) == 'string' then
    	if isElement(isHornListen) then
    		stopSound(isHornListen)
    	end

    	isHornListen = exports.operSounds:playSound(item)
    	--guiGridListSetSelectedItem(GUI.horn.gridlist, 0, 0)
    	--triggerServerEvent('PlayerFunctions.setPlayerSkin', localPlayer, tonumber(item))
    	return
    elseif source == GUI.horn.buttonExit then
    	if isElement(isHornListen) then
    		stopSound(isHornListen)
    	end

    	GUI.horn.wnd.visible = false
    	GUI.Window.wnd.visible = true
    elseif source == GUI.horn.buttonAccept then

    	if item ~= "" and type(item) == 'string' then
    		localPlayer.vehicle:setData('vehicle.isHorn', item)
    		TuningGarage.setVehicleHorn(localPlayer.vehicle)
    	end

    	GUI.horn.wnd.visible = false
    	GUI.Window.wnd.visible = true
    end


end)
