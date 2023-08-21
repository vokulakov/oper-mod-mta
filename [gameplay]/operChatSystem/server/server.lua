local TIMER = { }

addCommandHandler("Сообщение", function(thePlayer, cmd, ...)
	local message = table.concat ( { ... }, " " )

	if message:find("^/%a") ~= nil then
		return startCommandServer(string.gsub(message, "(/)", ""), thePlayer)
	end

	if message == "" then
		return
	end

	local tag = getPlayerTag(thePlayer)

	message = WordsFilter.filter(message)
	
	if AntiFlood.isMuted() or isPlayerMuted(thePlayer) then
		AntiFlood.onMessage()
		triggerClientEvent(thePlayer, 'operNotification.addNotification', thePlayer, 'Тихо - тихо, не флуди!', 2, true)
		return
	end

	local playerName = getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")

	outputChatBox(tag.." #FFFFFF".. playerName .."#FFFFFF: ".. message, root, 255, 255, 255, true)

	exports.operLogger:log("chat", string.format("%s (%s): %s",
		tostring(getPlayerName(thePlayer)),
		tostring(getAccountName(getPlayerAccount(thePlayer))),
		tostring(message))
	)

	AntiFlood.onMessage()
end)

-- ДЛЯ РП 
addCommandHandler("Сказать", function(thePlayer, cmd, ...)
	local message = table.concat({ ... }, " ")

	if message:find("^/%a") ~= nil then
		return startCommandServer(string.gsub(message, "(/)", ""), thePlayer)
	end

	if message == "" then
		return
	end

	local tag = getPlayerTag(thePlayer)

	message = WordsFilter.filter(message)
	
	if AntiFlood.isMuted() or isPlayerMuted(thePlayer) then
		AntiFlood.onMessage()
		triggerClientEvent(thePlayer, 'operNotification.addNotification', thePlayer, 'Тихо - тихо, не флуди!', 2, true)
		return
	end

	local x, y, z = getElementPosition(thePlayer)

	for _, pl in ipairs(getElementsByType("player")) do
		local x2, y2, z2 = getElementPosition(pl)
		if (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 70) then
			local int = getElementInterior(thePlayer)
			local dim = getElementDimension(thePlayer)
			local int2 = getElementInterior(pl)
			local dim2 = getElementDimension(pl)
				
			if (int == int2 and dim == dim2) then
				local playerName = getPlayerName(thePlayer):gsub("#%x%x%x%x%x%x", "")

				outputChatBox(playerName.." #FFFFFFговорит: "..message, pl, 255, 255, 255, true)
			end
		end
	end

	triggerClientEvent('operNameTag.onChatIncome', thePlayer, message)
	
	exports.operLogger:log("chat", string.format("%s (%s): %s",
		tostring(getPlayerName(thePlayer)),
		tostring(getAccountName(getPlayerAccount(thePlayer))),
		tostring(message))
	)

	AntiFlood.onMessage()

	if isTimer(TIMER[thePlayer]) then
		killTimer(TIMER[thePlayer])
	end

	if getPedOccupiedVehicle(thePlayer) or isPedDucked(thePlayer) or thePlayer:getData('player.isAnimation') then
		return
	end

	setPedAnimation(thePlayer, "ped", "IDLE_chat", 3.0, false, true, true)

	TIMER[thePlayer] = setTimer(function(player)
		setPedAnimation(player, "ped", "IDLE_chat", -1, true, false, false, true)

		setTimer(setPedAnimation, 50, 1, thePlayer)
	end, 3000, 1, thePlayer)

end)

function onPlayerChatMe(player, message)
	if message == "" then
		return
	end

	message = WordsFilter.filter(message)
	
	if AntiFlood.isMuted() or isPlayerMuted(player) then
		AntiFlood.onMessage()
		triggerClientEvent(player, 'operNotification.addNotification', player, 'Тихо - тихо, не флуди!', 2, true)
		return
	end

	local x, y, z = getElementPosition(player)

	for _, pl in ipairs(getElementsByType("player")) do
		local x2, y2, z2 = getElementPosition(pl)
		if (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 40) then
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			local int2 = getElementInterior(pl)
			local dim2 = getElementDimension(pl)
				
			if (int == int2 and dim == dim2) then
				local playerName = getPlayerName(player):gsub("#%x%x%x%x%x%x", "")

				outputChatBox("* ".. playerName .."#FFFFFF".. message, pl, 235, 100, 255, true)
			end
		end
	end

	exports.operLogger:log("chat", string.format("%s (%s): %s",
		tostring(getPlayerName(player)),
		tostring(getAccountName(getPlayerAccount(player))),
		tostring(message))
	)

	AntiFlood.onMessage()
end

function onPlayerChatDo(player, message)
	if message == "" then
		return
	end

	message = WordsFilter.filter(message)
	
	if AntiFlood.isMuted() or isPlayerMuted(player) then
		AntiFlood.onMessage()
		triggerClientEvent(player, 'operNotification.addNotification', player, 'Тихо - тихо, не флуди!', 2, true)
		return
	end

	local x, y, z = getElementPosition(player)

	for _, pl in ipairs(getElementsByType("player")) do
		local x2, y2, z2 = getElementPosition(pl)
		if (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 40) then
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			local int2 = getElementInterior(pl)
			local dim2 = getElementDimension(pl)
				
			if (int == int2 and dim == dim2) then
				local playerName = getPlayerName(player):gsub("#%x%x%x%x%x%x", "")

				outputChatBox("*"..message.." ("..playerName.."#FFFFFF)", pl, 235, 100, 255, true)
			end
		end
	end

	exports.operLogger:log("chat", string.format("%s (%s): %s",
		tostring(getPlayerName(player)),
		tostring(getAccountName(getPlayerAccount(player))),
		tostring(message))
	)

	AntiFlood.onMessage()
end

function onPlayerChatToDo(player, message)
	if message == "" then
		return
	end

	message = WordsFilter.filter(message)
	
	if AntiFlood.isMuted() or isPlayerMuted(player) then
		AntiFlood.onMessage()
		triggerClientEvent(player, 'operNotification.addNotification', player, 'Тихо - тихо, не флуди!', 2, true)
		return
	end

	local x, y, z = getElementPosition(player)

	for _, pl in ipairs(getElementsByType("player")) do
		local x2, y2, z2 = getElementPosition(pl)
		if (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 40) then
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			local int2 = getElementInterior(pl)
			local dim2 = getElementDimension(pl)
				
			if (int == int2 and dim == dim2) then

				local count = 0

				for S in string.gmatch(message, "*") do
					count = count + 1
				end

				if count > 1 then
					return
				end

				local two_message = string.sub(message, message:find('*')+1, -1)
				local one_message = string.sub(message, 0, message:find('*')-1)
				local playerName = getPlayerName(player):gsub("#%x%x%x%x%x%x", "")

				outputChatBox("*#58FA58"..one_message.." #eb64ff - сказал: "..playerName.."#FFFFFF,\n* "..two_message, pl, 235, 100, 255, true)

			end
		end
	end

	exports.operLogger:log("chat", string.format("%s (%s): %s",
		tostring(getPlayerName(player)),
		tostring(getAccountName(getPlayerAccount(player))),
		tostring(message))
	)

	AntiFlood.onMessage()
end

function onPlayerChatTry(player, message)
	if message == "" then
		return
	end

	message = WordsFilter.filter(message)
	
	if AntiFlood.isMuted() or isPlayerMuted(player) then
		AntiFlood.onMessage()
		triggerClientEvent(player, 'operNotification.addNotification', player, 'Тихо - тихо, не флуди!', 2, true)
		return
	end

	local x, y, z = getElementPosition(player)

	for _, pl in ipairs(getElementsByType("player")) do
		local x2, y2, z2 = getElementPosition(pl)
		if (getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 40) then
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			local int2 = getElementInterior(pl)
			local dim2 = getElementDimension(pl)
				
			if (int == int2 and dim == dim2) then
				local number = math.random(1,2)
				local playerName = getPlayerName(player):gsub("#%x%x%x%x%x%x", "")

				if number == 1 then
					outputChatBox("* "..playerName.."#FFFFFF"..message.." #FFFFFF(#58FA58удачно#FFFFFF)", pl, 235, 100, 255, true)
				else
					outputChatBox("* "..playerName.."#FFFFFF"..message.." #FFFFFF(#FF0000неудачно#FFFFFF)", pl, 235, 100, 255, true)
				end
			end
		end
	end

	exports.operLogger:log("chat", string.format("%s (%s): %s",
		tostring(getPlayerName(player)),
		tostring(getAccountName(getPlayerAccount(player))),
		tostring(message))
	)

	AntiFlood.onMessage()
end

-- серверные команды
local params = {}
function startCommandServer(message, player)

	local commands = split(message, " ")
	for k, v in ipairs(commands) do
		params[k] = v
	end

	if params[1] == 'me' then
		return onPlayerChatMe(player, string.gsub(message, params[1], ""))
	elseif params[1] == 'try' then
		return onPlayerChatTry(player, string.gsub(message, params[1], ""))
	elseif params[1] == 'do' then
		return onPlayerChatDo(player, string.gsub(message, params[1], ""))
	elseif params[1] == 'todo' then
		return onPlayerChatToDo(player, string.gsub(message, params[1], ""))
	end

	local state = executeCommandHandler(params[1], player, params[2], params[3], params[4], params[5], params[6], params[7])

	if not state then
		triggerClientEvent("startCommandClient", player, params[1], params[2], params[3], params[4], params[5], params[6], params[7])
	end
	
	for i = 1, 9 do
		params[i] = nil
	end
end



-- БЛОК КОМАНД --
local commands = { 
	['say'] = true,
	['me'] = true,
	['msg'] = true
	--['login'] = true,
	--['debugscript'] = true
}

addEventHandler('onPlayerCommand', root, function(command)
	if commands[command] then
		--outputChatBox('* Неизвестная команда!', 170, 0, 0)
		triggerClientEvent(source, 'operNotification.addNotification', source, 'Неизвестная команда', 2, true)
		cancelEvent()
	end
end)

addEventHandler("onPlayerLogout", root, function()
	--outputChatBox('* Неизвестная команда!', 170, 0, 0)
	triggerClientEvent(source, 'operNotification.addNotification', source, "Неизвестная команда", 2, true)
	cancelEvent() 
end)
