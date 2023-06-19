addEventHandler('onPlayerLogin', root, function( _, account)
    local accName = getAccountName(account)

    local result = Accounts.getData(account)
  	
  	if result == nil then -- если нет данных об аккаунте, то создается запись
  		Accounts.addAccount(source, accName)
  		exports.operLogger:log("auth", string.format("New user registered: '%s' (%s)", accName, tostring(source.name)))
  	end

    -- Обновить данные об аккаунте
	Accounts.updateLastseen(source, accName, 1)

	-- Данные аккаунта
	local accountData = Accounts.getData(account) or { }

    if not accountData.playtime then 
    	accountData.playtime = 0 
    end

    source:setData('player.playtime', accountData.playtime)

    source:setData('player.accountData', accountData)

    -- Logger
    exports.operLogger:log("auth", string.format("User login: '%s' (%s)", accName, tostring(source.name)))
end)

addEventHandler('onPlayerQuit', root, function()
	local account = getPlayerAccount(source)

	if not account then
		return
	end

	local accName = getAccountName(account)

	Accounts.updateLastseen(source, accName, 0)
	Accounts.saveAccount(source)

    exports.operLogger:log("auth", string.format("User '%s' has logged out (%s)", accName, tostring(source.name)))
end)

addEventHandler("onPlayerChangeNick", root, function(oldNick, newNick, changedByPlayer) -- log смена ника
	if not changedByPlayer then
		return
	end

	exports.operLogger:log("nicknames", ("Player %s changed nickname to %s"):format(tostring(oldNick), tostring(newNick)), true)
end)

setTimer(function()
	for i, player in ipairs(getElementsByType("player")) do
		local currentPlaytime = tonumber(player:getData("player.playtime"))

		if currentPlaytime then
			player:setData("player.playtime", currentPlaytime + 1)
		end
	end
end, 60000, 0)