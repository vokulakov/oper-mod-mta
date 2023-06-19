local messages = {}
local sW, sH = guiGetScreenSize()

local posX, posY = sW - 235, 100

-- Настройки
local FONT = 'default-bold' -- шрифт
local offset = dxGetFontHeight(1, FONT)

local tick = getTickCount()

-- ОТОБРАЖЕНИЕ УВЕДОМЛЕНИЙ [НАЧАЛО] --
addEventHandler("onClientRender", root, function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end

	if not PLAYER_UI['notify'] then return end
	
	tick = getTickCount()
	local prev = 0

	if (#messages > 3) then
		table.remove(messages, 1)
	end

	for index, data in ipairs(messages) do

		local v1 = data[1] -- текст
		local v2 = data[2] -- количество строк
		local v3 = data[3] -- ширина текста
		local v4 = data[4] -- время
		local v5 = data[5] -- альфа
		local v6 = data[6] -- цвет полоски

		dxDrawRectangle(posX, posY+prev, 230, offset*v2+5, tocolor(0, 0, 0, v5))
		dxDrawRectangle(posX, posY+prev, 2, offset*v2+5, tocolor(v6[1], v6[2], v6[3], v5))

		dxDrawText(v1, posX+15, posY+prev+2, 230, posY, tocolor(255, 255, 255, v5 + 55), 1, FONT, 'left', 'top')

		if (tick >= v4) then
			messages[index][5] = v5 - 2
			if (v5 <= 25) then
				table.remove(messages, index)
			end
		end

		prev = prev + v3 + 10
	end

end)
-- ОТОБРАЖЕНИЕ УВЕДОМЛЕНИЙ [КОНЕЦ] --

local function addNotification(text, type, _sound)
	local color
	local line_count = 1

	local sound = true

	if _sound ~= nil then sound = _sound end

	for S in string.gmatch(text, "\n") do
		line_count = line_count + 1
	end

	if type == 1 then
		color = {33, 177, 255}
		if sound then

			playSound('assets/notify.mp3')
		end
	elseif type == 2 then
		color = {240, 26, 33}
		if sound then
			playSound('assets/error.wav')
		end
	end

	table.insert(messages, {text, line_count, offset*line_count, tick + 10000, 200, color})

end
addEvent("operNotification.addNotification", true)
addEventHandler("operNotification.addNotification", root, addNotification)

--addNotification('Тестовое уведомление!\nДобро пожаловать на Queen MTA.\nПриятной игры!', 1, true)
--addNotification('Приветствуем в Оперском отделе!', 1, true)
--addNotification('Вы успешно создали транспорт!', 1, true)
--addNotification('Тестовое уведомление!\nДобро пожаловать на Queen MTA.\nПриятной игры!', 1, true)





local sW, sH = guiGetScreenSize()

Control = {}

Control.isVisible = true
Control.isCurrentPanel = 'player'

local FONTS = {
	['TITTLE'] 		= dxCreateFont("assets/Roboto-Bold.ttf", 8, false, "draft"),
	['CONTROL'] 	= dxCreateFont("assets/Roboto-Regular.ttf", 8, false, "draft"),
	['HELP'] 		= dxCreateFont("assets/Roboto-Regular.ttf", 7, false, "draft")
}

local CONTROLS = { }

local plControl = {
	{'TAB', 'Список игроков'},
	{'T', 'Сообщение в чат'},

	{'F11', 'Карта'},
	{'F6', 'Настройки игры'},
	{'F1', 'Главное меню'},
}

local offset = 30
local width, height 
local posX, posY 


local function drawHelpControl()
	if not Control.isVisible then
		return
	end

	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['control'] then return end

	width, height = 230, #CONTROLS*offset+20
	posX, posY = sW-width-5, sH/2+height/2-30

	-- ШАПКА --
	dxDrawRectangle(posX, posY-24-height, width, 20, tocolor(0, 0, 0, 245), false)
	
	dxDrawText('Управление', posX+5, posY-21-height, width, 20, tocolor(255, 255, 255, 255), 1, FONTS['TITTLE'], 'left', 'top')
	dxDrawRectangle(posX, posY-height-4, width, height, tocolor(0, 0, 0, 200), false)

	local prev = 15
	for index, data in ipairs(CONTROLS) do

		-- КНОПКА --
		dxDrawRectangle(posX+5, posY-(prev)-offset, 30, 18, tocolor(33, 177, 255, 215), false)
		dxDrawText(data[1], posX+5, posY-(10+prev), posX+5+30, posY-(prev)-offset, tocolor(255, 255, 255, 255), 1, FONTS['TITTLE'], 'center', 'center')
		
		-- ДЕЙСТВИЕ --
		dxDrawText(data[2], posX, posY-(10+prev), posX+width-5, posY-(prev)-offset, tocolor(255, 255, 255, 150), 1, FONTS['CONTROL'], 'right', 'center')
		
		-- ПОЛОСКА --
		dxDrawRectangle(posX+5, posY-(10+prev), width-10, 1, tocolor(255, 255, 255, 100), false)
		prev = prev + offset
	end

	dxDrawText("Скрыть/показать окно помощи 'F5'", posX+5, posY-20, width, 20, tocolor(255, 255, 255, 100), 1, FONTS['HELP'])
end

addEventHandler("onClientRender", root, drawHelpControl)

addEventHandler('onClientResourceStart', resourceRoot, function()
	for _, control in ipairs(plControl) do
		Control.addControl(control[1], control[2])
	end
	Control.isCurrentPanel = 'player'
end)

function Control.addControl(but, act)
	table.insert(CONTROLS, {but, act})
end

function Control.removeControl(but)
	for i, control in ipairs(CONTROLS) do
		if control[1] == but then
			table.remove(CONTROLS, i)
			return true
		end
	end

	return false
end

function Control.setVisible()
	Control.isVisible = not Control.isVisible
end

-- VEHICLES --
local vehControl = {
	{'[, ]', 'Поворотники'},
	{'C', 'Круиз-контроль'},
	{'H', 'Гудок'},
	{'U', 'Вид от первого лица'},
	{'G', 'Стробоскопы'},
	{'1', 'Фары'},
	{'2', 'Двигатель'},
	{'3', 'Моргание фарами'},
	{'B', 'Чип-тюнинг'},
	{'0', 'Музыка'},
	{'F3', 'Тюнинг транспортного средства'},
	{'F2', 'Меню управления транспортом'},
}

function Control.onClientVehicle(state)
	if not state then
		for _, control in ipairs(vehControl) do
			Control.removeControl(control[1])
		end

		for _, control in ipairs(plControl) do
			Control.addControl(control[1], control[2])
		end

		return
	end

	for _, control in ipairs(plControl) do
		Control.removeControl(control[1], control[2])
	end

	for _, control in ipairs(vehControl) do
		Control.addControl(control[1], control[2])
	end
end

addEventHandler("onClientVehicleEnter", root, function(thePlayer, seat)
	if thePlayer == localPlayer and seat == 0 then
		if Control.isCurrentPanel == 'player' then
			Control.onClientVehicle(true)
			Control.isCurrentPanel = 'vehicle'
		end
	end
end)
--[[
addEventHandler("onClientVehicleStartExit", root, function(thePlayer, seat)
    if thePlayer == localPlayer and seat == 0 then
    	Control.onClientVehicle(false)
    end
end)
]]
addEventHandler("onClientVehicleExit", root, function(thePlayer, seat)
	if thePlayer == localPlayer and seat == 0 then
		if Control.isCurrentPanel == 'vehicle' then
			Control.onClientVehicle(false)
			Control.isCurrentPanel = 'player'
		end
	end
end)

bindKey("F5", "down", Control.setVisible)


addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		if localPlayer.vehicle == source and localPlayer.vehicle.controller == localPlayer then
			if Control.isCurrentPanel == 'vehicle' then
		   		Control.onClientVehicle(false)
				Control.isCurrentPanel = 'player'
			end
		end
	end
end)

addEventHandler("onClientVehicleExplode", root, function()
	if localPlayer.vehicle == source and localPlayer.vehicle.controller == localPlayer then
		if Control.isCurrentPanel == 'vehicle' then
			Control.onClientVehicle(false)
			Control.isCurrentPanel = 'player'
		end
	end
end)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	if localPlayer.vehicle and localPlayer.vehicle.controller == localPlayer then
		if Control.isCurrentPanel == 'vehicle' then
			Control.onClientVehicle(false)
			Control.isCurrentPanel = 'player'
	 	end
	end
end)