local drawButtons = { }

function drawHelpButton(x, y, w, text, font_scale, alpha, button, b_size)
	local TEXT_FONT = guiCreateFont('assets/fonts/Roboto-Regular.ttf', font_scale)--exports["queenFonts"]:createFontGUI("Roboto-Regular.ttf", font_scale)
	local b_size = b_size or 26
	-- РАСЧЕТ РАЗМЕРОВ
	local TEST_TEXT = guiCreateLabel(x, y, w, 26, text, false)
	guiSetFont(TEST_TEXT, TEXT_FONT)
	local WIDTH, HEIGHT = guiLabelGetTextExtent(TEST_TEXT), guiLabelGetFontHeight(TEST_TEXT)
	destroyElement(TEST_TEXT)

	-- ЦЕНТРАЛЬНАЯ ПАНЕЛЬ
	local HELP_PANEL = guiCreateStaticImage(x, y, WIDTH+5+b_size, HEIGHT+10, "assets/img/panel/pane.png", false)
	guiSetProperty(HELP_PANEL, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_PANEL, alpha)
	guiSetEnabled(HELP_PANEL, false)

	-- ЛЕВЫЙ КРАЙ
	local HELP_LEFT_UP = guiCreateStaticImage(x-6, y, 6, 6, "assets/img/panel/round_1.png", false)
	guiSetProperty(HELP_LEFT_UP, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_LEFT_UP, alpha)
	setElementParent(HELP_LEFT_UP, HELP_PANEL)

	local HELP_LEFT_CENTER = guiCreateStaticImage(x-6, y+6, 6, HEIGHT-2, "assets/img/panel/pane.png", false)
	guiSetProperty(HELP_LEFT_CENTER, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_LEFT_CENTER, alpha)
	setElementParent(HELP_LEFT_CENTER, HELP_PANEL)

	local HELP_LEFT_DOWN = guiCreateStaticImage(x-6, y+10+HEIGHT-6, 6, 6, "assets/img/panel/round_4.png", false)
	guiSetProperty(HELP_LEFT_DOWN, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_LEFT_DOWN, alpha)
	setElementParent(HELP_LEFT_DOWN, HELP_PANEL)

	-- ПРАВЫЙ КРАЙ
	local HELP_RIGHT_UP = guiCreateStaticImage(x+WIDTH+b_size+5, y, 6, 6, "assets/img/panel/round_2.png", false)
	guiSetProperty(HELP_RIGHT_UP, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_RIGHT_UP, alpha)
	setElementParent(HELP_RIGHT_UP, HELP_PANEL)

	local HELP_RIGHT_CENTER = guiCreateStaticImage(x+WIDTH+b_size+5, y+6, 6, HEIGHT-2, "assets/img/panel/pane.png", false)
	guiSetProperty(HELP_RIGHT_CENTER, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_RIGHT_CENTER, alpha)
	setElementParent(HELP_RIGHT_CENTER, HELP_PANEL)

	local HELP_RIGHT_DOWN = guiCreateStaticImage(x+WIDTH+b_size+5, y+10+HEIGHT-6, 6, 6, "assets/img/panel/round_3.png", false)
	guiSetProperty(HELP_RIGHT_DOWN, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(HELP_RIGHT_DOWN, alpha)
	setElementParent(HELP_RIGHT_DOWN, HELP_PANEL)

	-- ТЕКСТ
	local HELP_TEXT = guiCreateLabel(x, y+5, WIDTH, HEIGHT, text, false)
	guiLabelSetHorizontalAlign(HELP_TEXT, "center")
	guiSetFont(HELP_TEXT, TEXT_FONT)
	setElementParent(HELP_TEXT, HELP_PANEL)
	
	-- КНОПКА
	if button ~= "" then
		local HELP_BUTTON = guiCreateStaticImage(WIDTH+5, HEIGHT/2-13+5, b_size, 26, "assets/img/buttons/"..button..".png", false, HELP_PANEL)
		guiSetEnabled(HELP_BUTTON, false)
	end

	drawButtons[HELP_PANEL] = HELP_PANEL

	return HELP_PANEL
end


addEventHandler("onClientElementDestroy", root, function()
	if source.type == 'gui-staticimage' then
		--local elements = getElementChildren(source)
		if drawButtons[source] then
			drawButtons[source] = nil
		end
	end
end)

local drawRectangles = {}

function drawRectangle(x, y, w, h, alpha, round)
	local RECTANGLE_PANEL = guiCreateStaticImage(x, y, w, h, 'assets/img/panel/pane.png', false)
	guiSetProperty(RECTANGLE_PANEL, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
	guiSetAlpha(RECTANGLE_PANEL, alpha)
	guiSetEnabled(RECTANGLE_PANEL, false)

	if round then
		-- ЛЕВЫЙ КРАЙ
		local RECTANGLE_LEFT_UP = guiCreateStaticImage(x-6, y, 6, 6, 'assets/img/panel/round_1.png', false)
		guiSetProperty(RECTANGLE_LEFT_UP, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
		guiSetAlpha(RECTANGLE_LEFT_UP, alpha)
		setElementParent(RECTANGLE_LEFT_UP, RECTANGLE_PANEL)

		local RECTANGLE_LEFT_CENTER = guiCreateStaticImage(x-6, y+6, 6, h-12, 'assets/img/panel/pane.png', false)
		guiSetProperty(RECTANGLE_LEFT_CENTER, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
		guiSetAlpha(RECTANGLE_LEFT_CENTER, alpha)
		setElementParent(RECTANGLE_LEFT_CENTER, RECTANGLE_PANEL)

		local RECTANGLE_LEFT_DOWN = guiCreateStaticImage(x-6, y+h-6, 6, 6, 'assets/img/panel/round_4.png', false)
		guiSetProperty(RECTANGLE_LEFT_DOWN, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
		guiSetAlpha(RECTANGLE_LEFT_DOWN, alpha)
		setElementParent(RECTANGLE_LEFT_DOWN, RECTANGLE_PANEL)

		-- ПРАВЫЙ КРАЙ
		local RECTANGLE_RIGHT_UP = guiCreateStaticImage(x+w, y, 6, 6, 'assets/img/panel/round_2.png', false)
		guiSetProperty(RECTANGLE_RIGHT_UP, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
		guiSetAlpha(RECTANGLE_RIGHT_UP, alpha)
		setElementParent(RECTANGLE_RIGHT_UP, RECTANGLE_PANEL)

		local RECTANGLE_RIGHT_CENTER = guiCreateStaticImage(x+w, y+6, 6, h-12, 'assets/img/panel/pane.png', false)
		guiSetProperty(RECTANGLE_RIGHT_CENTER, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
		guiSetAlpha(RECTANGLE_RIGHT_CENTER, alpha)
		setElementParent(RECTANGLE_RIGHT_CENTER, RECTANGLE_PANEL)

		local RECTANGLE_RIGHT_DOWN = guiCreateStaticImage(x+w, y+h-6, 6, 6, 'assets/img/panel/round_3.png', false)
		guiSetProperty(RECTANGLE_RIGHT_DOWN, "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
		guiSetAlpha(RECTANGLE_RIGHT_DOWN, alpha)
		setElementParent(RECTANGLE_RIGHT_DOWN, RECTANGLE_PANEL)
	end

	drawRectangles[RECTANGLE_PANEL] = RECTANGLE_PANEL

	return RECTANGLE_PANEL
end

function setRectangleSize(rectangle, width, height)
	local elements = getElementChildren(rectangle)
	local rectangle_x, rectangle_y = guiGetPosition(rectangle, false)
	local rectangle_w, rectangle_h = guiGetSize(rectangle, false)
	guiSetSize(rectangle, width, height, false)
	for k, v in ipairs(elements) do
		if getElementType(v) == 'gui-staticimage' then
			local element_x, element_y = guiGetPosition(v, false)
			if tonumber(rectangle_x + rectangle_w) == tonumber(element_x) then
				guiSetPosition(v, rectangle_x + width, element_y, false)
			end
		end
	end
end

addEventHandler("onClientElementDestroy", root, function()
	if source.type == 'gui-staticimage' then
		--local elements = getElementChildren(source)
		if drawRectangles[source] then
			drawRectangles[source] = nil
		end
	end
end)

--[[
local sWidth, sHeight = guiGetScreenSize()

local HELP_PANEL = drawRectangle(sWidth-525, sHeight-70, 515, 30, 0.7, true)

local HELP_MOVE_L = drawHelpButton(sWidth-520, sHeight-70, 0, "Режим просмотра", 10, 0, "mouse_right")
setElementParent(HELP_MOVE_L, HELP_PANEL)

local HELP_MOVE_L = drawHelpButton(sWidth-365, sHeight-70, 0, "Вращать камеру", 10, 0, "mouse")
setElementParent(HELP_MOVE_L, HELP_PANEL)

local HELP_MOVE_L = drawHelpButton(sWidth-225, sHeight-70, 0, "Отдалить/приблизить камеру", 10, 0, "mouse_wheel")
setElementParent(HELP_MOVE_L, HELP_PANEL)
]]