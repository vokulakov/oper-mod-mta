Dashboard.vehWindow = {}

local vehicles = exports.operVehicleSystem.getVehiclesList() -- список автомобилей

Dashboard.vehWindow['wnd'] = guiCreateWindow(15, 15, 300, sHeight - 25, "Создание транспорта", false)
guiWindowSetSizable(Dashboard.vehWindow['wnd'], false)
guiSetVisible(Dashboard.vehWindow['wnd'], false)
guiWindowSetMovable(Dashboard.vehWindow['wnd'], false)

Dashboard.vehWindow['listVehicle'] = guiCreateGridList(0, 30, 300, sHeight - 25 - 105, false, Dashboard.vehWindow['wnd'])
guiGridListSetSortingEnabled(Dashboard.vehWindow['listVehicle'], false)
guiGridListAddColumn(Dashboard.vehWindow['listVehicle'], "", 0.9)
--guiGridListAddColumn(Dashboard.vehWindow['listVehicle'], "", 0.8)

--
Dashboard.vehWindow['btn_remove'] = guiCreateButton(0, sHeight - 25 - 35 - 30, 300, 25, "Убрать текущий транспорт", false, Dashboard.vehWindow['wnd'])
guiSetFont(Dashboard.vehWindow['btn_remove'], "default-bold-small")
guiSetProperty(Dashboard.vehWindow['btn_remove'], "NormalTextColour", "fff01a21")
guiSetEnabled(Dashboard.vehWindow['btn_remove'], false)
Dashboard.vehWindow['btn_remove']:setData('operSounds.UI', 'ui_select')
--
-- 335
Dashboard.vehWindow['btn_close'] = guiCreateButton(0, sHeight - 25 - 35, 300, 25, "Закрыть", false, Dashboard.vehWindow['wnd'])
guiSetFont(Dashboard.vehWindow['btn_close'], "default-bold-small")

Dashboard.vehWindow['btn_close']:setData('operSounds.UI', 'ui_back')

function Dashboard.vehWindow.initList()
	guiGridListClear(Dashboard.vehWindow['listVehicle'])
	guiGridListSetColumnTitle(Dashboard.vehWindow['listVehicle'] , 1, 'Категории транспорта')

	for category, category_list in pairs(vehicles) do
		local row = guiGridListAddRow(Dashboard.vehWindow['listVehicle'])

		guiGridListSetItemText(Dashboard.vehWindow['listVehicle'], row, 1, '+ '..category, false, false)
		guiGridListSetItemData(Dashboard.vehWindow['listVehicle'], row, 1, category_list)
	end
end

Dashboard.vehWindow.initList()

function Dashboard.vehWindow.setVisible(state)
	guiSetVisible(Dashboard.vehWindow['wnd'], state)
    triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'radar', not state) 

    if not guiGetVisible(Dashboard.wnd) then
        triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'chat', not state) 
    end
    
	if state then
		if localPlayer:getData('player.isVehicle') then
			guiSetEnabled(Dashboard.vehWindow['btn_remove'], true)
		else
			guiSetEnabled(Dashboard.vehWindow['btn_remove'], false)
		end
	end

end
-- РАБОТА СО СПИСКОМ

addEventHandler("onClientGUIDoubleClick", Dashboard.vehWindow['listVehicle'], function() 
	if not guiGetVisible(Dashboard.vehWindow['wnd']) then
		return
	end

	-- ОТКРЫТИЕ КАТЕГОРИИ --
	local sel = guiGridListGetSelectedItem(Dashboard.vehWindow['listVehicle'])
    local item = guiGridListGetItemData(Dashboard.vehWindow['listVehicle'], sel, 1) or ""

    if item ~= "" and type(item) == 'number' then
    	Dashboard.vehWindow.setVisible(false)
    	showCursor(false)

    	triggerServerEvent('operVehicleSystem.spawnVehicle', root, localPlayer, tonumber(item))
    	return
    end

    if item ~= "" and item ~= 'back' then
    	guiGridListClear(Dashboard.vehWindow['listVehicle'])

    	guiGridListSetColumnTitle(Dashboard.vehWindow['listVehicle'] , 1, 'Список транспорта')

    	local row = guiGridListAddRow(Dashboard.vehWindow['listVehicle'])
    	guiGridListSetItemText(Dashboard.vehWindow['listVehicle'], row, 1, '..', false, false)
   		guiGridListSetItemData(Dashboard.vehWindow['listVehicle'], row, 1, 'back')

   		for tittle, brandList in pairs(item) do -- страна производитель
   			local row = guiGridListAddRow(Dashboard.vehWindow['listVehicle'])
    		guiGridListSetItemText(Dashboard.vehWindow['listVehicle'], row, 1, tittle, true, false)
    		--guiGridListSetItemColor(Dashboard.vehWindow['listVehicle'], row, 1, 0, 255, 0)

    		for brand, brandVehicles in pairs(brandList) do -- брэнд
    			local row = guiGridListAddRow(Dashboard.vehWindow['listVehicle'])
    			guiGridListSetItemText(Dashboard.vehWindow['listVehicle'], row, 1, '  '..brand, true, false)
    			guiGridListSetItemColor(Dashboard.vehWindow['listVehicle'], row, 1, 33, 177, 255)

    			for _, vehicle in ipairs(brandVehicles) do -- транспорт
    				local row = guiGridListAddRow(Dashboard.vehWindow['listVehicle'])
    				guiGridListSetItemText(Dashboard.vehWindow['listVehicle'], row, 1, ' '..vehicle.name or getVehicleNameFromModel(vehicle.id), false, false)
    				guiGridListSetItemData(Dashboard.vehWindow['listVehicle'], row, 1, vehicle.id)
    				--guiGridListSetItemColor(Dashboard.vehWindow['listVehicle'], row, 1, 0, 255, 0)
    			end

    			local row = guiGridListAddRow(Dashboard.vehWindow['listVehicle'])
    			guiGridListSetItemText(Dashboard.vehWindow['listVehicle'], row, 1, '', true, false)
    		end
   			--guiGridListSetItemData(Dashboard.vehWindow['listVehicle'], row, 1, vehicle.model)
   		end

    end
    ------------------------

    -- ВЫХОД ИЗ КАТЕГОРИИ --
    if item ~= '' and item == "back" then
	 	Dashboard.vehWindow.initList()
    end
    ------------------------

end)