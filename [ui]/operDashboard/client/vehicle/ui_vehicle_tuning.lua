VehicleTuning = {}

VehicleTuning.Window = {}

VehicleTuning.Window.isVisible = false

VehicleTuning.Window.wnd = guiCreateWindow(sWidth/2-380/2, sHeight/2-160/2, 380, 160, "Тюнинг транспортного средства", false)
guiWindowSetSizable(VehicleTuning.Window.wnd, false)
guiSetVisible(VehicleTuning.Window.wnd, false)
guiWindowSetMovable(VehicleTuning.Window.wnd, false)

VehicleTuning.Window.lbl = guiCreateLabel(0, 0, 380, 125, "Добро пожаловать!\n\nВ нашем гараже, вы можете прокачать свое\nтранспортное средство.", false, VehicleTuning.Window.wnd)
guiSetFont(VehicleTuning.Window.lbl, "default-bold-small")
--guiLabelSetColor(VehicleTuning.Window.lbl, 33, 177, 255)
guiLabelSetHorizontalAlign(VehicleTuning.Window.lbl, 'center')
guiLabelSetVerticalAlign(VehicleTuning.Window.lbl, 'center')

VehicleTuning.Window.btn_garage = guiCreateButton(0, 120, 225, 25, "Перейти в гараж", false, VehicleTuning.Window.wnd)
guiSetFont(VehicleTuning.Window.btn_garage, "default-bold-small")
guiSetProperty(VehicleTuning.Window.btn_garage, "NormalTextColour", "FF21b1ff")
VehicleTuning.Window.btn_garage:setData('operSounds.UI', 'ui_select')

VehicleTuning.Window.btn_exit = guiCreateButton(240, 120, 130, 25, "Отмена", false,VehicleTuning.Window.wnd)
guiSetFont(VehicleTuning.Window.btn_exit, "default-bold-small")
guiSetProperty(VehicleTuning.Window.btn_exit, "NormalTextColour", "fff01a21")
VehicleTuning.Window.btn_exit:setData('operSounds.UI', 'ui_back')
--VehicleTuning.Window.tabPanel = guiCreateTabPanel(0, 25, 585, 315, false, VehicleTuning.Window.wnd)



function VehicleTuning.Window.setVisible(state)
	if state == nil then
		VehicleTuning.Window.isVisible = not guiGetVisible(VehicleTuning.Window.wnd)
	else
		VehicleTuning.Window.isVisible = state
	end

	guiSetEnabled(VehicleTuning.Window.wnd, true)

	guiSetVisible(VehicleTuning.Window.wnd, VehicleTuning.Window.isVisible)

	showCursor(VehicleTuning.Window.isVisible)
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, not VehicleTuning.Window.isVisible)
	triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'dashboard', true) -- не отключать dashboard

	showChat(not VehicleTuning.Window.isVisible)
	triggerEvent('operShowUI.drawBlurShader', localPlayer, VehicleTuning.Window.isVisible)
	--triggerEvent('operShowUI.drawLogoProject', localPlayer, VehicleTuning.Window.isVisible)

end

bindKey('f3', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    if type(PLAYER_UI) == 'boolean' then return end
	if not PLAYER_UI['dashboard'] then return end

	--if localPlayer:getData('operLoginPanel:isVisible') then
		--return
	--end

	local vehicle = localPlayer:getData('player.isVehicle') -- свой транспорт

	if not localPlayer.vehicle or localPlayer.vehicle.controller ~= localPlayer then--or not Vehicle.activeEvent then
		return
	end

	if localPlayer.vehicle ~= vehicle then
		triggerEvent('operNotification.addNotification', localPlayer, "Вы можете тюнинговать только\nсобственный транспорт!", 2, true)
		return
	end
--[[
	if VehicleTuning.Window.isVisible then
		VehicleTuning.Window.isVisible = false
		exports.operTuningGarage:playerExitGarage()
	else
		VehicleTuning.Window.isVisible = true
		exports.operTuningGarage:playerEnterGarage()
	end
]]
	Dashboard.activeWindowShow(VehicleTuning.Window.wnd)

	VehicleTuning.Window.setVisible()
end)

addEventHandler('onClientGUIClick', root, function()
	if not guiGetVisible(VehicleTuning.Window.wnd) then
		return
	end

	if source == VehicleTuning.Window.btn_exit then
		VehicleTuning.Window.setVisible(false)
	elseif source == VehicleTuning.Window.btn_garage then
		VehicleTuning.Window.setVisible(false)
		exports.operTuningGarage:playerEnterGarage()
		triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'notify', true) -- не отключать notify
	end
end)
--guiSetVisible(VehicleTuning.Window.wnd, true)
--showCursor(true)


-- Покраска
-- Тонировка
-- Винил
-- Фары (установка ксенона)
-- Номерные знаки
-- Сигнал
-- Компоненты: 	
			--	открытие/закрытие дверей 
			--	снятие/установка деталей
			-- 	добавить/удалить объект
-- Колеса
-- Стробоскопы
-- Вспышки ФСО
-- СГУ

--[[
	
	!Во время тюнинга можно нажать на правую кнопку мыши и покрутить камеру вокруг авто
	!Во время тюнинга автомобиль фиксируется на месте и делается не повреждаемым (ghost mod)
	!Все что делается с автомобилем, изначально видит только владелец авто,
	 после нажатия на кнопку "Применить" видят все игроки сервера.

--]]