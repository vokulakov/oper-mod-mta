local screenWidth, screenHeight = guiGetScreenSize()

local HUD_FONTS = {
	['RB-20'] = dxCreateFont("assets/Roboto-Bold-Italic.ttf", 20, false, "draft"),
	['RB-10'] = dxCreateFont("assets/Roboto-Bold-Italic.ttf", 10, false, "draft"),

	['MONEY'] = dxCreateFont("assets/Roboto-Bold-Italic.ttf", 18, false, "antialiased"),
	["MONEY_GUI"] = guiCreateFont('assets/Roboto-Bold-Italic.ttf', 18, false, "antialiased"),
}

local HUD_TEXTURES = {
	["i_money"] = dxCreateTexture('assets/i_money.png'),
}

local HUD = {}

local oldPlayerMoney

local moneyRenderTarget = dxCreateRenderTarget(230, 29, true)

function HUD.drawMoney(money)
	local money = Utils.convertNumber(money)
    local textMoneyWidth = Utils.dxGetTextExtent(money:gsub("#%x%x%x%x%x%x", ""), HUD_FONTS["MONEY_GUI"])

    dxSetRenderTarget(moneyRenderTarget, true)
        dxDrawImage(200-textMoneyWidth-25, 1, 33, 28, HUD_TEXTURES.i_money, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        Utils.dxDrawText(money, 230-30, 0, 29, 29, tocolor(255, 255, 255, 255), 1, HUD_FONTS["MONEY"], "right")
    dxSetRenderTarget()
end 

function HUD.draw()

	local PLAYER_UI = getElementData(localPlayer, "player.UI")
	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['hud'] then return end
	
	local PLAYER_MONEY = getPlayerMoney()
	local hp = getElementHealth(localPlayer)
	local armor = getPedArmor(localPlayer)
	local oxygen = getPedOxygenLevel(localPlayer)

	-- SHADOW
	dxDrawImage(0, 0, screenWidth, screenHeight, "assets/hud-bg.png", 0, 0, 0, tocolor(255, 255, 255, 150), false)
	
	-- #21b1ff
	-- НАЗВАНИЕ
	--dxDrawRectangle(screenWidth-235, 10, 230, 50, tocolor(33, 33, 33, 200), false)

	dxDrawText('OPERSKIY #21b1ffOTDEL', 0, 0, screenWidth-5, screenHeight, tocolor(255, 255, 255), 1, HUD_FONTS['RB-20'], 'right', 'top', false, false, false, true)
	dxDrawText('vk.com/otdelmta', 0, 30, screenWidth-5, screenHeight, tocolor(255, 255, 255), 1, HUD_FONTS['RB-10'], 'right', 'top', false, false, false, true)

	dxDrawRectangle(screenWidth-235, 32.5, 135.5, 1, tocolor(255, 255, 255, 255))

	-- HP
	dxDrawRectangle(screenWidth-235, 36, 115, 8, tocolor(0, 0, 0, 150))
	dxDrawRectangle(screenWidth-233, 38, localPlayer.health*111 / 100, 4, tocolor(240, 26, 33, 250))

	-- Armor
	local wY = 48
	if armor > 0 then
		dxDrawRectangle(screenWidth-235, wY, 230, 8, tocolor(0, 0, 0, 150))
		dxDrawRectangle(screenWidth-233, wY + 2, localPlayer.armor*226 / 100, 4, tocolor(200, 200, 200, 250))
		wY = wY + 10
	end

	-- Oxygen
	if isElementInWater(localPlayer) then
		dxDrawRectangle(screenWidth-235, wY, 230, 8, tocolor(0, 0, 0, 150))
		dxDrawRectangle(screenWidth-233, wY+2, oxygen*225 / 1000, 4, tocolor(33, 177, 255, 250))
		wY = wY + 10
	end

	-- MONEY
	if tonumber(oldPlayerMoney) ~= tonumber(PLAYER_MONEY) or isClientRestore then 
        HUD.drawMoney(PLAYER_MONEY)
        oldPlayerMoney = PLAYER_MONEY
    end 

    dxDrawImage((screenWidth-235)*pX, (wY+5)*pY, 230*pX, 29*pY, moneyRenderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

addEventHandler("onClientRender", root, function()
	HUD.draw()
end)
