--[[
	aRed: количество красного (0-255).
aЗеленый: количество зеленого (0-255).
aСиний: количество синего (0-255).
aAlpha: количество альфа (0-255).
bRed: количество красного (0-255).
bЗеленый: количество зеленого (0-255).
bСиний: количество синего (0-255).
bAlpha: количество альфа (0-255).
]]


-- https://libertycity.ru/files/gta-san-andreas/134097-real-linear-graphics-v2.0.2.html
-- https://sampik.ru/asi-lua-sf/1266-24h-timecycle-24-chasa-timecycdat.html
-- https://sampik.ru/gaydy-i-faq/892-chto-takoe-timecycdat.html

-- 65 65 65 255

local aRed = 65
local aGreen = 65
local aBlue = 65
local aAlpha = 255

local bRed = 0
local bGreen = 64
local bBlue = 146
local bAlpha = 64


setColorFilter(aRed, aGreen, aBlue, aAlpha, bRed, bGreen, bBlue, bAlpha)

function disableFilter()
	resetColorFilter()
end
 
addCommandHandler("off", disableFilter) -- Add the command

setCoronaReflectionsEnabled(2)

-- https://wiki.multitheftauto.com/wiki/SetWaterColor
-- https://wiki.multitheftauto.com/wiki/SetSkyGradient
-- https://wiki.multitheftauto.com/wiki/SetFarClipDistance
-- https://wiki.multitheftauto.com/wiki/SetFogDistance

