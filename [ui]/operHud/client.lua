local screenWidth, screenHeight = guiGetScreenSize()

local HUD_FONTS = {
	['NAME_SERVER'] = dxCreateFont("font.ttf", 20, false, "draft"),

	['LOGO'] = dxCreateFont("font.ttf", 10, false, "draft"),

	['HEALTH'] = dxCreateFont("font.ttf", 20, false, "draft"),

	['MONEY'] = dxCreateFont("assets/Roboto-Bold.ttf", 12, false, "draft"),
}

addEventHandler("onClientRender", root, function()

	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['hud'] then return end

	local money = getPlayerMoney(localPlayer)
	local hp = getElementHealth(localPlayer)
	local armor = getPedArmor(localPlayer)
	local oxygen = getPedOxygenLevel(localPlayer)

-- SHADOW
	dxDrawImage(0, 0, screenWidth, screenHeight, "assets/hud-bg.png", 0, 0, 0, tocolor(255, 255, 255, 150), false)
	
	-- #21b1ff
	-- НАЗВАНИЕ
	--dxDrawRectangle(screenWidth-235, 10, 230, 50, tocolor(33, 33, 33, 200), false)

	dxDrawText('OPERSKIY #21b1ffOTDEL', 0, 0, screenWidth-5, screenHeight, tocolor(255, 255, 255), 1, HUD_FONTS['NAME_SERVER'], 'right', 'top', false, false, false, true)
	dxDrawText('vk.com/otdelmta', 0, 30, screenWidth-5, screenHeight, tocolor(255, 255, 255), 1, HUD_FONTS['LOGO'], 'right', 'top', false, false, false, true)

	dxDrawRectangle(screenWidth-235, 32.5, 135.5, 1, tocolor(255, 255, 255, 255))

	-- HP
	dxDrawRectangle(screenWidth-235, 36, 115, 8, tocolor(0, 0, 0, 150))
	dxDrawRectangle(screenWidth-233, 38, localPlayer.health*111 / 100, 4, tocolor(240, 26, 33, 250))

	-- Armor
	if armor > 0 then
		dxDrawRectangle(screenWidth-235, 48, 230, 8, tocolor(0, 0, 0, 150))
		dxDrawRectangle(screenWidth-233, 50, localPlayer.armor*226 / 100, 4, tocolor(200, 200, 200, 250))
	end

	-- Oxygen
	if isElementInWater(localPlayer) then
		local wY = 48

		if armor > 0 then
			wY = 58
		end

		dxDrawRectangle(screenWidth-235, wY, 230, 8, tocolor(0, 0, 0, 150))
		dxDrawRectangle(screenWidth-233, wY+2, oxygen*225 / 1000, 4, tocolor(33, 177, 255, 250))
	end

end)
