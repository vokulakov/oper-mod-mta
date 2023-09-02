Utils = {}

function Utils.dxDrawText(text, x, y, w, h, color, size, font, left, top)
	return dxDrawText(text, x, y, x + w, y + h, color, size, font, left, top, false, false, false, true)
end

-- TODO:: вынести в lmxUtils
-- Если делать по типу спидометра (чтобы число было белым, а нули прозрачным),
-- то нужно искать первое вхождение числа отличного от нуля (слева)
--[[
function Utils.stringFormatMoney(money)
    local strMoney = string.format("%09d", money)
	local left, num, right = string.match(strMoney, '^([^%d]*%d)(%d*)(.-)')

	local formated = left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())

	local pos = formated:find('[1-9]') or 0
	local left = pos > 0 and formated:sub(0, pos-1) or formated:sub(0, formated:len() - 1)
	local right = pos > 0 and formated:sub(pos) or "0"

	return "#262626"..left.."#ffffff"..right
end
]]

function Utils.convertNumber(number)
	local formatted = number
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
		if (k == 0) then
			break
		end
	end
	return formatted
end

function Utils.dxGetTextExtent(text, font)
    local TEST_TEXT = guiCreateLabel(0, 0, 0, 0, text, false)
	guiSetFont(TEST_TEXT, font)

	local WIDTH = guiLabelGetTextExtent(TEST_TEXT)
	destroyElement(TEST_TEXT)

    return WIDTH
end