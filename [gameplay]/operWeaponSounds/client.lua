--------------
--by MazzMan
--------------

local distance = 75 --distance from where you can hear the shot
local explostionDistance = 150

local cSoundsEnabled = true
local reloadSoundEnabled = true
local explosionEnabled = true

--shoot sounds
function playSounds(weapon, ammo, ammoInClip)
	if(cSoundsEnabled)then
		local x,y,z = getElementPosition(source)
		if weapon == 22 then --pistol
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/pistole.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/pistole.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 30 or weapon == 29 then --ak
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/ak.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/ak.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), playSounds)

--reload sounds
function mgReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	end, 1250, 1)
end

function pistolReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/pistol_reload.wav", x,y,z)
	end, 500, 1)
end


--explosion sounds
addEventHandler("onClientExplosion", getRootElement(), function(x,y,z, theType)
	if(explosionEnabled)then
		if(theType == 4 or theType == 5 or theType == 6 or theType == 7)then --car, car quick, boat, heli
			local explSound = playSound3D("sounds/explosion/explosion3.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		end
	end
end)






