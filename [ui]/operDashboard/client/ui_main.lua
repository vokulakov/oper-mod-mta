sWidth, sHeight = guiGetScreenSize() 
Dashboard = { }

Dashboard.isVisible = false
Dashboard.activeWindow = nil

Dashboard.wnd = guiCreateWindow(15, sHeight/2-500/2-65, 230, 500, "Главное меню", false)
guiWindowSetSizable(Dashboard.wnd, false)
guiSetVisible(Dashboard.wnd, false)
guiWindowSetMovable(Dashboard.wnd, false)

function Dashboard.setVisible(state)
	if state == nil then
		Dashboard.isVisible = not guiGetVisible(Dashboard.wnd)
	else
		Dashboard.isVisible = state
	end

	if Dashboard.activeWindow == Dashboard.vehWindow['wnd'] or Dashboard.activeWindow == Dashboard.skinWindow['wnd'] or Dashboard.activeWindow == Dashboard.animWindow['wnd'] then -- если открыто меню создания транспорта
		if not Dashboard.isVisible and not guiGetVisible(Dashboard.activeWindow) then
			return
		end 

		if Dashboard.activeWindow == Dashboard.vehWindow['wnd'] then
			Dashboard.vehWindow.setVisible(not guiGetVisible(Dashboard.activeWindow))
		else
			guiSetVisible(Dashboard.activeWindow, not guiGetVisible(Dashboard.activeWindow))
		end

		if Dashboard.activeWindow == Dashboard.skinWindow['wnd'] or Dashboard.activeWindow == Dashboard.animWindow['wnd'] then
			triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'chat', not guiGetVisible(Dashboard.activeWindow)) 
		end

		showCursor(guiGetVisible(Dashboard.activeWindow))
		return
	end

	guiSetEnabled(Dashboard.wnd, true)

	triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'chat', not Dashboard.isVisible) 

	guiSetVisible(Dashboard.wnd, Dashboard.isVisible)


	showCursor(Dashboard.isVisible)

	if isElement(Dashboard.activeWindow) and not Dashboard.isVisible then
		destroyElement(Dashboard.activeWindow)
	end
end

function Dashboard.activeWindowShow(window) -- скрывать другие окна при открытии

	if getDashoboardVisible() and Dashboard.wnd ~= window then -- глвное меню
		Dashboard.setVisible(false)
	end

	if Vehicle.Window.isVisible and Vehicle.Window.wnd ~= window then -- управление транспортом
		Vehicle.Window.setVisible(false)
	end

	if VehicleTuning.Window.isVisible and VehicleTuning.Window.wnd ~= window then -- тюнинг транспорта
		VehicleTuning.Window.setVisible(false)
	end

	if Help.Window.isVisible and Help.Window.wnd ~= window then -- окно помощи
		Help.Window.setVisible(false)
	end

	if Dashboard.accountWindow.wnd ~= window and Dashboard.accountWindow.wnd.visible then -- панель игрока
		Dashboard.accountWindow.setVisible(false)
	end

	if guiGetVisible(Dashboard.mapWindow['wnd']) and Dashboard.mapWindow['wnd'] ~= window then -- карта
		Dashboard.mapWindow.setVisible(false)
	end

	if ShaderPanel.isVisible and ShaderPanel.wnd ~= window then -- настройка игры
		ShaderPanel.setVisible(false)
	end

end

activeWindowShow = Dashboard.activeWindowShow

bindKey('f1', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    if type(PLAYER_UI) == 'boolean' then return end
	if not PLAYER_UI['dashboard'] then return end

	--if localPlayer:getData('operLoginPanel:isVisible') then
		--return
	--end
	
	Dashboard.activeWindowShow(Dashboard.wnd)
	Dashboard.setVisible()
end)

-- PLAYER EVENTS --
addEventHandler("onClientGUIClick", root, function()
	if not Dashboard.isVisible then
		return
	end

	if source == Dashboard.plWindow['btn_jetpack'] then -- джетпак

		if localPlayer.vehicle then
			guiCheckBoxSetSelected(Dashboard.plWindow['btn_jetpack'], false)
			triggerEvent('operNotification.addNotification', localPlayer, "Вы не можете взять джетпак,\nнаходясь в транспорте", 2, true)
			return
		end

		triggerServerEvent('PlayerFunctions.setPlayerJetpack', localPlayer, guiCheckBoxGetSelected(Dashboard.plWindow['btn_jetpack']))
	
	elseif source == Dashboard.plWindow['btn_nobike'] then -- падение с мотоцикла
		PlayerFunctions.setPlayerCanBeKnockedOffBike(not guiCheckBoxGetSelected(Dashboard.plWindow['btn_nobike']))

	elseif source == Dashboard.plWindow['btn_noheadmoving'] then -- вращение головы
		localPlayer:setData('player.isShowingHeadMoving', guiCheckBoxGetSelected(Dashboard.plWindow['btn_noheadmoving']))

	elseif source == Dashboard.plWindow['btn_nomoneycash'] then -- дипломат
		localPlayer:setData('player.isPlayerAttachedCase', guiCheckBoxGetSelected(Dashboard.plWindow['btn_nomoneycash']))

	elseif source == Dashboard.plWindow['btn_notp'] then -- анти телепорт
		localPlayer:setData('player.isPlayerTeleport', guiCheckBoxGetSelected(Dashboard.plWindow['btn_notp']))

	elseif source == Dashboard.plWindow['btn_dead'] then -- умереть
 		triggerServerEvent('PlayerFunctions.killPlayer', localPlayer)
 		Dashboard.setVisible()

 	elseif source == Dashboard.plWindow['btn_fightstyle'] then -- навыки боя
 		guiSetEnabled(Dashboard.wnd, false)
 		Dashboard.activeWindow = Dashboard.showFightStyleWindow()

 	elseif source == Dashboard.plWindow['btn_walkstyle'] then -- стили походки
 		guiSetEnabled(Dashboard.wnd, false)
 		Dashboard.activeWindow = Dashboard.showWalkingStyleWindow()

 	elseif source == Dashboard.plWindow['btn_skin'] then -- изменить скин
 		guiSetVisible(Dashboard.wnd, false)
 		guiSetVisible(Dashboard.skinWindow['wnd'], true)

 		Dashboard.activeWindow = Dashboard.skinWindow['wnd']

 	elseif source == Dashboard.plWindow['btn_anim'] then -- анимации
 		guiSetVisible(Dashboard.wnd, false)
 		guiSetVisible(Dashboard.animWindow['wnd'], true)

 		Dashboard.activeWindow = Dashboard.animWindow['wnd']

 	elseif source == Dashboard.plWindow['btn_weap'] then -- предметы
 		guiSetEnabled(Dashboard.wnd, false)
 		Dashboard.activeWindow = Dashboard.showWeaponWindow()
 	elseif source == Dashboard.plWindow['btn_vehicle'] then	-- создание транспорта
 		guiSetVisible(Dashboard.wnd, false)
 		Dashboard.vehWindow.setVisible(true)

 		Dashboard.activeWindow = Dashboard.vehWindow['wnd']

 	elseif source == Dashboard.plWindow['btn_tp'] then -- телепортироваться к игроку
 		guiSetEnabled(Dashboard.wnd, false)

 		Dashboard.activeWindow = Dashboard.showWarpToPlayerWindow()

 	elseif source == Dashboard.plWindow['btn_map'] then -- карта
 		Dashboard.mapWindow.setVisible(true)

 	elseif source == Dashboard.plWindow['btn_photo'] then -- кам хак
 		if not localPlayer:getData('operCamHack:isVisible') then
 			Dashboard.setVisible(false)
 			exports.operCamHack.startCamHack()
 		else
 			exports.operCamHack.stopCamHack()
 		end

	elseif source == Dashboard.plWindow['btn_sound'] then -- звуковые фрагменты

		local isVisible = exports.operPlayerVoice:isWndVisible()
		
		if not isVisible then 
			Dashboard.setVisible(false)
		end

		exports.operPlayerVoice:setWndVisible(not isVisible)
		--triggerEvent("", localPlayer)
		--Dashboard.activeWindow = Dashboard.showWalkingStyleWindow()
	end


end)

-- СОЗДАНИЕ ТРАНСПОРТА --
addEventHandler("onClientGUIClick", root, function()
	if not guiGetVisible(Dashboard.vehWindow['wnd']) then
		return
	end

	if source == Dashboard.vehWindow['btn_close'] or source == Dashboard.vehWindow['btn_remove'] then 
		if source == Dashboard.vehWindow['btn_remove'] then 
			triggerServerEvent('operVehicleSystem.removeVehicle', root, localPlayer)
			showCursor(false)
		elseif source == Dashboard.vehWindow['btn_close'] then
			guiSetVisible(Dashboard.wnd, true)
			Dashboard.activeWindow = nil
		end

		Dashboard.vehWindow.setVisible(false)
	end
end)
-------------------------

-- СМЕНА СКИНА 
addEventHandler("onClientGUIClick", root, function()
	if not isElement(Dashboard.skinWindow['wnd']) then
		return
	end

	if source == Dashboard.skinWindow['btn_close'] then
		guiSetVisible(Dashboard.skinWindow['wnd'], false)
		guiSetVisible(Dashboard.wnd, true)

		Dashboard.activeWindow = nil
	end
end)

-- ВЫБОР НАВЫКА БОЯ
addEventHandler("onClientGUIDoubleClick", root, function()
	if not isElement(Dashboard.fsWindow['wnd']) then
		return
	end

	local sel = guiGridListGetSelectedItem(Dashboard.fsWindow['gridlist'])
    local fightStyle = guiGridListGetItemData(Dashboard.fsWindow['gridlist'], sel, 1) or ""

    if fightStyle ~= "" then
    	triggerServerEvent('PlayerFunctions.setPlayerFightStyle', localPlayer, fightStyle)
    end

end)

addEventHandler("onClientGUIClick", root, function()
	if not isElement(Dashboard.fsWindow['wnd']) then
		return
	end

	if source == Dashboard.fsWindow['btn_close'] then
		destroyElement(Dashboard.fsWindow['wnd'])
		guiSetEnabled(Dashboard.wnd, true)
	end
end)

-- ВЫБОР СТИЛЯ ПОХОДКИ
addEventHandler("onClientGUIDoubleClick", root, function()
	if not isElement(Dashboard.wsWindow['wnd']) then
		return
	end

	local sel = guiGridListGetSelectedItem(Dashboard.wsWindow['gridlist'])
    local walkStyle = guiGridListGetItemData(Dashboard.wsWindow['gridlist'], sel, 1) or ""

    if walkStyle ~= "" then
    	triggerServerEvent('PlayerFunctions.setPlayerWalkingStyle', localPlayer, walkStyle)
    end

end)

addEventHandler("onClientGUIClick", root, function()
	if not isElement(Dashboard.wsWindow['wnd']) then
		return
	end

	if source == Dashboard.wsWindow['btn_close'] then
		destroyElement(Dashboard.wsWindow['wnd'])
		guiSetEnabled(Dashboard.wnd, true)
	end
end)

-- ВЫБОР ПРЕДМЕТА
addEventHandler("onClientGUIDoubleClick", root, function()
	if not isElement(Dashboard.weapWindow['wnd']) then
		return
	end

	local sel = guiGridListGetSelectedItem(Dashboard.weapWindow['gridlist'])
    local weap = guiGridListGetItemData(Dashboard.weapWindow['gridlist'], sel, 1) or ""

    if weap ~= "" then
    	triggerServerEvent('PlayerFunctions.givePlayerWeapon', localPlayer, weap)
    end

end)

addEventHandler("onClientGUIClick", root, function()
	if not isElement(Dashboard.weapWindow['wnd']) then
		return
	end

	if source == Dashboard.weapWindow['btn_close'] then
		destroyElement(Dashboard.weapWindow['wnd'])
		guiSetEnabled(Dashboard.wnd, true)
	end
end)

-------------------

function getDashoboardVisible()
	if isElement(Dashboard.activeWindow) and not guiGetVisible(Dashboard.activeWindow) then
		return false
	end

	return Dashboard.isVisible
end