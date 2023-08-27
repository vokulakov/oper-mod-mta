Dashboard.plWindow = {}

local posX, posY = 10, 30

-- ФУНКЦИИ --

--
Dashboard.plWindow['btn_vehicle'] = guiCreateButton(posX, posY, 205, 30, "Создать транспорт", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_vehicle'], "default-bold-small")
guiSetProperty(Dashboard.plWindow['btn_vehicle'], "NormalTextColour", "FF21b1ff")

Dashboard.plWindow['btn_vehicle']:setData('operSounds.UI', 'ui_select')
-- 
Dashboard.plWindow['btn_skin'] = guiCreateButton(posX, posY+35, 100, 25, "Сменить скин", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_skin'], "default-bold-small")

Dashboard.plWindow['btn_skin']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_weap'] = guiCreateButton(posX+105, posY+35, 100, 25, "Взять предмет", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_weap'], "default-bold-small")

Dashboard.plWindow['btn_weap']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_fightstyle'] = guiCreateButton(posX, posY+65, 75, 25, "Навык боя", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_fightstyle'], "default-bold-small")

Dashboard.plWindow['btn_fightstyle']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_walkstyle'] = guiCreateButton(posX+80, posY+65, 125, 25, "Стиль походки", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_walkstyle'], "default-bold-small")

Dashboard.plWindow['btn_walkstyle']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_tp'] = guiCreateButton(posX, posY+95, 205, 25, "Телепортироваться к игроку", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_tp'], "default-bold-small")
--guiSetEnabled(Dashboard.plWindow['btn_tp'], false)
Dashboard.plWindow['btn_tp']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_map'] = guiCreateButton(posX, posY+125, 60, 25, "Карта", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_map'], "default-bold-small")
--guiSetEnabled(Dashboard.plWindow['btn_map'], false)
Dashboard.plWindow['btn_map']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_location'] = guiCreateButton(posX+65, posY+125, 140, 25, "Значимые места", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_location'], "default-bold-small")
guiSetEnabled(Dashboard.plWindow['btn_location'], false)
Dashboard.plWindow['btn_location']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_anim'] = guiCreateButton(posX, posY+155, 110, 25, "Анимации", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_anim'], "default-bold-small")
--guiSetEnabled(Dashboard.plWindow['btn_anim'], false)
Dashboard.plWindow['btn_anim']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_photo'] = guiCreateButton(posX+115, posY+155, 90, 25, "Фото режим", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_photo'], "default-bold-small")
guiSetProperty(Dashboard.plWindow['btn_photo'], "NormalTextColour", "FF21b1ff")
--guiSetEnabled(Dashboard.plWindow['btn_photo'], false)
Dashboard.plWindow['btn_photo']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_sound'] = guiCreateButton(posX, posY+185, 205, 25, "Звуковые фрагменты", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_sound'], "default-bold-small")
Dashboard.plWindow['btn_sound']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_dead'] = guiCreateButton(posX, posY+405, 205, 25, "Респавн", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_dead'], "default-bold-small")
guiSetProperty(Dashboard.plWindow['btn_dead'], "NormalTextColour", "fff01a21")
Dashboard.plWindow['btn_dead']:setData('operSounds.UI', 'ui_select')
--
Dashboard.plWindow['btn_help'] = guiCreateButton(posX, posY+435, 205, 25, "Нужна помощь?", false, Dashboard.wnd)
guiSetFont(Dashboard.plWindow['btn_help'], "default-bold-small")
guiSetProperty(Dashboard.plWindow['btn_help'], "NormalTextColour", "FFFF7800")
Dashboard.plWindow['btn_help']:setData('operSounds.UI', 'ui_select')
--guiSetEnabled(Dashboard.plWindow['btn_help'], false)
-- ОПЦИИ --

--
Dashboard.plWindow['btn_jetpack'] = guiCreateCheckBox(posX, posY+265, 100, 20, " Джетпак", false, false, Dashboard.wnd)
Dashboard.plWindow['btn_jetpack']:setData('operSounds.UI', 'ui_change')
--
Dashboard.plWindow['btn_nobike'] = guiCreateCheckBox(posX, posY+285, 175, 20, " Не падать с двухколесных", false, false, Dashboard.wnd)
Dashboard.plWindow['btn_nobike']:setData('operSounds.UI', 'ui_change')
--
Dashboard.plWindow['btn_notp'] = guiCreateCheckBox(posX, posY+305, 120, 20, " Анти-телепорт", false, false, Dashboard.wnd)
--guiSetEnabled(Dashboard.plWindow['btn_notp'], false)
Dashboard.plWindow['btn_notp']:setData('operSounds.UI', 'ui_change')
--
Dashboard.plWindow['btn_nohp'] = guiCreateCheckBox(posX, posY+325, 120, 20, " Бессмертие", false, false, Dashboard.wnd)
--guiSetEnabled(Dashboard.plWindow['btn_nohp'], false)
Dashboard.plWindow['btn_nohp']:setData('operSounds.UI', 'ui_change')
--
Dashboard.plWindow['btn_noheadmoving'] = guiCreateCheckBox(posX, posY+345, 155, 20, " Вращение головы", true, false, Dashboard.wnd)
Dashboard.plWindow['btn_noheadmoving']:setData('operSounds.UI', 'ui_change')
--
Dashboard.plWindow['btn_nomoneycash'] = guiCreateCheckBox(posX, posY+365, 120, 20, " Дипломат", false, false, Dashboard.wnd)
Dashboard.plWindow['btn_nomoneycash']:setData('operSounds.UI', 'ui_change')


-- СТИЛЬ БОЯ --
Dashboard.fsWindow = {}

function Dashboard.showFightStyleWindow()

	Dashboard.fsWindow['wnd'] = guiCreateWindow(sWidth/2-225/2, sHeight/2-200/2, 225, 200, "Выбери навык боя", false)
	guiWindowSetSizable(Dashboard.fsWindow['wnd'], false)
	guiWindowSetMovable(Dashboard.fsWindow['wnd'], false)
	
	Dashboard.fsWindow['gridlist'] = guiCreateGridList(0, 30, 225, 120, false, Dashboard.fsWindow['wnd'])
	guiGridListSetSortingEnabled(Dashboard.fsWindow['gridlist'], false)
	local column = guiGridListAddColumn(Dashboard.fsWindow['gridlist'], "Навыки боя", 0.8)

	Dashboard.fightStyleWindowUpdate()
	Dashboard.fsWindow['btn_close'] = guiCreateButton(0, 160, 220, 25, "Закрыть", false, Dashboard.fsWindow['wnd'])
	guiSetFont(Dashboard.fsWindow['btn_close'], "default-bold-small")
	
	Dashboard.fsWindow['btn_close']:setData('operSounds.UI', 'ui_back')

	return Dashboard.fsWindow['wnd']
end

function Dashboard.fightStyleWindowUpdate()
	guiGridListClear(Dashboard.fsWindow['gridlist'])

	local currentStyle = getPedFightingStyle(localPlayer)
	for id, style in pairs(fightStyle.Config) do
		local row = guiGridListAddRow(Dashboard.fsWindow['gridlist'])

		guiGridListSetItemText(Dashboard.fsWindow['gridlist'], row, 1, style, false, false)
		guiGridListSetItemData(Dashboard.fsWindow['gridlist'], row, 1, id)

		if tonumber(currentStyle) == tonumber(id) then
			guiGridListSetItemColor(Dashboard.fsWindow['gridlist'], row, 1, 33, 177, 255)
		end
	end
end
addEvent('Dashboard.fightStyleWindowUpdate', true)
addEventHandler('Dashboard.fightStyleWindowUpdate', root, Dashboard.fightStyleWindowUpdate)

-- СТИЛЬ ПОХОДКИ --
Dashboard.wsWindow = {}

function Dashboard.showWalkingStyleWindow()
	Dashboard.wsWindow['wnd'] = guiCreateWindow(sWidth/2-225/2, sHeight/2-300/2, 225, 300, "Выбери стиль походки", false)
	guiWindowSetSizable(Dashboard.wsWindow['wnd'], false)
	guiWindowSetMovable(Dashboard.wsWindow['wnd'], false)

	Dashboard.wsWindow['gridlist'] = guiCreateGridList(0, 30, 225, 220, false, Dashboard.wsWindow['wnd'])
	guiGridListSetSortingEnabled(Dashboard.wsWindow['gridlist'], false)
	local column = guiGridListAddColumn(Dashboard.wsWindow['gridlist'], "Стили походки", 0.8)

	Dashboard.walkingStyleWindowUpdate()
	Dashboard.wsWindow['btn_close'] = guiCreateButton(0, 260, 220, 25, "Закрыть", false, Dashboard.wsWindow['wnd'])
	guiSetFont(Dashboard.wsWindow['btn_close'], "default-bold-small")

	Dashboard.wsWindow['btn_close']:setData('operSounds.UI', 'ui_back')

	return Dashboard.wsWindow['wnd']
end

function Dashboard.walkingStyleWindowUpdate()
	guiGridListClear(Dashboard.wsWindow['gridlist'])

	local currentStyle = getPedWalkingStyle(localPlayer)
	for id, style in pairs(walkingStyle.Config) do
		local row = guiGridListAddRow(Dashboard.wsWindow['gridlist'])

		guiGridListSetItemText(Dashboard.wsWindow['gridlist'], row, 1, style, false, false)
		guiGridListSetItemData(Dashboard.wsWindow['gridlist'], row, 1, id)

		if tonumber(currentStyle) == tonumber(id) then
			guiGridListSetItemColor(Dashboard.wsWindow['gridlist'], row, 1, 33, 177, 255)
		end
	end
end
addEvent('Dashboard.walkingStyleWindowUpdate', true)
addEventHandler('Dashboard.walkingStyleWindowUpdate', root, Dashboard.walkingStyleWindowUpdate)

-- ВЗЯТЬ ПРЕДМЕТ
Dashboard.weapWindow = {}

function Dashboard.showWeaponWindow()
	Dashboard.weapWindow['wnd'] = guiCreateWindow(sWidth/2-225/2, sHeight/2-300/2, 225, 300, "Выбери предмет", false)
	guiWindowSetSizable(Dashboard.weapWindow['wnd'], false)
	guiWindowSetMovable(Dashboard.weapWindow['wnd'], false)

	Dashboard.weapWindow['gridlist'] = guiCreateGridList(0, 30, 225, 220, false, Dashboard.weapWindow['wnd'])
	guiGridListSetSortingEnabled(Dashboard.weapWindow['gridlist'], false)
	local column = guiGridListAddColumn(Dashboard.weapWindow['gridlist'], "Предметы", 0.8)

	for _, weap in ipairs(weapon.Config) do
		local row = guiGridListAddRow(Dashboard.weapWindow['gridlist'])

		guiGridListSetItemText(Dashboard.weapWindow['gridlist'], row, 1, weap.name, false, false)
		guiGridListSetItemData(Dashboard.weapWindow['gridlist'], row, 1, weap.id)
	end

	Dashboard.weapWindow['btn_close'] = guiCreateButton(0, 260, 220, 25, "Закрыть", false, Dashboard.weapWindow['wnd'])
	guiSetFont(Dashboard.weapWindow['btn_close'], "default-bold-small")

	Dashboard.weapWindow['btn_close']:setData('operSounds.UI', 'ui_back')

	return Dashboard.weapWindow['wnd']
end

-- СМЕНИТЬ СКИН 
Dashboard.skinWindow = {}

Dashboard.skinWindow['wnd'] = guiCreateWindow(15, 15, 230, sHeight - 230, "Выбери скин", false)
guiWindowSetSizable(Dashboard.skinWindow['wnd'], false)
guiSetVisible(Dashboard.skinWindow['wnd'], false)
guiWindowSetMovable(Dashboard.skinWindow['wnd'], false)

Dashboard.skinWindow['skinlist'] = guiCreateGridList(0, 30, 230, sHeight - 230 - 75, false, Dashboard.skinWindow['wnd'])
guiGridListSetSortingEnabled(Dashboard.skinWindow['skinlist'], false)
local column = guiGridListAddColumn(Dashboard.skinWindow['skinlist'], "Категории скинов", 0.8)

Dashboard.skinWindow['btn_close'] = guiCreateButton(0, sHeight - 230 - 35, 225, 25, "Закрыть", false, Dashboard.skinWindow['wnd'])
guiSetFont(Dashboard.skinWindow['btn_close'], "default-bold-small")

Dashboard.skinWindow['btn_close']:setData('operSounds.UI', 'ui_back')

function Dashboard.skinWindow.initList()
	guiGridListClear(Dashboard.skinWindow['skinlist'])
	guiGridListSetColumnTitle(Dashboard.skinWindow['skinlist'] , 1, 'Категории скинов')

	for category, category_list in pairs(Skin.Config) do
		local row = guiGridListAddRow(Dashboard.skinWindow['skinlist'])

		guiGridListSetItemText(Dashboard.skinWindow['skinlist'], row, 1, '+ '..category, false, false)
		guiGridListSetItemData(Dashboard.skinWindow['skinlist'], row, 1, category_list)
	end
end

Dashboard.skinWindow.initList()

addEventHandler("onClientGUIDoubleClick", Dashboard.skinWindow['skinlist'], function() 
	if not guiGetVisible(Dashboard.skinWindow['wnd']) then
		return
	end

	-- ОТКРЫТИЕ КАТЕГОРИИ --
	local sel = guiGridListGetSelectedItem(Dashboard.skinWindow['skinlist'])
    local item = guiGridListGetItemData(Dashboard.skinWindow['skinlist'], sel, 1) or ""

    if item ~= "" and type(item) == 'number' then
    	triggerServerEvent('PlayerFunctions.setPlayerSkin', localPlayer, tonumber(item))
    	return
    end

    if item ~= "" and item ~= 'back' then
    	guiGridListClear(Dashboard.skinWindow['skinlist'])

    	guiGridListSetColumnTitle(Dashboard.skinWindow['skinlist'] , 1, 'Список скинов')

    	local row = guiGridListAddRow(Dashboard.skinWindow['skinlist'])
    	guiGridListSetItemText(Dashboard.skinWindow['skinlist'], row, 1, '..', false, false)
   		guiGridListSetItemData(Dashboard.skinWindow['skinlist'], row, 1, 'back')

   		for tittle, brandList in pairs(item) do -- подкатегория
   			local row = guiGridListAddRow(Dashboard.skinWindow['skinlist'])
    		guiGridListSetItemText(Dashboard.skinWindow['skinlist'], row, 1, tittle, true, false)
    		guiGridListSetItemColor(Dashboard.skinWindow['skinlist'], row, 1, 33, 177, 255)

    		for _, skin in ipairs(brandList) do -- скины
    			local row = guiGridListAddRow(Dashboard.skinWindow['skinlist'])
    			guiGridListSetItemText(Dashboard.skinWindow['skinlist'], row, 1, ' '..skin.name, false, false)
    			guiGridListSetItemData(Dashboard.skinWindow['skinlist'], row, 1, skin.id)
    		end

   		end

    end
    ------------------------

    -- ВЫХОД ИЗ КАТЕГОРИИ --
    if item ~= '' and item == "back" then
	 	Dashboard.skinWindow.initList()
    end
    ------------------------
end)

-- ТЕЛЕПОРТИРОВАТЬСЯ К ИГРОКУ
Dashboard.warpToPlayer = {}

function Dashboard.showWarpToPlayerWindow()
	Dashboard.warpToPlayer['wnd'] = guiCreateWindow(sWidth/2-300/2, sHeight/2-400/2, 300, 400, "Выбери игрока (двойной клик)", false)
	guiWindowSetSizable(Dashboard.warpToPlayer['wnd'], false)
	guiWindowSetMovable(Dashboard.warpToPlayer['wnd'], false)

	Dashboard.warpToPlayer['search'] = guiCreateEdit(0, 30, 280, 25, "", false, Dashboard.warpToPlayer['wnd'])
	Dashboard.warpToPlayer['playerList'] = guiCreateGridList(0, 60, 280, 300, false, Dashboard.warpToPlayer['wnd'])
	guiGridListSetSortingEnabled(Dashboard.warpToPlayer['playerList'], false)
	local column = guiGridListAddColumn(Dashboard.warpToPlayer['playerList'], "Список игроков", 0.8)

	Dashboard.warpToPlayer.updatePlayerList()

	Dashboard.warpToPlayer['btn_refresh'] = guiCreateButton(0, 365, 155, 25, "Обновить список", false, Dashboard.warpToPlayer['wnd'])
	guiSetFont(Dashboard.warpToPlayer['btn_refresh'], "default-bold-small")
	guiSetProperty(Dashboard.warpToPlayer['btn_refresh'], "NormalTextColour", "FF21b1ff")
	Dashboard.warpToPlayer['btn_refresh']:setData('operSounds.UI', 'ui_select')

	Dashboard.warpToPlayer['btn_close'] = guiCreateButton(170, 365, 120, 25, "Закрыть", false, Dashboard.warpToPlayer['wnd'])
	guiSetFont(Dashboard.warpToPlayer['btn_close'], "default-bold-small")

	Dashboard.warpToPlayer['btn_close']:setData('operSounds.UI', 'ui_back')

	return Dashboard.warpToPlayer['wnd']
end


function tableMap(t, callback)
	for k,v in ipairs(t) do
		t[k] = callback(v)
	end
	return t
end

function Dashboard.warpToPlayer.updatePlayerList()
	guiGridListClear(Dashboard.warpToPlayer['playerList'])

	local function getPlayersByPartName(text)
		if not text or text == '' then
			return getElementsByType("player")
		else
			local players = {}
			for _, player in ipairs(getElementsByType("player")) do
				if string.find(getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):upper(), text:upper(), 1, true) then
					table.insert(players, player)
				end
			end
			return players
		end
	end

	local text = guiGetText(Dashboard.warpToPlayer['search'])
	local players = tableMap(getPlayersByPartName(text), function(p) return { player = p, name = getPlayerName(p) } end)
	table.sort(players, function(a, b) return a.name < b.name end)

	for i, player in ipairs(getElementsByType("player")) do
        local row = guiGridListAddRow(Dashboard.warpToPlayer['playerList'])
        guiGridListSetItemText(Dashboard.warpToPlayer['playerList'], row, 1, getPlayerName(player):gsub("#%x%x%x%x%x%x", ""), false, false)
       	guiGridListSetItemData(Dashboard.warpToPlayer['playerList'], row, 1, getPlayerName(player))
    end

end

addEventHandler("onClientGUIChanged", root, function(element) 
	if not isElement(Dashboard.warpToPlayer['wnd']) then
		return
	end

   if source == Dashboard.warpToPlayer['search'] then
   		Dashboard.warpToPlayer.updatePlayerList()
   end
end)

addEventHandler("onClientGUIClick", root, function()
	if not isElement(Dashboard.warpToPlayer['wnd']) then
		return
	end

	if source == Dashboard.warpToPlayer['btn_close'] then
		destroyElement(Dashboard.warpToPlayer['wnd'])
		guiSetEnabled(Dashboard.wnd, true)
	elseif source == Dashboard.warpToPlayer['btn_refresh'] then
		Dashboard.warpToPlayer.updatePlayerList()
	end
end)

addEventHandler("onClientGUIDoubleClick", root, function() 
	if not isElement(Dashboard.warpToPlayer['wnd']) then
		return
	end

	local sel = guiGridListGetSelectedItem(Dashboard.warpToPlayer['playerList'])
	local name = guiGridListGetItemData(Dashboard.warpToPlayer['playerList'], sel, 1) or false

	if not name then 
		return
	end

	local targetPlayer = getPlayerFromName(name) 

	if not isElement(targetPlayer) then
		triggerEvent('operNotification.addNotification', localPlayer, "Игрок не найден!", 2, true)
		return
	end

	warpMe(targetPlayer)

	destroyElement(Dashboard.warpToPlayer['wnd'])
	Dashboard.setVisible(false)
	--function warpMe(targetPlayer)
end)

-- АНИМАЦИИ --
--Dashboard.plWindow['btn_anim']

Dashboard.animWindow = {}

Dashboard.animWindow['wnd'] = guiCreateWindow(15, 15, 230, sHeight - 230, "Анимации", false)
guiWindowSetSizable(Dashboard.animWindow['wnd'], false)
guiSetVisible(Dashboard.animWindow['wnd'], false)
guiWindowSetMovable(Dashboard.animWindow['wnd'], false)

Dashboard.animWindow['list1'] = guiCreateGridList(0, 30, 230, 120, false, Dashboard.animWindow['wnd'])
guiGridListSetSortingEnabled(Dashboard.animWindow['list1'], false)
local column = guiGridListAddColumn(Dashboard.animWindow['list1'], "Категории анимаций", 0.8)

for i, v in ipairs(Animation.catsTable) do
    local row = guiGridListAddRow(Dashboard.animWindow['list1'])
    guiGridListSetItemText(Dashboard.animWindow['list1'], row, 1, v, false, false)
end

Dashboard.animWindow['list2'] = guiCreateGridList(0, 155, 230, sHeight - 455, false, Dashboard.animWindow['wnd'])
guiGridListSetSortingEnabled(Dashboard.animWindow['list2'], false)
local column = guiGridListAddColumn(Dashboard.animWindow['list2'], "Анимации", 0.8)


Dashboard.animWindow['btn_stop'] = guiCreateButton(0, sHeight - 230 - 65, 225, 25, "Остановить анимацию", false, Dashboard.animWindow['wnd'])
guiSetFont(Dashboard.animWindow['btn_stop'], "default-bold-small")
--guiSetProperty(Dashboard.animWindow['btn_stop'], "NormalTextColour", "FF21b1ff")
guiSetProperty(Dashboard.animWindow['btn_stop'], "NormalTextColour", "fff01a21")
Dashboard.animWindow['btn_stop']:setData('operSounds.UI', 'ui_select')

Dashboard.animWindow['btn_close'] = guiCreateButton(0, sHeight - 230 - 35, 225, 25, "Закрыть", false, Dashboard.animWindow['wnd'])
guiSetFont(Dashboard.animWindow['btn_close'], "default-bold-small")

Dashboard.animWindow['btn_close']:setData('operSounds.UI', 'ui_back')

function Dashboard.animWindow.initAnim(cat)
	for i, v in ipairs(Animation.animsTable) do
        if v[3] == cat then
            --if isPedInVehicle(localPlayer) then 
            	--return 
            --end

            local row = guiGridListAddRow(Dashboard.animWindow['list2'])
   			guiGridListSetItemText(Dashboard.animWindow['list2'], row, 1, v[4], false, false)
    		guiGridListSetItemData(Dashboard.animWindow['list2'], row, 1, {v[1], v[2]})
        end
    end
end

local function stopAnimation()
	if not getPedAnimation(localPlayer) then
		return
	end
	
	triggerServerEvent("PlayerFunctions.onSetAnim", localPlayer, false)
    unbindKey("jump", "down", stopAnimation)
end

addEventHandler("onClientGUIClick", root, function()
	if not Dashboard.animWindow['wnd'].visible then
		return
	end

    if (source == Dashboard.animWindow['list1']) then
    	local sel = guiGridListGetSelectedItem(source)
        if (sel ~= -1) then
            guiGridListClear(Dashboard.animWindow['list2'])

            local groupname = guiGridListGetItemText(source, sel, 1)
            Dashboard.animWindow.initAnim(groupname)
        end
    elseif (source == Dashboard.animWindow['btn_stop']) then
       stopAnimation()
    elseif source == Dashboard.animWindow['btn_close'] then
		guiSetVisible(Dashboard.animWindow['wnd'], false)
		guiSetVisible(Dashboard.wnd, true)

		Dashboard.activeWindow = nil
    end
end)

addEventHandler("onClientGUIDoubleClick", root, function()
    if (source == Dashboard.animWindow['list2']) then
    	local sel = guiGridListGetSelectedItem(Dashboard.animWindow['list2'])
        if (sel ~= -1 ) then
            local anim = guiGridListGetItemData(Dashboard.animWindow['list2'], sel, 1 )

            if isPedInVehicle(localPlayer) then
        		triggerEvent('operNotification.addNotification', localPlayer, "Вы не можете включить анимацию,\nнаходясь в транспорте", 2, true)
        		return 
    		end
    		triggerServerEvent("PlayerFunctions.onSetAnim", localPlayer, true, anim[1], anim[2])
    		triggerEvent('operNotification.addNotification', localPlayer, "Чтобы остановить анимацию\nвыполните 'прыжок'", 1, true)

    		bindKey("jump", "down", stopAnimation)
        end
    end
end)

