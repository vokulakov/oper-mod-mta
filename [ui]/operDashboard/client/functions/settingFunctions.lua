Functions = {}

local g_TimeFreezeTimer = {}

function Functions.setFarClipDistance(value)
	setFarClipDistance(value)
end

function Functions.changeWeather(weather, blend)

	if not blend then
		return setWeather(weather)
	end

	local currentW, nextW = getWeather()

	if nextW ~= nil then
		setWeather(currentW)
	end

	setWeatherBlended(weather)
end

local function setWeatherCommand(cmd, weather)
	weather = weather and tonumber(weather)
	if weather then
		Functions.changeWeather(weather)
	end
end
addCommandHandler('setweather', setWeatherCommand)
addCommandHandler('sw', setWeatherCommand)

function Functions.changeTime(hour, minute)

	if isTimer(g_TimeFreezeTimer) then -- если заморожено время
		Functions.toggleFreezeTime(false)
		setTime(hour, minute)
		Functions.toggleFreezeTime(true)
		return
	end

	setTime(hour, minute)
end

local function setTimeCommand(cmd, hours, minutes)
	if not hours then
		return
	end
	local curHours, curMinutes = getTime()
	hours = tonumber(hours) or curHours
	minutes = minutes and tonumber(minutes) or curMinutes

	Functions.changeTime(hours, minutes)
end
addCommandHandler('settime', setTimeCommand)
addCommandHandler('st', setTimeCommand)

function Functions.refreshTime()
	local TIMER = getRealTime()
	setTime(TIMER.hour, TIMER.minute)
	setMinuteDuration(10000)
end

function Functions.toggleFreezeTime(state)
	if state then
		if not isTimer(g_TimeFreezeTimer) then
			local hour, minute = getTime()
			local currentW, nextW = getWeather()
		
			g_TimeFreezeTimer = setTimer(function() 
				setTime(hour, minute) 
				setWeather(currentW) 
			end, 5000, 0)
			
			setMinuteDuration(60000)
		end
	else
		if isTimer(g_TimeFreezeTimer) then
			killTimer(g_TimeFreezeTimer)
			g_TimeFreezeTimer = nil
		end

		setMinuteDuration(10000)
	end
end
