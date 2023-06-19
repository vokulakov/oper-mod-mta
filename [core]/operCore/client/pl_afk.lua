local AFK_TIMER 
local AFK_TIMEOUT = 5

local function msToTimeStr(ms)
	if not ms then
		return ''
	end
	
	if ms < 0 then
		return "0","00","00"
	end
	
	local centiseconds = tostring(math.floor(math.fmod(ms, 1000)/10))
	if #centiseconds == 1 then
		centiseconds = '0' .. centiseconds
	end
	local s = math.floor(ms / 1000)
	local seconds = tostring(math.fmod(s, 60))
	if #seconds == 1 then
		seconds = '0' .. seconds
	end
	local minutes = tostring(math.floor(s / 60))
	
	return minutes, seconds, centiseconds
end

local function startTimer()

	if getElementData(localPlayer, "player.AFK") then
		return
	end
	
	setElementData(localPlayer, "player.AFK", true)

	local s = 0

	AFK_TIMER = setTimer(function()
		s = s + 1000
		local m, s, c =  msToTimeStr(s)
		local time = tostring(m..":"..s)
		if tonumber(m) > 60 then
			time = tostring('60:00+')
		end

		setElementData(localPlayer, "player.AFK_TIMER", time)
	end, 1000, 0)
end

local function stopTimer()
	setElementData(localPlayer, "player.AFK", false)
	if isTimer(AFK_TIMER) then 
		killTimer(AFK_TIMER)
		setElementData(localPlayer, "player.AFK_TIMER", '0:00')
	end
end

addEventHandler("onClientMinimize", root, function() -- свернул игру
	startTimer()
end)

addEventHandler("onClientRestore", root, function() -- развернул игру
	stopTimer()
end)

local afkTimer

local function resetTimer()
	if isTimer(afkTimer) then
		killTimer(afkTimer)
		stopTimer()
	end

	afkTimer = setTimer(startTimer, 1000 * 60 * AFK_TIMEOUT, 1)
end

addEventHandler("onClientCursorMove", root, resetTimer)
addEventHandler("onClientKey", root, resetTimer)
addEventHandler("onClientClick", root, resetTimer)
