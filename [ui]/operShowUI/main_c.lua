local UI = {
	['radar'] = true, -- радар
	['hud'] = true, -- статистика игрока
	['speed'] = true, -- спидометр
	['drift_point'] = true, -- дрифт очки

	['scoreboard'] = true, -- список игроков

	['dashboard'] = true, -- панель игрока
	['chat'] = true, -- чат

	['notify'] = true, -- уведомления
	['control'] = true, -- управление
	
	['nicknames'] = true -- ники игроков
}

local function setVisiblePlayerUI(state)

	for component in pairs(UI) do 
		UI[component] = state 
	end

	setElementData(source, 'player.UI', UI)
end
addEvent("operShowUI.setVisiblePlayerUI", true)
addEventHandler("operShowUI.setVisiblePlayerUI", root, setVisiblePlayerUI)


local function setVisiblePlayerComponentUI(theComponent, state)
	for component in pairs(UI) do 
		if component == theComponent then
			UI[component] = state 
		end
		setElementData(source, 'player.UI', UI)
	end
end
addEvent("operShowUI.setVisiblePlayerComponentUI", true)
addEventHandler("operShowUI.setVisiblePlayerComponentUI", root, setVisiblePlayerComponentUI)

addEventHandler("onClientResourceStart", resourceRoot, function()
	setVisiblePlayerUI(false) -- --

	setElementData(localPlayer, "player.ACTIVE_UI", false)
end)


setTimer(function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['chat'] and isChatVisible() then
		showChat(false)
	elseif PLAYER_UI['chat'] and not isChatVisible() then
		showChat(true)
	end

end, 50, 0, false)