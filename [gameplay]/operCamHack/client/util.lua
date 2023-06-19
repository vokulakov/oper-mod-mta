local font_text = dxCreateFont("fonts/Exo2.otf", 15)
local font = "default-bold"
local tables = { 0 }
local tables_menu = { 0 }
local tables_1 = { 190 }
local box = {}

function dxDrawScrollSize_Slow (x, y, w, h, scroll, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(75, 75, 75, 230)
	local tcolor = tocolor(255, 255, 255, 255)

	if scrollMoving then
		tcolor = tocolor(255, 255, 255, 255)
	end
	tcolor = tocolor(255, 255, 255, 255)
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	local tcolortext =  tocolor(255, 255, 255)
	dxDrawText(text, x + 8, y, w + x, h + y, tcolortext, 1, "default-bold", "center", "center", true, false, false, true)
	if scroll >= x and scroll <= (x+w)-10 then
		dxDrawRectangle(scroll, y-5, 10, h+8, tcolor, false)
		scrollProcent = ((scroll-x)/w)/10
		local size = math.floor(scrollProcent)
		camhack_move_speed = scrollProcent
	else
		if scroll <= x then
			dxDrawRectangle(x, y-5, 10, h+10, tcolor, false)
			camhack_move_speed = 0.0006
		else
			dxDrawRectangle((x+w)-10, y-5, 10, h+10, tcolor, false)
			camhack_move_speed = 1.0
		end
	end
end

function dxDrawScrollSize_Fast (x, y, w, h, scroll, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(75, 75, 75, 230)
	local tcolor = tocolor(255, 255, 255, 255)
	if scrollMoving then
		tcolor = tocolor(255, 255, 255, 255)
	end
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	local tcolortext =  tocolor(255, 255, 255)
	dxDrawText(text, x + 8, y, w + x, h + y, tcolortext, 1, "default-bold", "center", "center", true, false, false, true)
	if scroll >= x and scroll <= (x+w)-10 then
		dxDrawRectangle(scroll, y-5, 10, h+8, tcolor, false)
		scrollProcent = ((scroll-x)/w)*18
		local size = math.floor(scrollProcent)
		if size >= tonumber(17) then size = 17 end 
		camhack_fast_speed = size
	else
		if scroll <= x then
			dxDrawRectangle(x, y-5, 10, h+10, tcolor, false)
			camhack_fast_speed = 1
		else
			dxDrawRectangle((x+w)-10, y-5, 10, h+10, tcolor, false)
			camhack_fast_speed = 17
		end
	end
end

function dxDrawCheckbox(x, y, w, h, x1, y1, w1, h1, text, bool, index)
	local mx, my = getMousePos()
	local bgcolor = tocolor(200, 40, 40, 0)
	local tcolor = tocolor(255, 255, 255, 220)
	if box[index] == nil then
		box[index] = {}
		box[index] = 0
	end

	if isPointInRect(mx, my, x1 - 2, y1, w1, h1) then
		if box[index] < 255 then
			box[index] = box[index] + 15
		end

		bgcolor = tocolor(200, 40, 40, box[index])
	else
		if box[index] ~= 0 then
			box[index] = box[index] - 15
		end
		bgcolor = tocolor(200, 40, 40, box[index])
	end
	if bool == true then
		bgcolor = tocolor(200, 40, 40, 255)
	end
	dxDrawRectangle(x1, y1, w1, h1, tocolor(40, 40, 40, 255), false)
	dxDrawRectangle(x1+5, y1+5, w1-10, h1-10, bgcolor, false)
	dxDrawText(text, x, y, w + x, h + y, tcolor, 1, font, "left", "center", true, false, false, true)
end

function dxDrawButton(x, y, w, h, text, index)
	local mx, my = getMousePos()
	local tcolor = tocolor(95, 95, 95, 200)
	if not animMoveStop then
		if animMove then
			openBG = getTickCount()
			animMoveStop = true
			new_w = w
		else
			new_w = w
			tcolor = tocolor(95, 95, 95, 200)
		end
	end
	if tables[index] == nil then
		tables[index] = {}
		tables[index] = 0
	end
	if not tables_action then tables_action = {} end
	if tables_action[index] == nil then
		tables_action[index] = {}
		tables_action[index] = 0
	end

	if isPointInRect(mx, my, x - 2, y, new_w, h) then
		if tables[index] < 255 then
			tables[index] = tables[index] + 15
			if tables[index] >= 255 then
				tables[index] = 255
			end
		end
		bgcolors = tocolor(200, 40, 40, tables[index])
		if tables_action[index] < 5 then
			tables_action[index] = tables_action[index] + 1
		end
	else
		if tables_action[index] ~= 0 then
			tables_action[index] = tables_action[index] - 1
		end
		bgcolors = tocolor(200, 40, 40, tables[index])
	end

	dxDrawRectangle(x, y - tables_action[index], new_w, h + tables_action[index], bgcolor, false)
	dxDrawRectangle(x, y + h, new_w, -tables_action[index], bgcolors, false)
	dxDrawText(text, x, y - tables_action[index], new_w + x, h + y, tcolor, 1, font_text, "center", "center", true, false, false, true)
end

function dxDrawButtonMenu(x, y, w, h, text, index)
	local mx, my = getMousePos()
	local tcolor = tocolor(95, 95, 95, 200)
	if not animMoveStop then
		if animMove then
			openBG = getTickCount()
			animMoveStop = true
			new_w = w
		else
			new_w = w
			tcolor = tocolor(95, 95, 95, 200)
		end
	end
	if tables[index] == nil then
		tables[index] = {}
		tables[index] = 0
	end
	if not tables_action then tables_action = {} end
	if tables_action[index] == nil then
		tables_action[index] = {}
		tables_action[index] = 0
	end

	if isPointInRect(mx, my, x - 2, y, new_w, h) then
		if tables[index] < 255 then
			tables[index] = tables[index] + 15
			if tables[index] >= 255 then
				tables[index] = 255
			end
		end
		bgcolors = tocolor(200, 40, 40, tables[index])
		if tables_action[index] < 5 then
			tables_action[index] = tables_action[index] + 1
		end
	else
		if tables_action[index] ~= 0 then
			tables_action[index] = tables_action[index] - 1
		end
		bgcolors = tocolor(200, 40, 40, tables[index])
	end

	dxDrawRectangle(x, y - tables_action[index], new_w, h + tables_action[index], bgcolor, false)
	dxDrawRectangle(x, y + h, new_w, -tables_action[index], bgcolors, false)
	dxDrawText(text, x, y - tables_action[index], new_w + x, h + y, tcolor, 1, font_text, "center", "center", true, false, false, true)
end

function dxDrawRoute(x, y, w, h, text, index)
	local mx, my = getMousePos()
	local new_w_1 = interpolateBetween(0, 0, 0, w, 0, 0, ((getTickCount() - openBG) / 500), "Linear")
	local talpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - openBG) / 900), "Linear")
	local tcolor = tocolor(95, 95, 95, talpha)
	if tables_1[index] == nil then
		tables_1[index] = {}
		tables_1[index] = 0
	end
	if not tables_2 then tables_2 = {} end
	if tables_2[index] == nil then
		tables_2[index] = {}
		tables_2[index] = x
	end

	if isPointInRect(mx, my, x - 2, y, w, h) then
		if tables_1[index] < 255 then
			tables_1[index] = tables_1[index] + 15
			if tables_1[index] >= 255 then
				tables_1[index] = 255
			end
		end
		bgcolors = tocolor(200, 40, 40, tables_1[index])
		if tables_2[index] < (x + 5) then
			tables_2[index] = tables_2[index] + 1
		end
	else
		if tables_1[index] ~= 0 then
			tables_1[index] = tables_1[index] - 15
		end
		if tables_2[index] > x then
			tables_2[index] = tables_2[index] - 1
			if tables_2[index] <= (x) then
				tables_2[index] = x
			end
		end
		bgcolors = tocolor(200, 40, 40, tables_1[index])
	end

	dxDrawRectangle(tables_2[index], y, new_w_1, h, bgcolor, false)
	dxDrawRectangle(tables_2[index], y, 5, h, bgcolors, false)
	dxDrawText(text, tables_2[index], y, new_w_1 + x, h + y, tcolor, 1, font_text, "center", "center", true, false, false, true)
end

function dxDrawWindow(x, y, w, h, text)
	local mx, my = getMousePos()
	local bgcolor = tocolor(175, 175, 175, 225)
	local tcolor = tocolor(255, 255, 255, 255)
	dxDrawRectangle(x, y, w, h, bgcolor, false)
	--dxDrawImage(x, y - 75, width, height, logo, 0, 0, 0, tocolor(255, 255, 255, 255))
	dxDrawText(text, x + (w / 3), y + 10, w + x - 8, 30 + y, tcolor, 1, font_text, "left", "center", true, false, false, true)
end

function isPointInRect(x, y, rx, ry, rw, rh)
	if x >= rx and y >= ry and x <= rx + rw and y <= ry + rh then
		return true
	else
		return false
	end
end

function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function getMousePos()
	local xsc, ysc = guiGetScreenSize()
	local mx, my = getCursorPosition()
	if not mx or not my then
		mx, my = 0, 0
	end
	return mx * xsc, my * ysc
end

function wrapAngle(value)
	if not value then
		return 0
	end
	value = math.mod(value, 360)
	if value < 0 then
		value = value + 360
	end
	return value
end

function wrapAngleRadians(value)
	if not value then
		return 0
	end
	local pi2 = math.pi * 2
	value = math.mod(value, pi2)
	if value < 0 then
		value = value + pi2
	end
	return value
end

function differenceBetweenAngles(firstAngle, secondAngle)
	local difference = secondAngle - firstAngle
	if difference > 180 then
		difference = difference - 360
	elseif difference < -180 then
		difference = difference + 360
	end
	return difference
end

function differenceBetweenAnglesRadians(firstAngle, secondAngle)
	local difference = secondAngle - firstAngle
	if difference > math.pi then
		difference = difference - math.pi * 2
	elseif difference < -math.pi then
		difference = difference + math.pi * 2
	end
	return difference
end