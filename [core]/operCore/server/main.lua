addEventHandler("onResourceStart", resourceRoot, function()
	if not Database.connect() then -- подключаем Базу Данных (SQL)
		outputDebugString("ERROR: Database connection failed")
		return
	end

	outputDebugString("Database connection success")
	outputDebugString("Creating and setting up tables...")

	Accounts.setup()

	setElementData(root, 'operServerMaxPlayers', getMaxPlayers())
end)

addEventHandler("onResourceStop", resourceRoot, function()

	-- Сохранение данных в момент выключения мода
	for i, player in ipairs(getElementsByType("player")) do
        Accounts.saveAccount(player)
    end

    Database.disconnect()
end)