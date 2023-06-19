local url = "assets/sound_airhorn.wav"

function playTheSound(x, y, z, vehicle)
	sound = playSound3D(url, x, y, z)
	setSoundMaxDistance(sound, 40)
	setSoundVolume(sound, 1.5)
	if (isElement(vehicle)) then attachElements(sound, vehicle) end
end
addEvent("playTheSound", true)
addEventHandler("playTheSound", root, playTheSound)

local url2 = "assets/sound_siren.wav"

function playTheSound2(x, y, z, vehicle)
	sound = playSound3D(url2, x, y, z)
	setSoundMaxDistance(sound, 40)
	setSoundVolume(sound, 1.5)
	if (isElement(vehicle)) then attachElements(sound, vehicle) end
end
addEvent("playTheSound2", true)
addEventHandler("playTheSound2", root, playTheSound2)

local url3 = "assets/sound_siren2.wav"

function playTheSound3(x, y, z, vehicle)
	sound = playSound3D(url3, x, y, z)
	setSoundMaxDistance(sound, 40)
	setSoundVolume(sound, 1.5)
	if (isElement(vehicle)) then attachElements(sound, vehicle) end
end
addEvent("playTheSound3", true)
addEventHandler("playTheSound3", root, playTheSound3)

local url4 = "assets/sound_manual.wav"

function playTheSound4(x, y, z, vehicle)
	sound = playSound3D(url4, x, y, z)
	setSoundMaxDistance(sound, 40)
	setSoundVolume(sound, 1.5)
	if (isElement(vehicle)) then attachElements(sound, vehicle) end
end
addEvent("playTheSound4", true)
addEventHandler("playTheSound4", root, playTheSound4)

function stopTheSound()
	if isElement(sound) then
		stopSound(sound)
	end
end
addEvent("stopTheSound", true)
addEventHandler("stopTheSound", root, stopTheSound)

function stopTheSound2()
	if isElement(sound) then
		stopSound(sound)
	end
end
addEvent("stopTheSound2", true)
addEventHandler("stopTheSound2", root, stopTheSound2)

function stopTheSound3()
	if isElement(sound) then
		stopSound(sound)
	end
end
addEvent("stopTheSound3", true)
addEventHandler("stopTheSound3", root, stopTheSound3)

function stopTheSound4()
	if isElement(sound) then
		stopSound(sound)
	end
end
addEvent("stopTheSound4", true)
addEventHandler("stopTheSound4", root, stopTheSound4)