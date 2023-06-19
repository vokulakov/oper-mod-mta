setDevelopmentMode(true)

local isSound 

local function playGatesSound(isOpen)

	if isElement(isSound) then
		stopSound(isSound)
		isSound = nil
	end

	local url = 'assets/door_open.mp3'

	if not isOpen then 
		url = 'assets/door_close.mp3'
	end

	isSound = playSound3D(url, 963.5, 1783.2, 7.9000000953674)
	setSoundMaxDistance(isSound, 50)
	setSoundVolume(isSound, 1.5)
end	
addEvent('operOtdelGates.playGatesSound', true)
addEventHandler('operOtdelGates.playGatesSound', root, playGatesSound)