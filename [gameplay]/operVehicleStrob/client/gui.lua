local sWidth, sHeight = guiGetScreenSize()

local GUI = {}

GUI.Strob = {}


GUI.Strob.wnd = GuiWindow(15, sHeight/2-410/2, 230, 410, "Стробоскопы", false)
guiWindowSetSizable(GUI.Strob.wnd, false)
guiWindowSetMovable(GUI.Strob.wnd, false)

GUI.Strob.gridlist = guiCreateGridList(0, 25, 230, 260, false, GUI.Strob.wnd)
guiGridListSetSortingEnabled(GUI.Strob.gridlist, false)
local column = guiGridListAddColumn(GUI.Strob.gridlist, "Каталог оборудования", 0.8)
GUI.Strob.gridlist:setData('operSounds.UI', 'ui_select')


GUI.Strob.buttonAccept = GuiButton(0, 295, 230, 35, "Установить", false, GUI.Strob.wnd)
guiSetFont(GUI.Strob.buttonAccept, "default-bold-small")
guiSetProperty(GUI.Strob.buttonAccept, "NormalTextColour", "FF21b1ff")
GUI.Strob.buttonAccept:setData('operSounds.UI', 'ui_select')

GUI.Strob.buttonRemove = GuiButton(0, 335, 230, 35, "Снять", false, GUI.Strob.wnd)
guiSetFont(GUI.Strob.buttonRemove, "default-bold-small")
GUI.Strob.buttonRemove:setData('operSounds.UI', 'ui_select')

GUI.Strob.buttonExit = GuiButton(0, 375, 230, 25, "Вернуться в главное меню", false, GUI.Strob.wnd)
guiSetFont(GUI.Strob.buttonExit, "default-bold-small")
guiSetProperty(GUI.Strob.buttonExit, "NormalTextColour", "fff01a21")
GUI.Strob.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.Strob.wnd.visible = false

function GUI.updateGridList()
	guiGridListClear(GUI.Strob.gridlist)
	local currentStrob = localPlayer.vehicle:getData('vehicle.isStrob') or false

	for tittle, v in pairs(Config.StrobMode) do
		local row = guiGridListAddRow(GUI.Strob.gridlist)
		guiGridListSetItemText(GUI.Strob.gridlist, row, 1, "", true, false)

		local row = guiGridListAddRow(GUI.Strob.gridlist)
		guiGridListSetItemText(GUI.Strob.gridlist, row, 1, '   '..tittle, true, false)
		guiGridListSetItemColor(GUI.Strob.gridlist, row, 1, 33, 177, 255)

		for _, strob in ipairs(v) do
			local row = guiGridListAddRow(GUI.Strob.gridlist)
			guiGridListSetItemText(GUI.Strob.gridlist, row, 1, '   '..strob.tittle, false, false)
			guiGridListSetItemData(GUI.Strob.gridlist, row, 1, strob.mode)
			
			if currentStrob and type(strob.mode) == type(currentStrob) then 
				if type(strob.mode) == 'number' then
					if strob.mode == currentStrob then
						guiGridListSetItemColor(GUI.Strob.gridlist, row, 1, 33, 177, 255)
					end
				else
					if strob.mode[1] == currentStrob[1] then
						guiGridListSetItemColor(GUI.Strob.gridlist, row, 1, 33, 177, 255)
					end
				end
			end

		end

		local row = guiGridListAddRow(GUI.Strob.gridlist)
		guiGridListSetItemText(GUI.Strob.gridlist, row, 1, "", true, false)

	end
end

local Time = {}

function GUI.setVisible(isVisible)

	if not localPlayer.vehicle then
		return
	end

	if isVisible then
		GUI.updateGridList()

		local timehour, timeminute = getTime()
        Time = {h = timehour, m = timeminute, d = getMinuteDuration()}

        setTime(22, 0)
        setMinuteDuration(60000)
    else
    	setTime(Time.h, Time.m)
        setMinuteDuration(Time.d)

        Time = nil
	end

	GUI.Strob.wnd.visible = isVisible
	--showCursor(isVisible)
end
addEvent('operVehicleStrob.setWndVisible', true)
addEventHandler('operVehicleStrob.setWndVisible', root, GUI.setVisible)

addEventHandler("onClientGUIClick", root, function()

	if not GUI.Strob.wnd.visible then
		return 
	end

	local sel = guiGridListGetSelectedItem(GUI.Strob.gridlist)
    local item = guiGridListGetItemData(GUI.Strob.gridlist, sel, 1) or false

    local vehicle = localPlayer.vehicle

    if source == GUI.Strob.buttonExit then
    	GUI.setVisible(false)
    	triggerEvent('TuningGarage.setWindowVisible', localPlayer, true)

    elseif source == GUI.Strob.buttonAccept then

    	if item ~= "" and type(item) == 'number' or type(item) == 'table' then
 			triggerServerEvent('operVehicleStrob.setVehicle', localPlayer, vehicle, item)

 			localPlayer.vehicle:setData('vehicle.isStrob', item)
 			GUI.updateGridList()
 		end

    	return
    elseif source == GUI.Strob.buttonRemove then

    	triggerServerEvent('operVehicleStrob.setVehicle', localPlayer, vehicle, false)
    	localPlayer.vehicle:setData('vehicle.isStrob', false)
 		GUI.updateGridList()
    	return
    elseif source == GUI.Strob.gridlist and item ~= "" and type(item) == 'number' or type(item) == 'table' then
        triggerServerEvent('operVehicleStrob.startPrewiew', localPlayer, vehicle, item)

        return
    end

    triggerServerEvent('operVehicleStrob.stopPrewiew', localPlayer, vehicle)

end)

--[[
bindKey('9', 'down', function()
	GUI.setVisible(not GUI.Strob.wnd.visible)
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, not GUI.Strob.wnd.visible)
end)
]]
