Dashboard.accountWindow = {}

Dashboard.accountWindow.wnd = guiCreateWindow(sWidth/2-600/2, sHeight/2-500/2, 600, 500, "Меню игрока", false)
guiWindowSetSizable(Dashboard.accountWindow.wnd , false) 
guiWindowSetMovable(Dashboard.accountWindow.wnd , true) 

Dashboard.accountWindow.tabPanel = guiCreateTabPanel(0, 0.05, 1, 1, true, Dashboard.accountWindow.wnd) 

Dashboard.accountWindow.wnd.visible = false

--Dashboard.accountWindow.tabShop = guiCreateTab("Магазин", Dashboard.accountWindow.tabPanel)

--[[
Dashboard.accountWindow.tabAccount = guiCreateTab("Аккаунт", Dashboard.accountWindow.tabPanel)

-- ИНФОРМАЦИЯ --
Dashboard.accountWindow.lbl = guiCreateLabel(0, 0.05, 1, 0.1, "ИНФОРМАЦИЯ ОБ АККАУНТЕ", true, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl, 255, 255, 255)
guiLabelSetHorizontalAlign(Dashboard.accountWindow.lbl, 'center')

Dashboard.accountWindow.lbl_player_nickname = guiCreateLabel(15, 50, 120, 15, "Никнейм: ", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl_player_nickname, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl_player_nickname, 33, 177, 255)

Dashboard.accountWindow.info_player_nickname = guiCreateLabel(guiLabelGetTextExtent(Dashboard.accountWindow.lbl_player_nickname)+20, 50, 300, 15, "-", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.info_player_nickname, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.info_player_nickname, 255, 255, 255)
--
Dashboard.accountWindow.lbl_player_playtime = guiCreateLabel(15, 70, 120, 15, "Наиграно: ", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl_player_playtime, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl_player_playtime, 33, 177, 255)

Dashboard.accountWindow.info_player_playtime = guiCreateLabel(guiLabelGetTextExtent(Dashboard.accountWindow.lbl_player_playtime)+20, 70, 565, 15, "-", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.info_player_playtime, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.info_player_playtime, 255, 255, 255)
--
Dashboard.accountWindow.lbl_acc_username = guiCreateLabel(15, 100, 120, 15, "Имя аккаунта: ", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl_acc_username, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl_acc_username, 33, 177, 255)

Dashboard.accountWindow.info_acc_username = guiCreateLabel(guiLabelGetTextExtent(Dashboard.accountWindow.lbl_acc_username)+20, 100, 300, 15, "-", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.info_acc_username, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.info_acc_username, 255, 255, 255)
--
Dashboard.accountWindow.lbl_acc_id = guiCreateLabel(15, 120, 170, 15, "Идентификатор аккаунта: ", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl_acc_id, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl_acc_id, 33, 177, 255)

Dashboard.accountWindow.info_acc_id = guiCreateLabel(guiLabelGetTextExtent(Dashboard.accountWindow.lbl_acc_id)+20, 120, 300, 15, "-", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.info_acc_id, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.info_acc_id, 255, 255, 255)
--
Dashboard.accountWindow.lbl_acc_reg = guiCreateLabel(15, 140, 170, 15, "Дата регистрации: ", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl_acc_reg, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl_acc_reg, 33, 177, 255)

Dashboard.accountWindow.info_acc_reg = guiCreateLabel(guiLabelGetTextExtent(Dashboard.accountWindow.lbl_acc_reg)+20, 140, 300, 15, "-", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.info_acc_reg, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.info_acc_reg, 255, 255, 255)
--
Dashboard.accountWindow.lbl_player_serial = guiCreateLabel(15, 405, 170, 15, "Серийный номер: ", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.lbl_player_serial, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.lbl_player_serial, 33, 177, 255)

Dashboard.accountWindow.info_player_serial = guiCreateLabel(guiLabelGetTextExtent(Dashboard.accountWindow.lbl_player_serial)+20, 405, 300, 15, getPlayerSerial(localPlayer), false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.info_player_serial, "default-bold-small")
guiLabelSetColor(Dashboard.accountWindow.info_player_serial, 255, 255, 255)

Dashboard.accountWindow.btn_serialCopy = guiCreateButton(370, 400, 200, 25, "Скопировать серийный номер", false, Dashboard.accountWindow.tabAccount)
guiSetFont(Dashboard.accountWindow.btn_serialCopy, "default-bold-small")

Dashboard.accountWindow.wnd.visible = false

function Dashboard.accountWindow.updateInfo() -- обновление информации
	local accountData = localPlayer:getData('player.accountData') 
	local playtime = localPlayer:getData('player.playtime') 

	if not accountData then
		return
	end

	if playtime then
		guiSetText(Dashboard.accountWindow.info_player_playtime, math.floor(playtime/60)..' часов')
	else
		guiSetText(Dashboard.accountWindow.info_player_playtime, '-')
	end

	guiSetText(Dashboard.accountWindow.info_acc_username, accountData.username)
	guiSetText(Dashboard.accountWindow.info_acc_id, accountData.user_id)
	guiSetText(Dashboard.accountWindow.info_player_nickname, localPlayer.name)
	guiSetText(Dashboard.accountWindow.info_acc_reg, accountData.register_time)
end
]]
function Dashboard.accountWindow.setVisible(isVisible)

	showCursor(isVisible)

	if not getElementData(localPlayer, 'operCamHack:isVisible') then
		triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, not isVisible)
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'dashboard', true) -- ну отключать dashboard
		showChat(not isVisible)
		triggerEvent('operShowUI.drawBlurShader', localPlayer, isVisible)
	end
--[[
	if isVisible then
		Dashboard.accountWindow.updateInfo()
	end
]]
	Dashboard.accountWindow.wnd.visible = isVisible
end
--[[
bindKey('f4', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")

    if type(PLAYER_UI) == 'boolean' then return end

	if not PLAYER_UI['dashboard'] then 
		return
	end


	Dashboard.activeWindowShow(Dashboard.accountWindow.wnd)
	Dashboard.accountWindow.setVisible(not Dashboard.accountWindow.wnd.visible)
end)
]]