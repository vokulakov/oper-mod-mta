local sWidth, sHeight = guiGetScreenSize()

GUI = {}

GUI.btn_vinyl = {}		-- элементы кнопок (винилы)

local currentList = 1 	-- текущая страница
local maxList 		  	-- всего страниц
local currentVinylBtn 	-- текущая кнопка (винил)
local currentVehicleVinyl
local currentColorType
local r1, g1, b1, r2, g2, b2

GUI.wnd = GuiWindow(15, 15, 350, sHeight-25, "Винилы", false)
guiWindowSetSizable(GUI.wnd, false)
guiWindowSetMovable(GUI.wnd, false)
GUI.wnd.visible = false

GUI.btn_prev = guiCreateButton(350/2-100, sHeight-205, 30, 32, "<", false, GUI.wnd)
guiSetFont(GUI.btn_prev, "default-bold-small")
guiSetProperty(GUI.btn_prev, "NormalTextColour", "FF21b1ff")

GUI.lbl_list = guiCreateLabel(0, sHeight-205+8, 350, 15, "", false, GUI.wnd)
guiSetFont(GUI.lbl_list, "default-bold-small")
guiLabelSetHorizontalAlign(GUI.lbl_list, 'center')

GUI.btn_next = guiCreateButton(350/2+100-30, sHeight-205, 30, 32, ">", false, GUI.wnd)
guiSetFont(GUI.btn_next, "default-bold-small")
guiSetProperty(GUI.btn_next, "NormalTextColour", "FF21b1ff")

GUI.lbl = guiCreateLabel(0, sHeight-65-85-23, 350, 15, "_______________________________________________", false, GUI.wnd)
guiSetFont(GUI.lbl, "default-bold-small")
guiLabelSetHorizontalAlign(GUI.lbl, 'center')
guiLabelSetColor(GUI.lbl, 0, 0, 0)
-- --
GUI.btn_apply = guiCreateButton(0, sHeight-65-85, 350, 35, "Затянуться пленкой", false, GUI.wnd)
guiSetFont(GUI.btn_apply, "default-bold-small")
guiSetProperty(GUI.btn_apply, "NormalTextColour", "FF21b1ff")
guiSetEnabled(GUI.btn_apply, false)

GUI.btn_remove = guiCreateButton(0, sHeight-65-45, 350, 25, "Расклеиться", false, GUI.wnd)
guiSetFont(GUI.btn_remove, "default-bold-small")
guiSetEnabled(GUI.btn_remove, false)

GUI.lbl = guiCreateLabel(0, sHeight-88, 350, 15, "_______________________________________________", false, GUI.wnd)
guiSetFont(GUI.lbl, "default-bold-small")
guiLabelSetHorizontalAlign(GUI.lbl, 'center')
guiLabelSetColor(GUI.lbl, 0, 0, 0)

GUI.btn_close = guiCreateButton(0, sHeight-65, 350, 25, "Вернуться в главное меню", false, GUI.wnd)
guiSetFont(GUI.btn_close, "default-bold-small")
guiSetProperty(GUI.btn_close, "NormalTextColour", "fff01a21")

function GUI.getRowAndListCount() -- расчитаем сколько будет страниц
	local rowCount = -1

	repeat
		rowCount = rowCount + 1
		local Width = 30+rowCount*64+rowCount*5
	until (Width > sHeight - 230)

	local listCount = math.ceil(#VehicleVinyls.img/(5*rowCount))
	

	return rowCount - 1, listCount
end

function GUI.initVinylList()
	local row, list = GUI.getRowAndListCount()
	
	local vinyl_count = 0

	for listCount = 1, list do -- количество листов
		for rowCount = 0, row do -- количество рядов в листе
			for count = 0, 4 do -- количество винилов в ряде

				vinyl_count = vinyl_count + 1

				if VehicleVinyls.img[vinyl_count] then
					local btn = guiCreateStaticImage(10+count*64+count*5, 30+rowCount*64+rowCount*5, 52, 52, VehicleVinyls.img[vinyl_count], false, GUI.wnd)

					GUI.btn_vinyl[btn] = { list = listCount, id = vinyl_count, element = btn }

					GUI.btn_vinyl[btn].element.alpha = 0.5

					GUI.btn_vinyl[btn].element.visible = false
					GUI.btn_vinyl[btn].element.enabled = false
				end

			end
		end
	end

	maxList = list

	guiSetText(GUI.lbl_list, currentList..' из '..maxList)
end

GUI.initVinylList()

function GUI.updateVinylList()

	for _, btn in pairs(GUI.btn_vinyl) do
		local state = false

		if btn.list == currentList then
			state = true
		end

		btn.element.visible = state
		btn.element.enabled = state
	end

	guiSetText(GUI.lbl_list, currentList..' из '..maxList)
end

addEventHandler("onClientGUIClick", root, function()
	if not GUI.wnd.visible then
		return
	end

	local vehicle = localPlayer.vehicle

	if GUI.btn_vinyl[source] then 
		if isElement(currentVinylBtn) then
			GUI.btn_vinyl[currentVinylBtn].element.alpha = 0.5
		end

		-- ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТ ВИНИЛА --
		local vinyl_id = GUI.btn_vinyl[source].id
		vehicle:setData('vehicle.colorType', 'stock') 
		setVehicleColor(vehicle, 255, 255, 255, 255, 255, 255)
		VehicleVinyls.updateVehicleVinul(vehicle, vinyl_id)
		------------------------------------

		GUI.btn_vinyl[source].element.alpha = 1
		guiSetEnabled(GUI.btn_apply, true)
		currentVinylBtn = source

		return
	elseif source == GUI.btn_apply then
		currentVehicleVinyl = GUI.btn_vinyl[currentVinylBtn].id
		triggerServerEvent('operVehicleVinyl.setVehicleVinyls', localPlayer, vehicle, GUI.btn_vinyl[currentVinylBtn].id)
		guiSetEnabled(GUI.btn_remove, true)
		return

	elseif source == GUI.btn_remove then
		currentVehicleVinyl = false

		triggerServerEvent('operVehicleVinyl.setVehicleVinyls', localPlayer, vehicle, false, currentColorType, r1, g1, b1, r2, g2, b2)
		return

	elseif source == GUI.btn_close then
    	GUI.setVisible()
    	triggerEvent('TuningGarage.setWindowVisible', localPlayer, true)

	elseif source == GUI.btn_next then -- следующая страница
		currentList = currentList + 1
		if currentList > maxList then
			currentList = 1
		end

		return GUI.updateVinylList()

	elseif source == GUI.btn_prev then -- предыдушая страница
		currentList = currentList - 1
		if currentList == 0 then
			currentList = maxList
		end

		return GUI.updateVinylList()

	else
		if isElement(currentVinylBtn) then
			GUI.btn_vinyl[currentVinylBtn].element.alpha = 0.5
		end
		guiSetEnabled(GUI.btn_apply, false)
	end

	-- сбросить винил --
	if not currentVehicleVinyl then
		vehicle:setData('vehicle.colorType', currentColorType)
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		VehicleVinyls.destroyVehicleVinyl(vehicle)
	else
		VehicleVinyls.updateVehicleVinul(vehicle, currentVehicleVinyl)
	end
end)

addEventHandler("onClientMouseEnter", root, function()
	if not GUI.wnd.visible then
		return
	end

	if GUI.btn_vinyl[source] and currentVinylBtn ~= source then 
		GUI.btn_vinyl[source].element.alpha = 1
	end
end)
	
addEventHandler("onClientMouseLeave", root, function()
	if not GUI.wnd.visible then
		return
	end

	if GUI.btn_vinyl[source] and currentVinylBtn ~= source then 
		GUI.btn_vinyl[source].element.alpha = 0.5
	end
end)


--GUI.wnd.visible = true
--showCursor(false)
--triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
--GUI.initVinylList()

function GUI.setVisible()
	GUI.wnd.visible = not GUI.wnd.visible
	if GUI.wnd.visible then
		currentVehicleVinyl = localPlayer.vehicle:getData('vehicle.isVinyl') or false

		if currentVehicleVinyl then
			guiSetEnabled(GUI.btn_remove, true)
		else
			guiSetEnabled(GUI.btn_remove, false)
		end

		currentColorType = localPlayer.vehicle:getData('vehicle.colorType') 
		r1, g1, b1, r2, g2, b2 = getVehicleColor(localPlayer.vehicle, true)

		GUI.updateVinylList()
	end
end
addEvent('operVehicleVinyl.setWndVisible', true)
addEventHandler('operVehicleVinyl.setWndVisible', root, GUI.setVisible)
