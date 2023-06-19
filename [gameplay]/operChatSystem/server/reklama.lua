local REKLAMA_INTERVAL = 60 -- в минутах

setTimer(function ()
	for i = 1, 20 do
		outputChatBox(" ", root, 255, 255, 255, true)
	end

	outputChatBox("#00b9ff*** Вы играете на проекте #ffffffOPERSKIY OTDEL", root, 255, 255, 255, true)
	outputChatBox("#00b9ff*** Наша официальная страница #ffffffvk.com/otdelmta #00b9ffприсоединяйся!", root, 255, 255, 255, true)
	outputChatBox("#d43422*** Администрация проекта желает вам приятной игры!", root, 255, 255, 255, true)
	outputChatBox("#ffffff*** Зови друзей, вместе веселей!!!", root, 255, 255, 255, true)

end, REKLAMA_INTERVAL * 60 * 1000, 0)