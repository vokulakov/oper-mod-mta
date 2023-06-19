Vehicle.Window = {}

Vehicle.activeEvent = nil
local optionAllowed = {} -- доступные опции для личного авто

local isWindowComponentVisible = false

Vehicle.Window.isVisible = false

Vehicle.Window.wnd = guiCreateWindow(15, sHeight/2-450/2-80, 230, 450, "Меню управления транспортом", false)
guiWindowSetSizable(Vehicle.Window.wnd, false)
guiSetVisible(Vehicle.Window.wnd, false)
guiWindowSetMovable(Vehicle.Window.wnd, false)

Vehicle.Window.btn_flip = guiCreateButton(0, 25, 230, 25, "Перевернуть", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_flip, "default-bold-small")
guiSetProperty(Vehicle.Window.btn_flip, "NormalTextColour", "FFC8C8C8")
Vehicle.Window.btn_flip:setData('operSounds.UI', 'ui_select')

Vehicle.Window.btn_repair = guiCreateButton(0, 55, 230, 25, "Починить", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_repair, "default-bold-small")
guiSetProperty(Vehicle.Window.btn_repair, "NormalTextColour", "FF21b1ff")
Vehicle.Window.btn_repair:setData('operSounds.UI', 'ui_select')

Vehicle.Window.btn_exitall = guiCreateButton(0, 85, 230, 25, "Высадить всех", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_exitall, "default-bold-small")
guiSetProperty(Vehicle.Window.btn_exitall, "NormalTextColour", "FFC8C8C8")
optionAllowed[Vehicle.Window.btn_exitall] = true
Vehicle.Window.btn_exitall:setData('operSounds.UI', 'ui_select')

Vehicle.Window.btn_tome = guiCreateButton(0, 115, 230, 25, "Пригнать ко мне", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_tome, "default-bold-small")
guiSetProperty(Vehicle.Window.btn_tome, "NormalTextColour", "FF21b1ff")
optionAllowed[Vehicle.Window.btn_tome] = true
Vehicle.Window.btn_tome:setData('operSounds.UI', 'ui_select')

Vehicle.Window.btn_handbrake = guiCreateButton(0, 145, 230, 25, "Поставить на ручник", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_handbrake, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_handbrake, false)
guiSetProperty(Vehicle.Window.btn_handbrake, "NormalTextColour", "FFC8C8C8")
Vehicle.Window.btn_handbrake:setData('operSounds.UI', 'ui_select')

Vehicle.Window.btn_components = guiCreateButton(0, 175, 230, 25, "Управление компонентами", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_components, "default-bold-small")
guiSetProperty(Vehicle.Window.btn_components, "NormalTextColour", "FFC8C8C8")
Vehicle.Window.btn_components:setData('operSounds.UI', 'ui_select')

Vehicle.Window.btn_settings = guiCreateButton(0, 235, 230, 25, "Прочие настройки", false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_settings, "default-bold-small")
guiSetProperty(Vehicle.Window.btn_settings, "NormalTextColour", "FFC8C8C8")
Vehicle.Window.btn_settings:setData('operSounds.UI', 'ui_select')
-- Опции
Vehicle.Window.btn_ghost = guiCreateCheckBox(0, 270, 120, 20, " Анти-таран", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_ghost, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_ghost, false)
Vehicle.Window.btn_ghost:setData('operSounds.UI', 'ui_change')

Vehicle.Window.btn_nodamage = guiCreateCheckBox(0, 290, 180, 20, " Отключить повреждения", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_nodamage, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_nodamage, false)
optionAllowed[Vehicle.Window.btn_nodamage] = true
Vehicle.Window.btn_nodamage:setData('operSounds.UI', 'ui_change')

Vehicle.Window.btn_noexplosion = guiCreateCheckBox(0, 310, 180, 20, " Отключить взрыв", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_noexplosion, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_noexplosion, false)
optionAllowed[Vehicle.Window.btn_noexplosion] = true
Vehicle.Window.btn_noexplosion:setData('operSounds.UI', 'ui_change')

Vehicle.Window.btn_nooccupant = guiCreateCheckBox(0, 330, 200, 40, " Запретить садиться в мой\n транспорт", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_nooccupant, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_nooccupant, false)
optionAllowed[Vehicle.Window.btn_nooccupant] = true
Vehicle.Window.btn_nooccupant:setData('operSounds.UI', 'ui_change')

Vehicle.Window.btn_nodriver = guiCreateCheckBox(0, 360, 200, 40, " Запретить садиться за руль\n моего транспорта", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_nodriver, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_nodriver, false)
optionAllowed[Vehicle.Window.btn_nodriver] = true
Vehicle.Window.btn_nodriver:setData('operSounds.UI', 'ui_change')

Vehicle.Window.btn_waterdrive = guiCreateCheckBox(0, 400, 200, 20, " Возможность ездить по воде", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_waterdrive, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_waterdrive, false)
Vehicle.Window.btn_waterdrive:setData('operSounds.UI', 'ui_change')

Vehicle.Window.btn_flydrive = guiCreateCheckBox(0, 420, 200, 20, " Режим полета", false, false, Vehicle.Window.wnd)
guiSetFont(Vehicle.Window.btn_flydrive, "default-bold-small")
guiSetEnabled(Vehicle.Window.btn_flydrive, false)
Vehicle.Window.btn_flydrive:setData('operSounds.UI', 'ui_change')

function Vehicle.Window.setVisible(state, isCockpit)
	if state == nil then
		Vehicle.Window.isVisible = not guiGetVisible(Vehicle.Window.wnd)
	else
		Vehicle.Window.isVisible = state
	end

	--guiSetPosition(Vehicle.Window.wnd, 15, sHeight/2-430/2, false) -- исходное положение 
	guiSetEnabled(Vehicle.Window.wnd, true)

	guiSetVisible(Vehicle.Window.wnd, Vehicle.Window.isVisible)

	if isWindowComponentVisible then
		exports.operVehicleSystem:toggleMoveComponentPanel(Vehicle.Window.isVisible)

		if not isCockpit then
			triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'speed', not Vehicle.Window.isVisible) 
			triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'control', not Vehicle.Window.isVisible) 
			triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'notify', not Vehicle.Window.isVisible)
		end
	end
	--isWindowComponentVisible = exports.operVehicleSystem:toggleMoveComponentPanel(false)

	if Vehicle.Window_setting.isVisible then

		if 	localPlayer.vehicle then
			Vehicle.Window_setting.wnd.visible = Vehicle.Window.isVisible

			if not isCockpit then
				triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'speed', not Vehicle.Window.isVisible) 
				triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'control', not Vehicle.Window.isVisible) 
				triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'notify', not Vehicle.Window.isVisible)
			end
		end
	end

	if not isCockpit then
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'chat', not Vehicle.Window.isVisible) 
	end

	showCursor(Vehicle.Window.isVisible)
end
--[[
function Vehicle.Window.getVehicleProperty(vehicle)
	local VehiclesProperty = vehicle:getData('vehicle.isProperty')

	if VehiclesProperty.damageproof then
	end


end
]]
function Vehicle.Window.update()
	local vehicle = localPlayer:getData('player.isVehicle') -- свой транспорт

	-- проверять опции автомобиля и активировать/деактивировать чекбоксы
	if isElement(vehicle) then
		local VehiclesProperty = vehicle:getData('vehicle.isProperty')
		guiCheckBoxSetSelected(Vehicle.Window.btn_ghost, VehiclesProperty.ghostmode or false)
		guiCheckBoxSetSelected(Vehicle.Window.btn_nodamage, VehiclesProperty.damageproof or false)
		guiCheckBoxSetSelected(Vehicle.Window.btn_noexplosion, VehiclesProperty.explosion or false)
		guiCheckBoxSetSelected(Vehicle.Window.btn_waterdrive, VehiclesProperty.hovercars or false)
		guiCheckBoxSetSelected(Vehicle.Window.btn_flydrive, VehiclesProperty.aircars or false)

		--guiCheckBoxSetSelected(Vehicle.Window.btn_nodriver, VehiclesProperty.enterAllowed.isDriver or false)
		--guiCheckBoxSetSelected(Vehicle.Window.btn_nooccupant, VehiclesProperty.aircars or false)
	end

	for _, button in pairs(Vehicle.Window) do -- отключаем все кнопки
		if type(button) ~= 'function' and type(button) ~= 'boolean' then
			guiSetEnabled(button, false)
		end
	end

	if not localPlayer.vehicle or localPlayer.vehicle.controller ~= localPlayer then--or not Vehicle.activeEvent then

		if not vehicle then
			return false
		end

		for _, button in pairs(Vehicle.Window) do -- включаем кнопки
			if type(button) ~= 'function' and type(button) ~= 'boolean' then
				if vehicle and optionAllowed[button] then
					guiSetEnabled(button, true)
				end
			end
		end

		return true
	end

	for _, button in pairs(Vehicle.Window) do -- включаем все кнопки
		if type(button) ~= 'function' and type(button) ~= 'boolean' then
			if not vehicle and optionAllowed[button] then
				break
			end
			guiSetEnabled(button, true)
		end
	end

	guiSetEnabled(Vehicle.Window.btn_tome, false)
	--guiSetEnabled(Vehicle.Window.btn_components, false)
	
	return true
end

bindKey('f2', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
	local isCockpit = exports.operCameraViews:getCockpitViewState()

    if type(PLAYER_UI) == 'boolean' then return end
	if not PLAYER_UI['dashboard'] then 
		if not isCockpit then
			return 
		end
	end

	--if localPlayer:getData('operLoginPanel:isVisible') then
		--return
	--end

	if not Vehicle.Window.update() then
		return
	end

	Dashboard.activeWindowShow(Vehicle.Window.wnd)
	Vehicle.Window.setVisible(_, isCockpit)
end)

addEventHandler("onClientGUIClick", root, function()
	if not Vehicle.Window.isVisible then
		return
	end

	if source == Vehicle.Window.btn_flip then
		exports.operVehicleSystem:flipVehicle()
	elseif source == Vehicle.Window.btn_repair then
		triggerServerEvent('VehicleFunctions.repairVehicle', localPlayer)
	elseif source == Vehicle.Window.btn_tome then
		triggerServerEvent('VehicleFunctions.warpVehicle', localPlayer)
	elseif source == Vehicle.Window.btn_handbrake then
		triggerServerEvent('VehicleFunctions.handbrake', localPlayer)

		if not isElementFrozen(localPlayer.vehicle) then
			guiSetProperty(Vehicle.Window.btn_handbrake, "NormalTextColour", "fff01a21")
			guiSetText(Vehicle.Window.btn_handbrake, 'Снять с ручника')
		else
			guiSetProperty(Vehicle.Window.btn_handbrake, "NormalTextColour", "FFC8C8C8")
			guiSetText(Vehicle.Window.btn_handbrake, 'Поставить на ручник')
		end

	elseif source == Vehicle.Window.btn_exitall then
		-- проверку на дистанцию
		exports.operVehicleSystem:exitOccupants()


	elseif source == Vehicle.Window.btn_waterdrive then
		triggerServerEvent('VehicleFunctions.setSpecialProperty', localPlayer, 'hovercars', guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window.btn_flydrive then
		triggerServerEvent('VehicleFunctions.setSpecialProperty', localPlayer, 'aircars', guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window.btn_ghost then
		triggerServerEvent('VehicleFunctions.setVehicleGhost', localPlayer, guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window.btn_nodamage then
		triggerServerEvent('VehicleFunctions.setVehicleDamage', localPlayer, guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window.btn_noexplosion then
		triggerServerEvent('VehicleFunctions.setVehicleExplosion', localPlayer, guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window.btn_nooccupant then
		triggerServerEvent('VehicleFunctions.setVehicleEnterAllowed', localPlayer, false, guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window.btn_nodriver then
		triggerServerEvent('VehicleFunctions.setVehicleEnterAllowed', localPlayer, true, guiCheckBoxGetSelected(source))

	elseif source == Vehicle.Window.btn_components then
		if Vehicle.Window_setting.isVisible then
			Vehicle.Window.changeVisibleSettingWnd()
		end

		Vehicle.Window.changeVisibleComponentWnd()
	elseif source == Vehicle.Window.btn_settings or source == Vehicle.Window_setting.btn_exit then
		if isWindowComponentVisible then
			Vehicle.Window.changeVisibleComponentWnd()
		end

		Vehicle.Window.changeVisibleSettingWnd()
	end
end)

function Vehicle.Window.changeVisibleComponentWnd()
	isWindowComponentVisible = exports.operVehicleSystem:toggleMoveComponentPanel(not isWindowComponentVisible)

	if isWindowComponentVisible then
		guiSetProperty(Vehicle.Window.btn_components, "NormalTextColour", "fff01a21")
	else
		guiSetProperty(Vehicle.Window.btn_components, "NormalTextColour", "FFC8C8C8")
	end

	if not exports.operCameraViews:getCockpitViewState() then
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'speed', not isWindowComponentVisible) 
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'control', not isWindowComponentVisible) 
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'notify', not isWindowComponentVisible)
	end
end

function Vehicle.Window.changeVisibleSettingWnd()
	Vehicle.Window_setting.wnd.visible = not Vehicle.Window_setting.wnd.visible
	Vehicle.Window_setting.isVisible = Vehicle.Window_setting.wnd.visible

	if Vehicle.Window_setting.isVisible then
		guiSetProperty(Vehicle.Window.btn_settings, "NormalTextColour", "fff01a21")
	else
		guiSetProperty(Vehicle.Window.btn_settings, "NormalTextColour", "FFC8C8C8")
	end

	if not exports.operCameraViews:getCockpitViewState() then
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'speed', not Vehicle.Window_setting.wnd.visible) 
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'control', not Vehicle.Window_setting.wnd.visible) 
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'notify', not Vehicle.Window_setting.wnd.visible)
	end
end

function Vehicle.Window.getVisible()
	return Vehicle.Window.isVisible
end

-- Проверка на наличие транспорта
addEventHandler("onClientPlayerVehicleEnter", root, function(vehicle)
	if source ~= localPlayer then
		return
	end

	if Vehicle.Window.isVisible then -- костыль, если игрок садится в авто и открывает окно
		Vehicle.Window.update()
		guiSetEnabled(Vehicle.Window.wnd, true)
    end
end)

addEventHandler("onClientPlayerVehicleExit", root, function(vehicle)
	if source ~= localPlayer then
		return
	end

	if Vehicle.Window.isVisible then
		Vehicle.Window.setVisible(false)
	elseif VehicleTuning.Window.isVisible then
		VehicleTuning.Window.setVisible(false)
	end
end)

