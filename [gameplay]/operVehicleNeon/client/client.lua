local sWidth, sHeight = guiGetScreenSize()

local GUI = {}
local Neon = {}

GUI.Neon = {}

GUI.Neon.wnd = GuiWindow(15, sHeight/2-370/2, 230, 370, "Неоновая подсветка", false)
guiWindowSetSizable(GUI.Neon.wnd, false)
guiWindowSetMovable(GUI.Neon.wnd, false)


GUI.Neon.lbl = guiCreateLabel(0, 25, 230, 50, "Внимание!\nНеоновая подсветка работает\nтолько в ночное время суток.", false, GUI.Neon.wnd)
guiSetFont(GUI.Neon.lbl, "default-bold-small")
guiLabelSetColor(GUI.Neon.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.Neon.lbl, 'center')

GUI.Neon.gridlist = guiCreateGridList(0, 70, 230, 180, false, GUI.Neon.wnd)
guiGridListSetSortingEnabled(GUI.Neon.gridlist, false)
local column = guiGridListAddColumn(GUI.Neon.gridlist, "Цвет", 0.8)
GUI.Neon.gridlist:setData('operSounds.UI', 'ui_select')

GUI.Neon.buttonRemove = GuiButton(0, 255, 230, 35, "Снять неоновую подсветку", false, GUI.Neon.wnd)
guiSetFont(GUI.Neon.buttonRemove, "default-bold-small")
guiSetEnabled(GUI.Neon.buttonRemove, false)
GUI.Neon.buttonRemove:setData('operSounds.UI', 'ui_select')

GUI.Neon.buttonAccept = GuiButton(0, 295, 230, 35, "Установить", false, GUI.Neon.wnd)
guiSetFont(GUI.Neon.buttonAccept, "default-bold-small")
guiSetProperty(GUI.Neon.buttonAccept, "NormalTextColour", "FF21b1ff")
GUI.Neon.buttonAccept:setData('operSounds.UI', 'ui_select')

GUI.Neon.buttonExit = GuiButton(0, 335, 230, 25, "Вернуться в главное меню", false, GUI.Neon.wnd)
guiSetFont(GUI.Neon.buttonExit, "default-bold-small")
guiSetProperty(GUI.Neon.buttonExit, "NormalTextColour", "fff01a21")
GUI.Neon.buttonExit:setData('operSounds.UI', 'ui_back')

GUI.Neon.wnd.visible = false

function GUI.Neon.updateGridList()
	guiGridListClear(GUI.Neon.gridlist)

	local currentNeon = localPlayer.vehicle:getData('vehicle.isNeonColor') or false

	for _, neon in pairs(Config.lampNeon) do
		local row = guiGridListAddRow(GUI.Neon.gridlist)

		guiGridListSetItemText(GUI.Neon.gridlist, row, 1, neon.name, false, false)
		guiGridListSetItemData(GUI.Neon.gridlist, row, 1, neon.id)

		if neon.id == currentNeon then
            guiSetEnabled(GUI.Neon.buttonRemove, true)
			guiGridListSetItemColor(GUI.Neon.gridlist, row, 1, 33, 177, 255)
		end
	end
end

local Time = {}

function GUI.Neon.setVisibleNeonWindow(visible)

	if visible then
        guiSetEnabled(GUI.Neon.buttonRemove, false)
		GUI.Neon.updateGridList()

        local timehour, timeminute = getTime()
        Time = {h = timehour, m = timeminute, d = getMinuteDuration()}

        setTime(22, 0)
        setMinuteDuration(60000)
    else
        setTime(Time.h, Time.m)
        setMinuteDuration(Time.d)

        Time = nil
	end

	GUI.Neon.wnd.visible = visible
end
addEvent('operVehicleNeon.setWndVisible', true)
addEventHandler('operVehicleNeon.setWndVisible', root, GUI.Neon.setVisibleNeonWindow)

-- ДЕМОНСТРАЦИЯ --
function Neon.startPrewiew(vehicle, isColor)

    if not isElement(vehicle) or Neon.vehicle or not isColor then
        return
    end

    local neonData = Config.vehicles[vehicle.model] or Config.vehicles[0]


    local x, y, z = getElementPosition(vehicle)

    if not x or not y or not z then 
        return 
    end

    Neon.Vehicle = {}

    for _, v in ipairs(neonData) do
        local lamp = createObject(isColor, x, y, z)
        lamp.dimension = vehicle.dimension
        lamp.interior = vehicle.interior
        setElementCollisionsEnabled(lamp, false)

        if not Config.isLampVisible then
            setElementAlpha(lamp, 0)
        end

        attachElements(lamp, vehicle, v[1], v[2], v[3], v[4], v[5], v[6])

        table.insert(Neon.Vehicle, lamp)
    end

end
addEvent('operVehicleNeon.startPrewiew', true)
addEventHandler('operVehicleNeon.startPrewiew', root, Neon.startPrewiew)

function Neon.stopPrewiew(vehicle)
    if not isElement(vehicle) or not Neon.Vehicle then
        return
    end

    for _, obj in pairs(Neon.Vehicle) do
        detachElements(obj, vehicle)
        destroyElement(obj)
    end

    Neon.Vehicle = nil
end
addEvent('operVehicleNeon.stopPrewiew', true)
addEventHandler('operVehicleNeon.stopPrewiew', root, Neon.stopPrewiew)

function Neon.updatePrewiewColor(vehicle, isColor)
    if not isElement(vehicle) then
        return
    end

    if not isColor then
        Neon.stopPrewiew(vehicle)
        return
    end

    if not Neon.Vehicle then
        Neon.startPrewiew(vehicle, isColor)
    end

    for _, lamp in ipairs(Neon.Vehicle) do
        setElementModel(lamp, isColor)
    end
end


addEventHandler("onClientGUIClick", root, function()

	if not GUI.Neon.wnd.visible then
		return 
	end

	local sel = guiGridListGetSelectedItem(GUI.Neon.gridlist)
    local item = guiGridListGetItemData(GUI.Neon.gridlist, sel, 1) or false

    local vehicle = localPlayer.vehicle

    if source == GUI.Neon.gridlist and item ~= "" and type(item) == 'number' then
        Neon.updatePrewiewColor(vehicle, item)
        return
    elseif source == GUI.Neon.buttonExit then
    	GUI.Neon.setVisibleNeonWindow(false)
    	triggerEvent('TuningGarage.setWindowVisible', localPlayer, true)

    elseif source == GUI.Neon.buttonAccept then
    	if item ~= "" and type(item) == 'number' then
            vehicle:setData('vehicle.isNeonColor', item)
    	end

        GUI.Neon.updateGridList()

    elseif source == GUI.Neon.buttonRemove then
        vehicle:setData('vehicle.isNeonColor', false)
        GUI.Neon.updateGridList()
    end

    Neon.updatePrewiewColor(vehicle, vehicle:getData('vehicle.isNeonColor'))
end)
