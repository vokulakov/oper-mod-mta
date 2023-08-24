local NAMETAG_MAX_DISTANCE = 15
local NAMETAG_OFFSET = 1.15
local NAMETAG_FONT = "default-bold"

local MessageTimeVisible = 5000

local streamedPlayers = {}

local messages = {}

local function dxDrawNametagText(text, x1, y1, x2, y2, color, scale)
	dxDrawText(text, x1 - 1, y1, x2 - 1, y2, tocolor(0, 0, 0, 150), scale, NAMETAG_FONT, "center", "center")
	dxDrawText(text, x1 + 1, y1, x2 + 1, y2, tocolor(0, 0, 0, 150), scale, NAMETAG_FONT, "center", "center")
	dxDrawText(text, x1, y1 - 1, x2, y2 - 1, tocolor(0, 0, 0, 150), scale, NAMETAG_FONT, "center", "center")
	dxDrawText(text, x1, y1 + 1, x2, y2 + 1, tocolor(0, 0, 0, 150), scale, NAMETAG_FONT, "center", "center")
	dxDrawText(text, x1, y1, x2, y2, color, scale, NAMETAG_FONT, "center", "center")
end


local function addMessage(text, player, tick)
	if (not messages[player]) then
		messages[player] = {}
	end

	table.insert(messages[player], {["text"] = text, ["player"] = player, ["tick"] = tick, ["endTime"] = tick + 2000, ["alpha"] = 0})
end

addEvent("operNameTag.onChatIncome", true)
addEventHandler("operNameTag.onChatIncome", root,
	function(message)
		addMessage(message, source, getTickCount())
	end
)

addEventHandler("onClientRender", root, function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['nicknames'] then return end

	local cx, cy, cz = getCameraMatrix()
	local tick = getTickCount()

	for player, info in pairs(streamedPlayers) do

		local px, py, pz = getElementPosition(player)		
		local x, y = getScreenFromWorldPosition(px, py, pz + NAMETAG_OFFSET)
		if x and y then
			local distance = getDistanceBetweenPoints3D(cx, cy, cz, px, py, pz)
			if distance < NAMETAG_MAX_DISTANCE then

				local yOffset = 16

				-- Префикс (тэг)
				local playerPrefix = player:getData("player.prefix")
				if playerPrefix then
					dxDrawNametagText(playerPrefix.prefix, x, y-yOffset, x, y-yOffset, tocolor(235, 207, 52, 255), 1)
					yOffset = yOffset + 16
				end

				if player:getData("player.AFK") then -- AFK
					local AFK_TIME = player:getData("player.AFK_TIMER")
					dxDrawNametagText('AFK ['..tostring(AFK_TIME)..']', x, y-yOffset, x, y-yOffset, tocolor(200, 0, 0, 255), 1)
				elseif player:getData('player.isChatting') then
					dxDrawNametagText('Строчит сообщение...', x, y-yOffset, x, y-yOffset, tocolor(33, 177, 255, 255), 1)
				end

				dxDrawNametagText(info.name, x, y, x, y, tocolor(255, 255, 255, 255), 1)

				-- ОТРИСОВКА HP и БРОНИ
				if player.armor > 0 then
					NAMETAG_OFFSET = 1.25
					dxDrawRectangle(x-50/2, y+10, 50, 6, tocolor(0, 0, 0, 150))
					dxDrawRectangle(x-48/2, y+11, player.armor*48 / 100, 4, tocolor(200, 200, 200, 250))
					dxDrawRectangle(x-50/2, y+18, 50, 6, tocolor(0, 0, 0, 150))
					dxDrawRectangle(x-48/2, y+19, player.health*48 / 100, 4, tocolor(200, 0, 0, 250))
				else
					NAMETAG_OFFSET = 1.15
					dxDrawRectangle(x-50/2, y+10, 50, 6, tocolor(0, 0, 0, 150))
					dxDrawRectangle(x-48/2, y+11, player.health*48 / 100, 4, tocolor(200, 0, 0, 250))
				end

				--dxDrawRectangle(x-50/2, y+18, 50, 6, tocolor(0, 0, 0, 150))

				-- СООБЩЕНИЕ НАД ИГРОКОМ
				if messages[player] then
					for i, v in ipairs(messages[player]) do
						local px, py, pz = getElementPosition(player)		
						local x, y = getScreenFromWorldPosition(px, py, pz + NAMETAG_OFFSET)

						if tick-v.tick < MessageTimeVisible then
							v.alpha = v.alpha < 200 and v.alpha + 5 or v.alpha

							local elapsedTime = tick - v.tick
							local duration = v.endTime - v.tick
							local progress = elapsedTime / duration

							local yPos = interpolateBetween(y, 0, 0, y-20-yOffset*i, 0, 0, progress, progress > 1 and "Linear" or "OutElastic")

							dxDrawNametagText(v.text, x, yPos, x, yPos, tocolor(255, 255, 255, v.alpha+50), 1)
						else
							table.remove(messages[player], i)
						end
					end
				end

			end
		end
	end

end)

local function showPlayer(player)
	if not isElement(player) then
		return false
	end
	setPlayerNametagShowing(player, false)
	if player == localPlayer then
		return
	end
	streamedPlayers[player] = {name = player:getName():gsub("#%x%x%x%x%x%x", "")}
	return true
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, player in ipairs(getElementsByType("player")) do
		if isElementStreamedIn(player) then 
			showPlayer(player)
		end
		setPlayerNametagShowing(player, false)
	end
end)

addEventHandler("onClientPlayerJoin", root, function()
	if isElementStreamedIn(source) then
		showPlayer(source)
	end
	setPlayerNametagShowing(source, false)
end)

addEventHandler("onClientElementStreamIn", root, function ()
	if getElementType(source) == "player" then
		showPlayer(source)
	end
end)

addEventHandler("onClientElementStreamOut", root, function ()
	if getElementType(source) == "player" then
		streamedPlayers[source] = nil
	end
end)

addEventHandler("onClientPlayerQuit", root, function ()
	streamedPlayers[source] = nil
end)