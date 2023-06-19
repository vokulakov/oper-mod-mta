Help = {}
Help.Window = {}

Help.Window.isVisible = false

Help.Window.wnd = guiCreateWindow(sWidth/2-600/2, sHeight/2-380/2, 600, 380, "Помощь", false)
guiWindowSetSizable(Help.Window.wnd, false)
guiSetVisible(Help.Window.wnd, false)
guiWindowSetMovable(Help.Window.wnd, false)

Help.Window.tabPanel = guiCreateTabPanel(0, 25, 585, 315, false, Help.Window.wnd)
Help.Window.tab1 = guiCreateTab("Основная информация", Help.Window.tabPanel)
--Help.Window.tab2 = guiCreateTab("Что здесь делать?", Help.Window.tabPanel)
Help.Window.tab3 = guiCreateTab("Управление", Help.Window.tabPanel)
guiSetEnabled(Help.Window.tab3, false)
Help.Window.tab4 = guiCreateTab("Тех. поддержка", Help.Window.tabPanel)
guiSetEnabled(Help.Window.tab4, false)

Help.Window.btn_exit = guiCreateButton(0, 345, 600, 25, "Закрыть", false, Help.Window.wnd)
guiSetFont(Help.Window.btn_exit, "default-bold-small")
--guiSetProperty(Help.Window.btn_exit, "NormalTextColour", "FF21b1ff")

-------------------
Help.Window.tab1_info = guiCreateLabel(0, 0, 585, 300, "Приветствуем вас на проекте - OPERSKIY OTDEL!\n\nВНИМАНИЕ\n\nСпешим сообщить, что сервер находится на стадии разработки.\nНа текущий момент игровая модификация имеет ограниченный функционал,\nпоэтому мы не можем предоставить полноценную игровую площадку для наведения суеты :(\n\nАктуальная информация и новости проекта - vk.com/otdelmta\nС уважением, администрация проекта.", false, Help.Window.tab1)
guiLabelSetHorizontalAlign(Help.Window.tab1_info, "center")
guiLabelSetVerticalAlign(Help.Window.tab1_info, "center")
-------------------

function Help.Window.setVisible(state)
	if state == nil then
		Help.Window.isVisible = not guiGetVisible(Help.Window.wnd)
	else
		Help.Window.isVisible = state
	end

	guiSetPosition(Help.Window.wnd, sWidth/2-600/2, sHeight/2-380/2, false) -- исходное положение 
	guiSetEnabled(Help.Window.wnd, true)

	guiSetVisible(Help.Window.wnd, Help.Window.isVisible)

	showCursor(Help.Window.isVisible)

	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, not Help.Window.isVisible)
	triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'dashboard', true) -- ну отключать dashboard
	showChat(not Help.Window.isVisible)
	triggerEvent('operShowUI.drawBlurShader', localPlayer, Help.Window.isVisible)
	--triggerEvent('operShowUI.drawLogoProject', localPlayer, Help.Window.isVisible)
end

bindKey('f9', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    if type(PLAYER_UI) == 'boolean' then return end
	if not PLAYER_UI['dashboard'] then return end

	--if localPlayer:getData('operLoginPanel:isVisible') then
		--return
	--end

	Dashboard.activeWindowShow(Help.Window.wnd)
	Help.Window.setVisible()
end)