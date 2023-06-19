local x, y = guiGetScreenSize()
open = getTickCount()

function mainmenu_render ()
    dxDrawWindow((x - 408) / 2, (y - 238) / 2, 408, 278, "Настройка камеры")
    dxDrawScrollSize_Slow((x - 385) / 2, ( y - 158) / 2, 385, 40, scroll1, "Скорость обычной камеры")
    dxDrawScrollSize_Fast((x - 385) / 2, ( y - 58) / 2, 385, 40, scroll2, "Скорость ускоренной камеры")
    dxDrawCheckbox((x - 300) / 2, ( y + 37) / 2, 385, 55, (x - 385) / 2, ( y + 57) / 2, 30, 30, "Плавное движение камеры", utils.smoth, 1)
    dxDrawCheckbox((x - 300) / 2, ( y + 107) / 2, 385, 55, (x - 385) / 2, ( y + 127) / 2, 30, 30, "Скрыть персонажа", utils.alpha, 3)
    dxDrawButtonMenu((x - 385) / 2, ( y + 205) / 2, 185, 45, "Сохранить и закрыть", 1)
    dxDrawButtonMenu((x + 15) / 2, ( y + 205) / 2, 185, 45, "Сбросить настройки", 2)
end

function setting_render ()
    dxDrawWindow((x - 408) / 2, (y - 238) / 2, 408, 128, "")
    dxDrawButtonMenu((x - 385) / 2, ( y - 198) / 2, 185, 45, "Настройка камеры", 1)
    dxDrawButtonMenu((x + 15) / 2, ( y - 198) / 2, 185, 45, "Настройка времени", 2)
    dxDrawButton((x - 385) / 2, ( y - 88 ) / 2 , 385, 40, "Закрыть окно", 3)
end

function weather_render( )
	table = weather
    if #table <= 6 then 
    	line = #table
    else 
    	line = 6
    end
	for i = 1, line, 1 do
		local test = ( (i * 100) / 2 ) 
		local canceltest = ( (i * 290) / 2 ) 
		int = 108 + test
		intcancel = int - canceltest
	end
	dxDrawWindow((x - 408) / 2, (y - 238) / 2, 408, ( int ), "Настройка времени")
	dxDrawButton((x + 15) / 2, ( y - intcancel ) / 2 , 185, 40, "Закрыть окно", 2)
    for i = 1, line, 1 do
        if table[i][1] == nil then return end
        a = i
        i = i + k - 1
        local integer = 250 - (a * 101)
        dxDrawRoute((x - 385) / 2, ( y - integer ) / 2 , 385, 40, table[i][2], i)
    end
    local iRows = #table
	local iGridY = (y - 150 ) / 2 - (40.6*line)/iRows
	dxDrawRectangle((x - 408) / 2+408, iGridY + (40.6*line)/iRows*k, -8, ( 40.6*line )/#table*line+50, tocolor(200, 40, 40, 255))
	createEdit("hours", (x - 385) / 2, ( y - intcancel ) / 2 , 55, 40, "12")
	createEdit("minutes", (x - 270) / 2, ( y - intcancel ) / 2 , 55, 40, "00")
	dxDrawButton((x - 152) / 2, ( y - intcancel ) / 2 , 79, 40, "Ок", 4)
end

bindKey ("mouse_wheel_down", "down", function () 
	if not table then return end
	if weather_start or time_start then
		if k > #table - line then k = k return end
		k = k + 1
        outputChatBox(k)
	end
end)

bindKey ("mouse_wheel_up", "down", function ()
	if not table then return end
	if weather_start or time_start then
		if k == 1 then k = k return end
		k = k - 1 
        outputChatBox(k)
	end
end)

addEventHandler( "onClientClick", root, function(button, state)
	if setting_start then
		if cursorPosition((x - 385) / 2, ( y - 198) / 2, 185, 45) and button == "left" and state == "down" and setting_start then 
			checkToOpen()
			startMainMenu()
		end
		if cursorPosition((x + 15) / 2, ( y - 198) / 2, 185, 45) and button == "left" and state == "down" and setting_start then 
			checkToOpen()
            openBG = getTickCount()
			startWeatherMainMenu()
		end
		if cursorPosition((x - 385) / 2, ( y - 78 ) / 2 , 385, 40) and button == "left" and state == "down" and setting_start then 
			stopSettingMenu()
		end
	end
	if weather_start and intcancel then
		if cursorPosition((x + 15) / 2, ( y - intcancel ) / 2 , 385, 40) and button == "left" and state == "down" and weather_start then
			stopWeatherMainMenu()
		end 
		if cursorPosition((x - 152) / 2, ( y - intcancel ) / 2 , 79, 40) and button == "left" and state == "down" and weather_start then
			local hours = getEditText("hours")
			if string.len(hours) <= 0 then return end
			local minutes = getEditText("minutes")
			if string.len(minutes) <= 0 then return end
			if tonumber(hours) >= 0 or tonumber(hours) <= 24 then
				if tonumber(minutes) >= 0 or tonumber(minutes) <= 60 then
					setTime(hours, minutes)		
				else
					setEditText("minutes", "00")
				end
			else
				setEditText("hours", "12")
			end
		end 
	end
	if cursorPosition( (x - 385) / 2, ( y + 57) / 2, 30, 30 ) and button == "left" and state == "down" and mainmenu_start then
		if utils.smoth then
			stopSmoth()
			utils.smoth = false
		else
			startSmoth()
			utils.smoth = true
		end
	end
    if cursorPosition( (x - 385) / 2, ( y + 127) / 2, 30, 30) and button == "left" and state == "down" and mainmenu_start then
    	if isTimer(timerAlpha) then killTimer(timerAlpha) end
        if utils.alpha then
            timerAlpha = setTimer(function (  )
                localPlayer.alpha = localPlayer.alpha + 15
                if localPlayer.alpha == 255 then killTimer(timerAlpha) end
            end, 60, 0)
            utils.alpha = false
        else
            timerAlpha = setTimer(function (  )
                localPlayer.alpha = localPlayer.alpha - 15
                if localPlayer.alpha == 0 then killTimer(timerAlpha) end
            end, 60, 0)
            utils.alpha = true
        end
    end
    if weather_start and line then
        for i = 1, line, 1 do
            if table[i][1] == nil then return end
            a = i
            i = i + k - 1
            local integer = 250 - (a * 101)
            if cursorPosition((x - 385) / 2, ( y - integer ) / 2 , 385, 40) and button == "left" and state == "down" and weather_start then
                setWeather(i)
            end
        end
    end
	if cursorPosition((x + 15) / 2, ( y + 205) / 2, 185, 45) and button == "left" and state == "down" and mainmenu_start then
		utils.move_speed = DEFAULT_MOVE_SPEED
		utils.fastMaxSpeed = DEFAULT_MAX_SPEED
		scroll1 = (x - 385) / 2 + (3850*utils.move_speed)
		scroll2 = ((x - 385) / 2) + (22*utils.fastMaxSpeed)
		if isSmoothneess then
			stopSmoth()
			utils.smoth = false
		end
	end
	if cursorPosition((x - 385) / 2, ( y + 205) / 2, 185, 45) and button == "left" and state == "down" and mainmenu_start then
		stopMainMenu()
	end
    if button == "left" and state == "down" and mainmenu_start then
        local x, y, w, h = (x - 385) / 2, ( y - 158) / 2, 385, 40
        if cursorPosition( scroll1, y-5, 10, h+15 ) then
            scrollMoving1 = true
        else
            if scroll1 <= x then
                if cursorPosition( x, y-5, 10, h+15 ) then
                    scrollMoving1 = true
                end
            else
                if cursorPosition( (x+w)-10, y-5, 10, h+15 ) then
                    scrollMoving1 = true
                end
            end
        end
    elseif button == "left" and state == "up" then
        if scrollMoving1 then
            scrollMoving1 = false
        end
    end
    if button == "left" and state == "down" and mainmenu_start then
        local x, y, w, h = (x - 385) / 2, ( y - 58) / 2, 385, 40
        if cursorPosition( scroll2, y-5, 10, h+15 ) then
            scrollMoving2 = true
        else
            if scroll1 <= x then
                if cursorPosition( x, y-5, 10, h+15 ) then
                    scrollMoving2 = true
                end
            else
                if cursorPosition( (x+w)-10, y-5, 10, h+15 ) then
                    scrollMoving2 = true
                end
            end
        end
    elseif button == "left" and state == "up" then
        if scrollMoving2 then
            scrollMoving2 = false
        end
    end
end)

addEventHandler( "onClientCursorMove", getRootElement( ), function ( _, _, xMove )
    if scrollMoving1 and mainmenu_start then
        scroll1 = xMove
        utils.move_speed = camhack_move_speed
    end
    if scrollMoving2 and mainmenu_start then
        scroll2 = xMove
    end
end)

