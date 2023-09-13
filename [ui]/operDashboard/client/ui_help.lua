Help = {}
Help.Window = {}

Help.Window.isVisible = false

local playerControl = {
	{ key = 'F1', option = 'главное меню', description = '' },
	{ key = 'F4', option = 'скрыть интерфейс', description = '' },
	{ key = 'F5', option = 'подсказки управления', description = '' },
	{ key = 'F6', option = 'настройка игры', description = '' },
	{ key = 'F9', option = 'окно помощи', description = '' },
	{ key = 'F11', option = 'карта', description = '' },
	{ key = 'F12', option = 'скриншот', description = '' },
	{ key = 'TAB', option = 'список игроков', description = '' },
	{},
	{ key = 'T', option = 'сообщение в общий чат', description = '' },
	{ key = 'Y', option = 'сообщение в локальный чат', description = 'сообщение увидят игроки поблизости' },
	{},
	{ key = 'LSHIFT + X', option = 'меню звуковых фрагментов', description = 'так же доступно из меню "F1"' },
	{ key = 'X', option = 'воспроизвести звуковой фрагмент', description = '' },
	{ key = 'U', option = 'режим selfie', description = 'сэлфи' },
}

local vehicleControl = {
	{ key = 'F2', option = 'меню управления транспортом', description = 'починка, открывание дверей и т.д.' },
	{ key = 'F3', option = 'меню тюнинга транспорта', description = 'тонировка, покраска, номера и т.д.' },
	{},
	{ key = '1', option = 'габариты/фары', description = '' },
	{ key = '2', option = 'запуск двигателя', description = '' },
	{ key = '3', option = 'моргание фарами', description = '' },
	{},
	{ key = '[, ]', option = 'указатели поворота', description = 'одновременное нажатие активирует аварийку' },
	{},
	{ key = '4, 5', option = 'онлайн радио', description = 'предыдущая/следующая станция соответственно' },
	{ key = '0', option = 'музыкальный плеер', description = 'онлайн музыка' },
	{},
	{ key = 'B', option = 'чип-тюнинг', description = '' },
	{ key = 'U', option = 'вид от первого лица', description = 'настройка положения камеры в меню "F2"' },
	{ key = 'C', option = 'круиз-контроль', description = '' },
	{ key = 'H', option = 'звуковой сигнал', description = '' },
	{ key = 'K', option = 'открытие/закрытие дверей', description = '' },
	{ key = 'G', option = 'стробоскопы', description = '' },
	{ key = 'L', option = 'вспышки ФСО', description = 'устанавливаются в тюнинг-гараже "F3"' },
	{ key = 'M , < , > , ?', option = 'СГУ', description = '' },
	{ key = "CTRL / MOUSE1", option = 'закись азота', description = '' },
}

Help.Window.wnd = guiCreateWindow(sWidth/2-1024/2, sHeight/2-568/2, 1024, 568, "Информация [F9]", false)
guiWindowSetSizable(Help.Window.wnd, false)
guiSetVisible(Help.Window.wnd, false)
guiWindowSetMovable(Help.Window.wnd, false)

Help.Window.tabPanel = guiCreateTabPanel(0, 25, 1004, 500, false, Help.Window.wnd)

--Help.Window.tab1 = guiCreateTab("О проекте", Help.Window.tabPanel)

--Help.Window.tab2 = guiCreateTab("Что здесь делать?", Help.Window.tabPanel)

Help.Window.tab3 = guiCreateTab("Управление", Help.Window.tabPanel)

-- УПРАВЛЕНИЕ --
local lbl = guiCreateLabel(20, 15, 265, 50, "ОСНОВНОЕ УПРАВЛЕНИЕ", false, Help.Window.tab3)
guiSetFont(lbl, "default-bold-small")
guiLabelSetColor(lbl, 240, 26, 33)
--guiLabelSetHorizontalAlign(lbl, 'center')

for i, control in ipairs(playerControl) do
	if control.key then

		local offsetX = 20
		-- Клавиша
		local lbl = guiCreateLabel(offsetX, 20 + i*20, 200, 50, '[', false, Help.Window.tab3)
		guiSetAlpha(lbl, 0.4)

		offsetX = offsetX + 8
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 200, 50, control.key, false, Help.Window.tab3)
		guiLabelSetHorizontalAlign(lbl, "left")
		guiSetFont(lbl, "default-bold-small")
		guiLabelSetColor(lbl, 33, 177, 255)

		offsetX = offsetX + 3.5 + guiLabelGetTextExtent(lbl)
		local lbl = guiCreateLabel(offsetX, 20 + i*20, 200, 50, ']', false, Help.Window.tab3)
		guiSetAlpha(lbl, 0.4)

		-- Тире
		offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 200, 50, '—', false, Help.Window.tab3)
		guiLabelSetHorizontalAlign(lbl, "left")
		guiSetFont(lbl, "default-bold-small")
		guiSetAlpha(lbl, 0.4)

		-- Действие
		offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 200, 50, control.option, false, Help.Window.tab3)
		guiLabelSetHorizontalAlign(lbl, "left")

		-- Дополнительное описание
		if control.description ~= '' then
			offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
			local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 300, 50, '('..control.description..')', false, Help.Window.tab3)
			guiLabelSetHorizontalAlign(lbl, "left")
			guiSetAlpha(lbl, 0.4)
		end

	end
end

local lbl = guiCreateLabel(1024/2, 15, 365, 50, "УПРАВЛЕНИЕ ТРАНСПОРТОМ", false, Help.Window.tab3)
guiSetFont(lbl, "default-bold-small")
guiLabelSetColor(lbl, 240, 26, 33)
--guiLabelSetHorizontalAlign(lbl, 'center')

for i, control in ipairs(vehicleControl) do
	if control.key then

		local offsetX = 1024/2
		-- Клавиша
		local lbl = guiCreateLabel(offsetX, 20 + i*20, 365, 50, '[', false, Help.Window.tab3)
		guiSetAlpha(lbl, 0.4)

		offsetX = offsetX + 8
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 365, 50, control.key, false, Help.Window.tab3)
		guiLabelSetHorizontalAlign(lbl, "left")
		guiSetFont(lbl, "default-bold-small")
		guiLabelSetColor(lbl, 33, 177, 255)

		offsetX = offsetX + 3.5 + guiLabelGetTextExtent(lbl)
		local lbl = guiCreateLabel(offsetX, 20 + i*20, 365, 50, ']', false, Help.Window.tab3)
		guiSetAlpha(lbl, 0.4)

		-- Тире
		offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 365, 50, '—', false, Help.Window.tab3)
		guiLabelSetHorizontalAlign(lbl, "left")
		guiSetFont(lbl, "default-bold-small")
		guiSetAlpha(lbl, 0.4)

		-- Действие
		offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 365, 50, control.option, false, Help.Window.tab3)
		guiLabelSetHorizontalAlign(lbl, "left")

		-- Дополнительное описание
		if control.description ~= '' then
			offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
			local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 365, 50, '('..control.description..')', false, Help.Window.tab3)
			guiLabelSetHorizontalAlign(lbl, "left")
			guiSetAlpha(lbl, 0.4)
		end

	end
end

----------------
Help.Window.tab4 = guiCreateTab("Команды сервера", Help.Window.tabPanel)

local lbl = guiCreateLabel(20, 15, 365, 50, "КОМАНДЫ ДЛЯ ROLE PLAY (RP/РП) СИТУАЦИЙ", false, Help.Window.tab4)
guiSetFont(lbl, "default-bold-small")
guiLabelSetColor(lbl, 240, 26, 33)

local cmdRolePlay = {
	{ cmd = 'me', text = "[текст]", option = 'действия от лица персонажа', description = 'Например: /me взял папку с документами в правую руку'},
	{},
	{},
	{ cmd = 'try', text = "[текст]", option = ' попытка совершения действия от лица персонажа', description = 'Например: /try уронил бутылку силой мысли'},
	{},
	{},
	{ cmd = 'do', text = "[текст]", option = 'описание ситуации происходящей поблизости от третьего лица', description = 'Например: /do За углом дома были слышны выстрелы'},
	{},
	{},
	{ cmd = 'todo', text = "[текст]", option = 'описание действий и прямой речи происходящие от лица персонажа', description = 'Например: /todo Спасибо за внимание.*Сделав поклон перед публикой.'},
}

for i, command in ipairs(cmdRolePlay) do
	if command.cmd then
		local offsetX = 20
		-- Команда
		local lbl = guiCreateLabel(offsetX, 20 + i*20, 200, 50, '/', false, Help.Window.tab4)
		
		-- Дополнительное описание
		if command.description ~= '' then
			local lbl = guiCreateLabel(offsetX, 20 + (i+1)*20, 500, 50, command.description, false, Help.Window.tab4)
			guiLabelSetHorizontalAlign(lbl, "left")
			guiSetAlpha(lbl, 0.4)
		end
				
		offsetX = offsetX + 8
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 200, 50, command.cmd, false, Help.Window.tab4)
		guiLabelSetHorizontalAlign(lbl, "left")
		guiSetFont(lbl, "default-bold-small")
		guiLabelSetColor(lbl, 33, 177, 255)

		if command.text ~= "" then
			offsetX = offsetX + 3.5 + guiLabelGetTextExtent(lbl)
			lbl = guiCreateLabel(offsetX, 20 + i*20, 300, 50, command.text, false, Help.Window.tab4)
			guiSetAlpha(lbl, 0.4)
		end

		-- Тире
		offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 200, 50, '—', false, Help.Window.tab4)
		guiLabelSetHorizontalAlign(lbl, "left")
		guiSetFont(lbl, "default-bold-small")
		guiSetAlpha(lbl, 0.4)

		-- Действие
		offsetX = offsetX + guiLabelGetTextExtent(lbl) + 5
		local lbl = guiCreateLabel(offsetX, 20 + 1 + i*20, 400, 50, command.option, false, Help.Window.tab4)
		guiLabelSetHorizontalAlign(lbl, "left")

	end
end

-- ДОНАТ
local RB_LIGHT_FONT = guiCreateFont("assets/Roboto-Light.ttf", 13)
local RB_BOLD_FONT = guiCreateFont("assets/Roboto-Bold.ttf", 10)

Help.Window.tab5 = guiCreateTab("Донат", Help.Window.tabPanel)

Help.Window['img_donate'] = guiCreateStaticImage(2, 2, 1000, 470, "assets/img_donate.png", false, Help.Window.tab5)
guiSetEnabled(Help.Window['img_donate'], false)

Help.Window['btn_copy_www'] = guiCreateButton(240, 287, 180, 25, "Копировать адрес сайта", false, Help.Window.tab5)
guiSetFont(Help.Window['btn_copy_www'], RB_BOLD_FONT)
guiSetProperty(Help.Window['btn_copy_www'], "HoverTextColour", "FF21b1ff")
Help.Window['btn_copy_www']:setData('operSounds.UI', 'ui_select')

addEventHandler("onClientGUIClick", Help.Window['btn_copy_www'], function()
	if not Help.Window.tab5.visible then 
		return
	end
	setClipboard('https://opermta.ru/')
	Help.Window['btn_copy_www']:setText("Скопировано")
	guiSetEnabled(Help.Window['btn_copy_www'], false)
	setTimer(
		function()
			Help.Window['btn_copy_www']:setText("Копировать адрес сайта")
			guiSetEnabled(Help.Window['btn_copy_www'], true)
		end, 1000, 1)
end, false)

Help.Window['btn_copy_vk'] = guiCreateButton(240, 330, 180, 25, "Копировать адрес VK", false, Help.Window.tab5)
guiSetFont(Help.Window['btn_copy_vk'], RB_BOLD_FONT)
guiSetProperty(Help.Window['btn_copy_vk'], "HoverTextColour", "FF21b1ff")
Help.Window['btn_copy_vk']:setData('operSounds.UI', 'ui_select')

addEventHandler("onClientGUIClick", Help.Window['btn_copy_vk'], function()
	if not Help.Window.tab5.visible then 
		return
	end
	setClipboard('https://vk.com/otdelmta')
	Help.Window['btn_copy_vk']:setText("Скопировано")
	guiSetEnabled(Help.Window['btn_copy_vk'], false)
	setTimer(
		function()
			Help.Window['btn_copy_vk']:setText("Копировать адрес VK")
			guiSetEnabled(Help.Window['btn_copy_vk'], true)
		end, 1000, 1)
end, false)

-- Выводить логин
local lbl = guiCreateLabel(60, 373, 200, 50, "Аккаунт: ", false, Help.Window.tab5)
guiSetFont(lbl, RB_BOLD_FONT)

Help.Window['lbl_login'] = guiCreateLabel(118, 373, 200, 50, "", false, Help.Window.tab5)
guiSetFont(Help.Window['lbl_login'], RB_BOLD_FONT)
guiLabelSetColor(Help.Window['lbl_login'], 255, 214, 0)

Help.Window['btn_copy_login'] = guiCreateButton(240, 373, 180, 25, "Копировать логин", false, Help.Window.tab5)
guiSetFont(Help.Window['btn_copy_login'], RB_BOLD_FONT)
guiSetProperty(Help.Window['btn_copy_login'], "HoverTextColour", "FF21b1ff")
Help.Window['btn_copy_login']:setData('operSounds.UI', 'ui_select')

addEventHandler("onClientGUIClick", Help.Window['btn_copy_login'], function()
	if not Help.Window.tab5.visible then 
		return
	end
	local accountData = localPlayer:getData("player.accountData")
    if not accountData or not accountData.username then
        return ""
    end
	setClipboard(tostring(accountData.username))
	Help.Window['btn_copy_login']:setText("Скопировано")
	guiSetEnabled(Help.Window['btn_copy_login'], false)
	setTimer(
		function()
			Help.Window['btn_copy_login']:setText("Копировать логин")
			guiSetEnabled(Help.Window['btn_copy_login'], true)
		end, 1000, 1)
end, false)

Help.Window.btn_exit = guiCreateButton(0, 530, 1024, 30, "Закрыть", false, Help.Window.wnd)
guiSetFont(Help.Window.btn_exit, "default-bold-small")
guiSetProperty(Help.Window.btn_exit, "NormalTextColour", "FF21b1ff")
Help.Window.btn_exit:setData('operSounds.UI', 'ui_back')

-------------------
--[[
Help.Window.tab1_info = guiCreateLabel(0, 0, 585, 300, "Приветствуем вас на проекте - OPERSKIY OTDEL!\n\nВНИМАНИЕ\n\nСпешим сообщить, что сервер находится на стадии разработки.\nНа текущий момент игровая модификация имеет ограниченный функционал,\nпоэтому мы не можем предоставить полноценную игровую площадку для наведения суеты :(\n\nАктуальная информация и новости проекта - vk.com/otdelmta\nС уважением, администрация проекта.", false, Help.Window.tab1)
guiLabelSetHorizontalAlign(Help.Window.tab1_info, "center")
guiLabelSetVerticalAlign(Help.Window.tab1_info, "center")
]]
-------------------

-- Получение логина аккаунта локального игрока (маскировка)
function Help.Window.getPlayerAccountLogin()
	local accountData = localPlayer:getData("player.accountData")
    if not accountData or not accountData.username then
        return ""
    end
	local username = accountData.username
	local username_len = username:len()

	username = username:sub(0, username_len/2)..''..("*"):rep(username_len/2 + math.random(2,4))

	return username
end

function Help.Window.openDonateTab()
	if not Help.Window.isVisible then
		return
	end
	guiSetSelectedTab(Help.Window.tabPanel, Help.Window.tab5)
end

function Help.Window.openHelpTab()
	if not Help.Window.isVisible then
		return
	end
	guiSetSelectedTab(Help.Window.tabPanel, Help.Window.tab3)
end 

function Help.Window.setVisible(state)
	if state == nil then
		Help.Window.isVisible = not guiGetVisible(Help.Window.wnd)
	else
		Help.Window.isVisible = state
	end

	guiSetEnabled(Help.Window.wnd, true)

	guiSetVisible(Help.Window.wnd, Help.Window.isVisible)

	showCursor(Help.Window.isVisible)

	Help.Window['lbl_login']:setText(Help.Window.getPlayerAccountLogin())

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

addEventHandler("onClientGUIClick", root, function()
	if not Help.Window.isVisible then
		return
	end

	if source == Help.Window.btn_exit then
		Help.Window.setVisible(false)
	end

end)