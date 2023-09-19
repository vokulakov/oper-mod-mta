local INFORMATIONS = {
	-- Сообщения с подсказами по игровому моду
	"Сообщение в локальный чат можно писать на клавишу #ffd600Y",
	"Скрыть/показать подсказки управления можно на клавишу #ffd600F5",
	"Улучшения графики доступны в меню настроек на клавишу #ffd600F6",
	"Телепорт по карте доступен на клавишу #ffd600F11",
	"Скрыть/показать интерфейс на клавишу #ffd600F4",
	"Меню помощи по серверу доступно на клавишу #ffd600F9",
	"Фоторежим (camhack) активируется в меню #ffd600F1",
	"Стробоскопы активируются на клавишу #ffd600G",
	"Воспроизвести звуковой фрагмент (по умолчанию) на клавишу #ffd600X",
	"Вид от первого лица (selfie-режим) активируется на клавишу #ffd600U",
	"Чип-тюнинг транспорта доступен на клавишу #ffd600B",
	"Онлайн-радио в транспорте доступно на клавиши #ffd6004 #ffffffи #ffd6005",
	"Тюнинг транспорта доступен в меню #ffd600F3",
	"Управление транспортом осуществляется в меню #ffd600F2"
}

-- Основной блок рекламы (каждые 60 минут)
setTimer(function()
	for i = 1, 20 do
		outputChatBox(" ", root, 255, 255, 255, true)
	end

	outputChatBox("#ffffff*** Вы играете на проекте #ffd600OPERSKIY × OTDEL", root, 255, 255, 255, true)
	outputChatBox("#ffffff*** Наш сайт: #ffd600opermta.ru", root, 255, 255, 255, true)
	outputChatBox("#ffffff*** Официальная страница: #ffd600vk.com/otdelmta", root, 255, 255, 255, true)
	outputChatBox("#ffffff*** Администрация проекта желает вам приятной игры #ffd600;)", root, 255, 255, 255, true)

end, 60 * 60 * 1000, 0)

-- Реклама сайта (каждые 20 минут)
setTimer(function()
	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox("#00b9ff[Информация] #ffffffНаш сайт: #ffd600opermta.ru", root, 255, 255, 255, true)
	outputChatBox("#00b9ff[Информация] #ffffffПриобретай #ffd600привилегии #ffffffсо скидкой до #ff000050%", root, 255, 255, 255, true)
	outputChatBox("#00b9ff[Информация] #ffffffИспользуй купон: #ffd600OTDEL15", root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)
end, 20 * 60 * 1000, 0)

-- Рандомные сообщения с подсказками
function outputRandomInfo()
	outputChatBox(" ", root, 255, 255, 255, true)
	outputChatBox("#00b9ff[Информация] #ffffffОфициальная страница: #ffd600vk.com/otdelmta", root, 255, 255, 255, true)
	outputChatBox("#00b9ff[Информация] #ffffff"..INFORMATIONS[math.random(1,#INFORMATIONS)], root, 255, 255, 255, true)
	outputChatBox(" ", root, 255, 255, 255, true)
	setTimer(outputRandomInfo, math.random(5,10) * 60 * 1000, 1)
end
setTimer(outputRandomInfo, math.random(5,10) * 60 * 1000, 1)