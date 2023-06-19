local function setWorldTime()
	local TIME = getRealTime()
	setTime(TIME.hour, TIME.minute)
    setMinuteDuration(10000)
end
addEventHandler('onResourceStart', resourceRoot, setWorldTime)
