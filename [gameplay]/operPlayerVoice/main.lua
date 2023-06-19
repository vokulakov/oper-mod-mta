Voice = {}

local SoundPlayers = {}

function Voice.playSound(player, sound_src)
	if not isElement(player) then
		return
	end

	if SoundPlayers[player] then 
		if isElement(SoundPlayers[player].sound) then
			stopSound(SoundPlayers[player].sound)
		end

		SoundPlayers[player] = nil
	end

	SoundPlayers[player] = {}

	local x, y, z = getElementPosition(player)
	SoundPlayers[player].sound = playSound3D(sound_src, x, y, z)
	setSoundVolume(SoundPlayers[player].sound, 1.3)
	setSoundMaxDistance(SoundPlayers[player].sound, 70) 
	attachElements(SoundPlayers[player].sound, player)

	-- TODO: нужно проверять, закончился трек или нет (если запускается новый трек, то останавливать прошлый)

	setTimer(
		function(player)

			localPlayer:setData('lmxPlayerVoice.isPlayerSound', false)
		end, 3000, 1, player)
end

function Voice.playerPlaySound(sound_src)
	if localPlayer:getData('lmxPlayerVoice.isPlayerSound') then
		triggerEvent('operNotification.addNotification', localPlayer, "Что ты раскричался то?\nПодожди немного :)", 2, true)
		return
	end
	localPlayer:setData('lmxPlayerVoice.isPlayerSound', sound_src)
end

addEventHandler("onClientElementDataChange", root, function(data, _, sound_src)
	if not getElementType(source) == "player" then 
		return 
	end
	
	if data == 'lmxPlayerVoice.isPlayerSound' and type(sound_src) == 'string' then
		if not isElementStreamedIn(source) then 
			return 
		end
		
		Voice.playSound(source, sound_src)
	end 

end)

bindKey(Config.key, 'both', function(_, state)
	if state ~= 'down' or getKeyState("LSHIFT") then 
		return
	end

	Voice.playerPlaySound(Config.default_sound)
end)
