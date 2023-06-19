GUI = {}

local sWidth, sHeight = guiGetScreenSize()

GUI.wnd = GuiWindow(15, 15, 350, sHeight-25, "Установка аксессуаров", false)
guiWindowSetSizable(GUI.wnd, false)
guiWindowSetMovable(GUI.wnd, false)

GUI.gridlist_objects = guiCreateGridList(0, 25, 330, sHeight*230/720, false, GUI.wnd)
guiGridListSetSortingEnabled(GUI.gridlist_objects, false)
local column = guiGridListAddColumn(GUI.gridlist_objects, "Каталог аксессуаров", 0.9)

-- --
GUI.gridlist_addObjects = guiCreateGridList(0, sHeight*270/720, 330, sHeight*150/720, false, GUI.wnd)
guiGridListSetSortingEnabled(GUI.gridlist_addObjects, false)
local column = guiGridListAddColumn(GUI.gridlist_addObjects, "Установленные аксессуары", 0.9)

GUI.lbl = guiCreateLabel(0, sHeight*425/720, 350, 15, "УПРАВЛЕНИЕ ВЫБРАННЫМ АКСЕССУАРОМ", false, GUI.wnd)
guiSetFont(GUI.lbl, "default-bold-small")
guiLabelSetColor(GUI.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.lbl, 'center')

GUI.btn_obj_add = guiCreateButton(0, sHeight*445/720, 225, 25, "Добавить", false, GUI.wnd)
guiSetFont(GUI.btn_obj_add, "default-bold-small")
guiSetProperty(GUI.btn_obj_add, "NormalTextColour", "FF21b1ff")
guiSetEnabled(GUI.btn_obj_add, false)

GUI.btn_obj_remove = guiCreateButton(240, sHeight*445/720, 100, 25, "Удалить", false, GUI.wnd)
guiSetFont(GUI.btn_obj_remove, "default-bold-small")
guiSetProperty(GUI.btn_obj_remove, "NormalTextColour", "fff01a21")
guiSetEnabled(GUI.btn_obj_remove, false)

GUI.btn_obj_defaultScale = guiCreateButton(0, sHeight*480/720, 155, 35, "Сбросить настройки размера", false, GUI.wnd)
guiSetFont(GUI.btn_obj_defaultScale, "default-bold-small")
guiSetEnabled(GUI.btn_obj_defaultScale, false)

GUI.btn_obj_defaultRot = guiCreateButton(170, sHeight*480/720, 170, 35, "Сбросить настройки вращения", false, GUI.wnd)
guiSetFont(GUI.btn_obj_defaultRot, "default-bold-small")
guiSetEnabled(GUI.btn_obj_defaultRot, false)

-- --

GUI.lbl = guiCreateLabel(0, sHeight*535/720, 350, 15, "УПРАВЛЕНИЕ КОМПОНЕНТАМИ ТРАНСПОРТА", false, GUI.wnd)
guiSetFont(GUI.lbl, "default-bold-small")
guiLabelSetColor(GUI.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(GUI.lbl, 'center')

GUI.btn_veh_backdoor = guiCreateButton(0, sHeight*555/720, 350, 25, "Открыть/закрыть багажник", false, GUI.wnd)
guiSetFont(GUI.btn_veh_backdoor, "default-bold-small")

GUI.btn_veh_door = guiCreateButton(0, sHeight*590/720, 350, 25, "Открыть/закрыть все двери", false, GUI.wnd)
guiSetFont(GUI.btn_veh_door, "default-bold-small")

GUI.lbl = guiCreateLabel(0, sHeight-88, 350, 15, "_______________________________________________", false, GUI.wnd)
guiSetFont(GUI.lbl, "default-bold-small")
guiLabelSetHorizontalAlign(GUI.lbl, 'center')
guiLabelSetColor(GUI.lbl, 0, 0, 0)

GUI.btn_close = guiCreateButton(0, sHeight-65, 350, 25, "Вернуться в главное меню", false, GUI.wnd)
guiSetFont(GUI.btn_close, "default-bold-small")
guiSetProperty(GUI.btn_close, "NormalTextColour", "fff01a21")

GUI.wnd.visible = false

function VehicleAccessories.initList()
	guiGridListClear(GUI.gridlist_objects)
	guiGridListSetColumnTitle(GUI.gridlist_objects, 1, 'Каталог аксессуаров')

	for category, category_list in pairs(Config.accessories) do
		local row = guiGridListAddRow(GUI.gridlist_objects)

		guiGridListSetItemText(GUI.gridlist_objects, row, 1, '+ '..category, false, false)
		guiGridListSetItemData(GUI.gridlist_objects, row, 1, {objects = category_list, category = category})
	end
end

local function getGridListCategory(category)
	for i = 0, guiGridListGetRowCount(GUI.gridlist_addObjects) do
		if guiGridListGetItemText(GUI.gridlist_addObjects, i, 1) == category then
			return i
		end
	end

	return false
end

function VehicleAccessories.initAddObjectsList()
	guiGridListClear(GUI.gridlist_addObjects)

	local isAccessories = localPlayer.vehicle:getData('vehicle.isAccessories') or {}

	for _, accessories in ipairs(isAccessories) do
		local isCategory = getGridListCategory(accessories.category)

		if not isCategory then
			local rowCategory = guiGridListAddRow(GUI.gridlist_addObjects)
    		guiGridListSetItemText(GUI.gridlist_addObjects, rowCategory, 1, '   '..accessories.category, true, false)
    		guiGridListSetItemColor(GUI.gridlist_addObjects, rowCategory, 1, 33, 177, 255)
    	end

    	local row = guiGridListAddRow(GUI.gridlist_addObjects)

		if type(isCategory) == 'number' then
			row = guiGridListInsertRowAfter(GUI.gridlist_addObjects, isCategory)
		end

		guiGridListSetItemText(GUI.gridlist_addObjects, row, 1, ' '..accessories.tittle, false, false)
		guiGridListSetItemData(GUI.gridlist_addObjects, row, 1, accessories.object)

	end
end

function VehicleAccessories.setVisible()
	GUI.wnd.visible = not GUI.wnd.visible

	if GUI.wnd.visible then
		VehicleAccessories.initList()
		VehicleAccessories.initAddObjectsList()
	end

end
addEvent('operVehicleObject.setWndVisible', true)
addEventHandler('operVehicleObject.setWndVisible', root, VehicleAccessories.setVisible)


-- РАБОТА СО СПИСКОМ --
addEventHandler("onClientGUIDoubleClick", GUI.gridlist_objects, function() 
	if not guiGetVisible(GUI.wnd) then
		return
	end

	-- ОТКРЫТИЕ КАТЕГОРИИ --
	local sel = guiGridListGetSelectedItem(GUI.gridlist_objects)
    local item = guiGridListGetItemData(GUI.gridlist_objects, sel, 1) or ""

    if item ~= "" and item.objects and item ~= 'back' then
    	guiGridListClear(GUI.gridlist_objects)

    	guiGridListSetColumnTitle(GUI.gridlist_objects, 1, 'Список аксессуаров')

    	local row = guiGridListAddRow(GUI.gridlist_objects)
    	guiGridListSetItemText(GUI.gridlist_objects, row, 1, '..', false, false)
   		guiGridListSetItemData(GUI.gridlist_objects, row, 1, 'back')

   		for _, object in ipairs(item.objects) do
   			local row = guiGridListAddRow(GUI.gridlist_objects)
    		guiGridListSetItemText(GUI.gridlist_objects, row, 1, '   '..object.tittle, false, false)

    		local objectData = {model = object.model, category = item.category}
    		guiGridListSetItemData(GUI.gridlist_objects, row, 1, objectData)
   		end
   	else
   		VehicleAccessories.stopPreviewObject()
    end
    ------------------------

    -- ВЫХОД ИЗ КАТЕГОРИИ --
    if item ~= '' and item == "back" then
    	VehicleAccessories.stopPreviewObject()
	 	VehicleAccessories.initList()
    end
    ------------------------

end)

addEventHandler("onClientGUIClick", root, function() 
	if not guiGetVisible(GUI.wnd) then
		return
	end

	-- Каталог аксессуаров --
	local sel = guiGridListGetSelectedItem(GUI.gridlist_objects)
    local item = guiGridListGetItemData(GUI.gridlist_objects, sel, 1) or ""

    if item ~= "" and type(item.model) == 'number' and source == GUI.gridlist_objects then
    	VehicleAccessories.startPreviewObject(tonumber(item.model))

    	guiGridListSetSelectedItem(GUI.gridlist_addObjects, 0, 0)
    	guiSetEnabled(GUI.btn_obj_remove, false)
    	guiSetEnabled(GUI.btn_obj_defaultScale, false)
    	guiSetEnabled(GUI.btn_obj_defaultRot, false)

    	return
    elseif source == GUI.btn_close then
    	VehicleAccessories.setVisible()
    	triggerEvent('TuningGarage.setWindowVisible', localPlayer, true)

    elseif source == GUI.btn_obj_add then -- добавить аксессуар
    	guiGridListSetSelectedItem(GUI.gridlist_objects, 0, 0)
   		local itemText = guiGridListGetItemText(GUI.gridlist_objects, sel, 1) 

    	triggerServerEvent('operVehicleObject.addVehicleAccessories', localPlayer, localPlayer.vehicle, tonumber(item.model), itemText, item.category)
    	guiSetEnabled(GUI.wnd, false)

    	setTimer(function()
    		VehicleAccessories.initAddObjectsList()
    		guiSetEnabled(GUI.wnd, true)
    	end, 1000, 1)

    elseif source == GUI.btn_veh_door then
    	local state = 100.0

    	if getVehicleDoorOpenRatio(localPlayer.vehicle, 2) == 1 then
    		state = 0.0
    	end

    	triggerServerEvent('exv_vehControl.setDoorRatio', root, localPlayer.vehicle, 'doors', state)
    elseif source == GUI.btn_veh_backdoor then
    	local state = 100.0

    	if getVehicleDoorOpenRatio(localPlayer.vehicle, 1) == 1 then
    		state = 0.0
    	end

    	triggerServerEvent('exv_vehControl.setDoorRatio', root, localPlayer.vehicle, 'trunk', state)
    end

    -- Установленные объекты --
   	local sel = guiGridListGetSelectedItem(GUI.gridlist_addObjects)
    local isObject = guiGridListGetItemData(GUI.gridlist_addObjects, sel, 1) or ""

    if isObject ~= "" and source == GUI.gridlist_addObjects then
    	guiSetEnabled(GUI.btn_obj_remove, true)
    	guiSetEnabled(GUI.btn_obj_defaultScale, true)
    	guiSetEnabled(GUI.btn_obj_defaultRot, true)

    	isObject.alpha = 255
    	isPreviewObject = isObject

    	local isAccessories = localPlayer.vehicle:getData('vehicle.isAccessories') or {}

		for _, accessories in ipairs(isAccessories) do
			if accessories.object ~= isObject then
				accessories.object.alpha = 50
			end
		end

    	if not isPreviewActivate then
    		addEventHandler("onClientPreRender", root, dxDrawCordinats)
    		addEventHandler("onClientPreRender", root, VehicleAccessories.onKey)
    	end

    	return
    elseif source == GUI.btn_obj_remove then -- удалить аксессуар
    	triggerServerEvent('operVehicleObject.removeVehicleAccessories', localPlayer, localPlayer.vehicle, isObject)
    	guiSetEnabled(GUI.wnd, false)

    	setTimer(function()
    		VehicleAccessories.initAddObjectsList()
    		guiSetEnabled(GUI.wnd, true)
    	end, 1000, 1)
    elseif source == GUI.btn_obj_defaultRot then
    	local posX, posY, posZ, rotsX, rotsY, rotsZ = getElementAttachedOffsets(isPreviewObject)
    	local scaleX, scaleY = getObjectScale(isPreviewObject)
    	triggerServerEvent('operVehicleObject.updateVehicleAccessories', localPlayer, localPlayer.vehicle, isPreviewObject, posX, posY, posZ, 0, 0, 0, scaleX)

    	return
    elseif source == GUI.btn_obj_defaultScale then
    	local posX, posY, posZ, rotsX, rotsY, rotsZ = getElementAttachedOffsets(isPreviewObject)
    	local scaleX, scaleY = getObjectScale(isPreviewObject)
    	triggerServerEvent('operVehicleObject.updateVehicleAccessories', localPlayer, localPlayer.vehicle, isPreviewObject, posX, posY, posZ, rotsX, rotsY, rotsZ, 1.0)

    	return
    else
    	guiGridListSetSelectedItem(GUI.gridlist_addObjects, 0, 0)
    	guiSetEnabled(GUI.btn_obj_remove, false)
    	guiSetEnabled(GUI.btn_obj_defaultScale, false)
    	guiSetEnabled(GUI.btn_obj_defaultRot, false)

    	local isAccessories = localPlayer.vehicle:getData('vehicle.isAccessories') or {}

		for _, accessories in ipairs(isAccessories) do
			accessories.object.alpha = 255
		end

    	removeEventHandler("onClientPreRender", root, dxDrawCordinats)
    	removeEventHandler("onClientPreRender", root, VehicleAccessories.onKey)
    	isPreviewActivate = false
    end


   	VehicleAccessories.stopPreviewObject()

end)


--VehicleAccessories.initList()
--GUI.wnd.visible = true
--showCursor(true)

--triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
