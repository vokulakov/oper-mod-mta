local screenW, screenH = guiGetScreenSize()
local SB_WIDTH, SB_HEIGHT = 692, 446
local SB_POSX, SB_POSY = screenW/2-SB_WIDTH/2, screenH/2-SB_HEIGHT/2

local HEAD_FONT = dxCreateFont("assets/RB.ttf", 13)
local COLUMNS_FONT = dxCreateFont("assets/RB.ttf", 11)
local ITEM_FONT = dxCreateFont("assets/RR.ttf", 10)

local playersList = {}
local playersOnlineCount = 0
local playersMaxCount = getElementData(resourceRoot, "operServerMaxPlayers")
local scrollOffset = 0

-- SETUPS
local itemsCount = 10
local headerColor = tocolor(255, 255, 255, 255) 
local columnsColor = tocolor(255, 255, 255, 255)
local playerLocalColor = tocolor(33, 177, 255, 215)--tocolor(114, 137, 218, 255)
local playerAunColor = tocolor(255, 255, 255, 125)
local playerColor = tocolor(255, 255, 255, 255)

local columns = {
	{name = "Ник", size = 0.35, data = "name"},
	{name = "Статус", size = 0.3, data = "status"},
	{name = "Стаж", size = 0.2, data = "playtime"},
	{name = "Пинг", size = 0.1},
}

local function drawScoreBoard()
	dxDrawRectangle(SB_POSX, SB_POSY, SB_WIDTH, 40, tocolor(0, 0, 0, 245), false)
	dxDrawRectangle(SB_POSX, SB_POSY, SB_WIDTH, SB_HEIGHT, tocolor(0, 0, 0, 200), false)

	dxDrawText("ИГРОКИ", SB_POSX+15, SB_POSY+10, SB_WIDTH, SB_HEIGHT, headerColor, 1, HEAD_FONT)
	dxDrawText(playersOnlineCount.."/"..playersMaxCount, SB_POSX+15, SB_POSY+10, SB_POSX+SB_WIDTH-15, SB_HEIGHT, headerColor, 1, HEAD_FONT, "right")

	local x = SB_POSX
	for i, column in ipairs(columns) do
		local width = SB_WIDTH * column.size
		dxDrawText(tostring(column.name), x, SB_POSY+75, x+width, SB_POSY+75, columnsColor, 1, COLUMNS_FONT, "center", "center")
		x = x + width
	end
	dxDrawRectangle(SB_POSX+15, SB_POSY+85, SB_WIDTH-37, 1, tocolor(224, 225, 231, 255))

	local y = SB_POSY+70
	for i = scrollOffset + 1, math.min(itemsCount + scrollOffset, #playersList) do
		local item = playersList[i]
		local color = playerColor
		
		if item.isLocalPlayer then
			color = playerLocalColor
		elseif item.status == "Авторизовывается" then
			color = playerAunColor
		end
		x = SB_POSX
		for j, column in ipairs(columns) do
			local text = item[column.data]
			if text == nil then text = getPlayerPing(item.player) end
			local width = SB_WIDTH * column.size
			dxDrawText(tostring(text), x, y, x+width, y+65, color, 1, ITEM_FONT, "center", "center")
			x = x + width
		end
		y = y + 35
	end
end

local function mouseDown()
	if #playersList <= itemsCount then
		return
	end
	scrollOffset = scrollOffset + 1
	if scrollOffset > #playersList - itemsCount then
		scrollOffset = #playersList - itemsCount + 1
	end
end

local function mouseUp()
	if #playersList <= itemsCount then
		return
	end
	scrollOffset = scrollOffset - 1
	if scrollOffset < 0 then
		scrollOffset = 0
	end
end

local function getPlayerStatus(player)
	
	if not player:getData('player.accountData') then
		return "Авторизовывается"
	end
	
	local playerPrefix = player:getData("player.prefix")
	if playerPrefix and playerPrefix.prefix then
		return playerPrefix.prefix
	end 

	return "Игрок"
end

local function getPlayerPlaytime(player) 
	local playtime = player:getData("player.playtime")
	if not playtime then
		return '-'
	end

	return math.floor(playtime/60)..' часов'
end

local function hexencode(str)
   return (str:gsub(".", function(char) return string.format("%02x", char:byte()) end))
end

local function startScoreBoard()
	triggerEvent('operShowUI.drawBlurShader', localPlayer, true) -- включаем размытие
	addEventHandler("onClientRender", root, drawScoreBoard)

	playersList = {}

	local function addPlayerToList(player, isLocalPlayer)
		if type(player) == "table" then
			table.insert(playersList, player)
			return
		end
		table.insert(playersList, {
			isLocalPlayer = isLocalPlayer,
			status = getPlayerStatus(player):gsub("#%x%x%x%x%x%x", ""),
			name = player:getName():gsub("#%x%x%x%x%x%x", ""),
			playtime = getPlayerPlaytime(player),
			player = player 
		})
	end

	local players = getElementsByType("player")

	playersOnlineCount = #players

	addPlayerToList(localPlayer, true)

	if #players > 0 then
		for i, player in ipairs(players) do
			if player ~= localPlayer then
				addPlayerToList(player)
			end
		end
	end

	bindKey("mouse_wheel_up", "down", mouseUp)
	bindKey("mouse_wheel_down", "down", mouseDown)
end

local function stopScoreBoard()
	removeEventHandler("onClientRender", root, drawScoreBoard)
	triggerEvent('operShowUI.drawBlurShader', localPlayer, false) -- выключаем размытие
	
	unbindKey("mouse_wheel_up", "down", mouseUp)
	unbindKey("mouse_wheel_down", "down", mouseDown)
end

local function setScoreBoardVisible()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    
    if type(PLAYER_UI) == 'boolean' then
        return
    end
    
	if not PLAYER_UI['scoreboard'] then
		--TODO:: это костыль
		SB_VISIBLE = false
		showCursor(false)
		removeEventHandler("onClientRender", root, drawScoreBoard)
		return 
	end

	SB_VISIBLE = not SB_VISIBLE
	showCursor(SB_VISIBLE)
	showChat(not SB_VISIBLE)
	
	if SB_VISIBLE then
		startScoreBoard()
		--setElementData(localPlayer, "exv_player.ACTIVE_UI", "scoreboard")
	else
		stopScoreBoard()
		--setElementData(localPlayer, "exv_player.ACTIVE_UI", false)
	end

	-- СКРЫТИЕ HUD
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, not SB_VISIBLE)
	triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'scoreboard', true)

end

bindKey("tab", "down", setScoreBoardVisible)
bindKey("tab", "up", setScoreBoardVisible)