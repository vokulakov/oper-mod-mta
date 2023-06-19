local sx, sy = guiGetScreenSize()

local function drawInfo()
	dxDrawRectangle(sx/2-480/2, sy/2-200/2, 480, 200, tocolor(0, 0, 0, 200))
	dxDrawText("Приветствуем вас на проекте - OPERSKIY #21b1ffOTDEL#ffffff!\n\n#F01A21ВНИМАНИЕ\n\n#ffffffСпешим сообщить, что сервер находится на стадии #F01A21разработки#ffffff.\nНа текущий момент игровая модификация имеет #F01A21ограниченный функционал#ffffff,\nпоэтому мы не можем предоставить полноценную игровую площадку\nдля наведения оперской суеты #F01A21:(\n\n#ffffffАктуальная информация и новости проекта - #21b1ffvk.com/otdelmta\n#ffffffС уважением, #F01A21администрация проекта.", 0, 0, sx, sy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", nil, nil, nil, true)
end

local function showLoadingScreen()
	--[[
	-- Настройки
	showChat(false) -- скрытие чата
	setPlayerHudComponentVisible ("all", false) -- скрытие HUD
	setBlurLevel(0) -- отключение размытия при движении
	setOcclusionsEnabled(false) -- отключение скрытия объектов
	setWorldSoundEnabled(5, false) -- отключение фоновых звуков стрельбы
	toggleAllControls(false, true, true)
	]]
	fadeCamera(true, 5)
	setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)

	--message = guiCreateLabel(0, sy-300, sx, sy, "Пожалуйста дождитесь загрузки игрового мода", false)
	--guiSetEnabled(message, false)

	--guiLabelSetHorizontalAlign(message, "center")
	--addEventHandler('onClientRender', root, drawInfo)
end
addEventHandler("onClientResourceStart", resourceRoot, showLoadingScreen)




addEvent('operLoadingScreen.destroyLoadingScreen', true)
addEventHandler('operLoadingScreen.destroyLoadingScreen', root, function()
	--removeEventHandler('onClientRender', root, drawInfo)
end)