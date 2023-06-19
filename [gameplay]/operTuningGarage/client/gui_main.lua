sWidth, sHeight = guiGetScreenSize() 

GUI = { Window = {} }

TuningGarage = {}


function TuningGarage.drawWindow()
	GUI.Window.wnd = guiCreateWindow(15, 15, 230, sHeight-25, "Главное меню", false)
	guiWindowSetSizable(GUI.Window.wnd, false)
	guiWindowSetMovable(GUI.Window.wnd, false)

	GUI.Window.btn_paint = guiCreateButton(0, 35, 215, 25, "Покраска", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_paint, "default-bold-small")
	GUI.Window.btn_paint:setData('operSounds.UI', 'ui_select')
	
	GUI.Window.btn_toner = guiCreateButton(0, 65, 215, 25, "Тонировка", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_toner, "default-bold-small")
	GUI.Window.btn_toner:setData('operSounds.UI', 'ui_select')

	GUI.Window.btn_xenon = guiCreateButton(0, 95, 215, 25, "Ксенон", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_xenon, "default-bold-small")
	GUI.Window.btn_xenon:setData('operSounds.UI', 'ui_select')

	GUI.Window.btn_strob = guiCreateButton(0, 125, 215, 25, "Стробоскопы", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_strob, "default-bold-small")

	--GUI.Window.btn_reset = guiCreateButton(0, 155, 215, 25, "СГУ", false, GUI.Window.wnd)
	--guiSetFont(GUI.Window.btn_reset, "default-bold-small")
	--guiSetEnabled(GUI.Window.btn_reset, false)

	GUI.Window.btn_horn = guiCreateButton(0, 155, 215, 25, "Сигнал", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_horn, "default-bold-small")
	GUI.Window.btn_horn:setData('operSounds.UI', 'ui_select')

	GUI.Window.btn_fso = guiCreateButton(0, 185, 215, 25, "ФСО", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_fso, "default-bold-small")
	GUI.Window.btn_fso:setData('operSounds.UI', 'ui_select')

	GUI.Window.btn_number = guiCreateButton(0, 215, 215, 25, "Номерные знаки", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_number, "default-bold-small")
	GUI.Window.btn_number:setData('operSounds.UI', 'ui_select')

	GUI.Window.btn_wheel = guiCreateButton(0, 245, 215, 25, "Колеса", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_wheel, "default-bold-small")
	GUI.Window.btn_wheel:setData('operSounds.UI', 'ui_select')

	GUI.Window.btn_accessories = guiCreateButton(0, 275, 215, 25, "Аксессуары", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_accessories, "default-bold-small")

	GUI.Window.btn_vinyl = guiCreateButton(0, 305, 215, 25, "Винилы", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_vinyl, "default-bold-small")
--[[
	GUI.Window.btn_tuning = guiCreateButton(0, 305, 215, 25, "Тюнинг", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_tuning, "default-bold-small")
]]
	GUI.Window.btn_neon = guiCreateButton(0, 335, 215, 25, "Неоновая подсветка", false, GUI.Window.wnd)
	guiSetFont(GUI.Window.btn_neon, "default-bold-small")
	-- -- -- -- -- -- -- --
	--GUI.Window.btn_reset = guiCreateButton(0, sHeight-105-45, 215, 25, "Сбросить (удалить тюнинг)", false, GUI.Window.wnd)
	--guiSetFont(GUI.Window.btn_reset, "default-bold-small")
	--guiSetEnabled(GUI.Window.btn_reset, false)
	--
	--GUI.Window.btn_accept = guiCreateButton(0, sHeight-66-55, 215, 45, "Применить (сохранить тюнинг)", false, GUI.Window.wnd)
	--guiSetFont(GUI.Window.btn_accept, "default-bold-small")
	--guiSetProperty(GUI.Window.btn_accept, "NormalTextColour", "FF21b1ff")
	--guiSetEnabled(GUI.Window.btn_accept, false)
	--
	GUI.Window.btn_exit = guiCreateButton(0, sHeight-65, 215, 25, "Покинуть гараж", false, GUI.Window.wnd)
	GUI.Window.btn_exit:setData('operSounds.UI', 'ui_back')

	guiSetFont(GUI.Window.btn_exit, "default-bold-small")
	guiSetProperty(GUI.Window.btn_exit, "NormalTextColour", "fff01a21")
end

function TuningGarage.setWindowVisible(state)

	if state then
		TuningGarage.drawWindow()
		TuningGarage.showAccessoriesHelpButton(false)
		if not isElement(GUI.Window.help_wnd) then
			GUI.Window.help_wnd = drawRectangle(sWidth-525, sHeight-70, 515, 30, 0.7, true)

			local HELP_MOVE_L = drawHelpButton(sWidth-520, sHeight-70, 0, "Режим просмотра", 10, 0, "mouse_right")
			setElementParent(HELP_MOVE_L, GUI.Window.help_wnd)

			local HELP_MOVE_L = drawHelpButton(sWidth-365, sHeight-70, 0, "Вращать камеру", 10, 0, "mouse")
			setElementParent(HELP_MOVE_L, GUI.Window.help_wnd)

			local HELP_MOVE_L = drawHelpButton(sWidth-225, sHeight-70, 0, "Отдалить/приблизить камеру", 10, 0, "mouse_wheel")
			setElementParent(HELP_MOVE_L, GUI.Window.help_wnd)
		end
	else
		destroyElement(GUI.Window.wnd)
		destroyElement(GUI.Window.help_wnd)
	end

	showCursor(state)
end

addEvent('TuningGarage.setWindowVisible', true)
addEventHandler('TuningGarage.setWindowVisible', root, TuningGarage.setWindowVisible)

addEventHandler('onClientGUIClick', root, function()
	if not isElement(GUI.Window.wnd) then
		return
	end

	if source == GUI.Window.btn_exit then
		TuningGarage.setWindowVisible(false)
		playerExitGarage()

	elseif source == GUI.Window.btn_paint then
		GUI.Window.wnd.visible = false
		TuningGarage.setVisiblePaintWindow(true)
		
	elseif source == GUI.Window.btn_toner then
		GUI.Window.wnd.visible = false
		triggerEvent('lmxVehicleToner.setWndVisible', localPlayer, true)
		--TuningGarage.setVisibleTonerWindow(true)
		
	elseif source == GUI.Window.btn_xenon then
		GUI.Window.wnd.visible = false
		TuningGarage.setVisibleXenonWindow(true)
	
	elseif source == GUI.Window.btn_strob then
		GUI.Window.wnd.visible = false
		triggerEvent('operVehicleStrob.setWndVisible', localPlayer, true)
		
	elseif source == GUI.Window.btn_horn then
		GUI.Window.wnd.visible = false
		TuningGarage.setVisibleHornWindow(true)
		
	elseif source == GUI.Window.btn_fso then
		GUI.Window.wnd.visible = false
		TuningGarage.setVisibleFSOWindow(true)
		
	elseif source == GUI.Window.btn_number then
		GUI.Window.wnd.visible = false
		TuningGarage.setVisiblePlateWindow(true)
		
	elseif source == GUI.Window.btn_wheel then
		GUI.Window.wnd.visible = false
		triggerEvent('initWheelsWindow', localPlayer, true)

	elseif source == GUI.Window.btn_accessories then -- аксессуары
		GUI.Window.wnd.visible = false
		triggerEvent('operVehicleObject.setWndVisible', localPlayer)
		TuningGarage.showAccessoriesHelpButton(true)

	elseif source == GUI.Window.btn_vinyl then
		GUI.Window.wnd.visible = false
		triggerEvent('operVehicleVinyl.setWndVisible', localPlayer)

	elseif source == GUI.Window.btn_tuning then
		GUI.Window.wnd.visible = false
		triggerEvent('operVehicleTuning.setWndVisible', localPlayer)

	elseif source == GUI.Window.btn_neon then
		GUI.Window.wnd.visible = false
		triggerEvent('operVehicleNeon.setWndVisible', localPlayer, true)

	end
end)


-- Подсказки для аксессуаров
function TuningGarage.showAccessoriesHelpButton(state)

	if state and not isElement(GUI.Window.help_accessories_1) then
		GUI.Window.help_accessories_1 = drawRectangle(sWidth-660, sHeight-110, 650, 30, 0.7, true)

		local HELP_MOVE_FORWARD = drawHelpButton(sWidth-655, sHeight-110, 0, "Переместить вперед", 10, 0, "b_num8")
		setElementParent(HELP_MOVE_FORWARD, GUI.Window.help_accessories_1)

		local HELP_MOVE_BACKWARD = drawHelpButton(sWidth-490, sHeight-110, 0, "Переместить назад", 10, 0, "b_num2")
		setElementParent(HELP_MOVE_BACKWARD, GUI.Window.help_accessories_1)

		local HELP_MOVE_LEFT = drawHelpButton(sWidth-330, sHeight-110, 0, "Переместить влево", 10, 0, "b_num4")
		setElementParent(HELP_MOVE_LEFT, GUI.Window.help_accessories_1)

		local HELP_MOVE_RIGHT = drawHelpButton(sWidth-170, sHeight-110, 0, "Переместить вправо", 10, 0, "b_num6")
		setElementParent(HELP_MOVE_RIGHT, GUI.Window.help_accessories_1)

		-- --
		local HELP2 = drawRectangle(sWidth-545, sHeight-145, 535, 30, 0.7, true)
		setElementParent(HELP2, GUI.Window.help_accessories_1)

		local HELP_MOVE_UP = drawHelpButton(sWidth-540, sHeight-145, 0, "Поднять", 10, 0, "b_num+")
		setElementParent(HELP_MOVE_UP, HELP2)

		local HELP_MOVE_DOWN = drawHelpButton(sWidth-445, sHeight-145, 0, "Опустить", 10, 0, "b_num-")
		setElementParent(HELP_MOVE_DOWN, HELP2)


		local HELP_MOVE_SIZEBIG = drawHelpButton(sWidth-347, sHeight-145, 0, "Увеличить", 10, 0, "b_lshift", 46)
		setElementParent(HELP_MOVE_SIZEBIG, HELP2)

		local HELP_MOVE_SIZEBIG = drawHelpButton(sWidth-225, sHeight-144, 0, "+", 10, 0, "b_num+")
		setElementParent(HELP_MOVE_SIZEBIG, HELP2)


		local HELP_MOVE_SIZESMALL = drawHelpButton(sWidth-177, sHeight-145, 0, "Уменьшить", 10, 0, "b_lshift", 46)
		setElementParent(HELP_MOVE_SIZESMALL, HELP2)

		local HELP_MOVE_SIZESMALL = drawHelpButton(sWidth-50, sHeight-144, 0, "+", 10, 0, "b_num-")
		setElementParent(HELP_MOVE_SIZESMALL, HELP2)

		-- --
		local HELP3 = drawRectangle(sWidth-430, sHeight-180, 420, 30, 0.7, true)
		setElementParent(HELP3, GUI.Window.help_accessories_1)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-425, sHeight-180, 0, "Вращать относительно оси", 10, 0, "b_lalt", 46)
		setElementParent(HELP_MOVE_FAST, HELP3)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-203, sHeight-179, 0, "+", 10, 0, "b_num4")
		setElementParent(HELP_MOVE_FAST, HELP3)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-164, sHeight-179, 0, "", 10, 0, "b_num6")
		setElementParent(HELP_MOVE_FAST, HELP3)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-134, sHeight-179, 0, "", 10, 0, "b_num8")
		setElementParent(HELP_MOVE_FAST, HELP3)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-104, sHeight-179, 0, "", 10, 0, "b_num2")
		setElementParent(HELP_MOVE_FAST, HELP3)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-74, sHeight-179, 0, "", 10, 0, "b_num+")
		setElementParent(HELP_MOVE_FAST, HELP3)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-44, sHeight-179, 0, "", 10, 0, "b_num-")
		setElementParent(HELP_MOVE_FAST, HELP3)

		-- --
		local HELP4 = drawRectangle(sWidth-380, sHeight-215, 370, 30, 0.7, true)
		setElementParent(HELP4, GUI.Window.help_accessories_1)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-375, sHeight-215, 0, "Ускорить действие", 10, 0, "b_lctrl", 46)
		setElementParent(HELP_MOVE_FAST, HELP4)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-203, sHeight-214, 0, "+", 10, 0, "b_num4")
		setElementParent(HELP_MOVE_FAST, HELP4)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-164, sHeight-214, 0, "", 10, 0, "b_num6")
		setElementParent(HELP_MOVE_FAST, HELP4)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-134, sHeight-214, 0, "", 10, 0, "b_num8")
		setElementParent(HELP_MOVE_FAST, HELP4)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-104, sHeight-214, 0, "", 10, 0, "b_num2")
		setElementParent(HELP_MOVE_FAST, HELP4)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-74, sHeight-214, 0, "", 10, 0, "b_num+")
		setElementParent(HELP_MOVE_FAST, HELP4)

		local HELP_MOVE_FAST = drawHelpButton(sWidth-44, sHeight-214, 0, "", 10, 0, "b_num-")
		setElementParent(HELP_MOVE_FAST, HELP4)
	else
		if isElement(GUI.Window.help_accessories_1) then
			destroyElement(GUI.Window.help_accessories_1)
		end
	end
end