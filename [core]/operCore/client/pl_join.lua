addEventHandler('onClientPlayerJoin', root,
	function()
		outputChatBox(' #FF0000' .. getPlayerName(source) .. ' #FFFFFFподтянулся к игре.', 255, 100, 100,true)
	end
)

addEventHandler('onClientPlayerChangeNick', root,
	function(oldNick, newNick)
		outputChatBox('#FFFFFFИгрок #FF0000' .. oldNick .. ' #FFFFFFсменил ник на #FF0000' .. newNick, 255, 100, 100,true)
	end
)

addEventHandler('onClientPlayerQuit', root,
	function(reason)
		outputChatBox(' #FF0000' .. getPlayerName(source) .. ' #FFFFFFсплавился из игры. #FF0000[Причина: ' .. reason .. ']', 255, 100, 100,true)
	end
)

addEventHandler("onClientResourceStart", resourceRoot, function()
	-- Скрытие чата
	showChat(false) 
	-- Скрытие HUD
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)

	-- Отключение размытия при движении
	setBlurLevel(0)
	-- Отключение скрытия объектов
	setOcclusionsEnabled(false)
	-- Отключение фоновых звуков стрельбы
	setWorldSoundEnabled(5, false)
	-- Отключение клавиатуры
	toggleAllControls(false, true, true)
end)