local screenWidth, screenHeight = guiGetScreenSize()

local ShowUI = {}

ShowUI.isVisible = false

local NAME_SERVER = dxCreateFont("assets/font.ttf", 20, false, "draft")
local LOGO = dxCreateFont("assets/font.ttf", 10, false, "draft")


local function drawLogoProject()
	dxDrawText('OPERSKIY #21b1ffOTDEL', 0, screenHeight-100, screenWidth-5, 40, tocolor(255, 255, 255, 155), 1, NAME_SERVER, 'right', nil, false, false, true, true)
	dxDrawText('vk.com/otdelmta', 0, screenHeight-70, screenWidth-5, 40, tocolor(255, 255, 255, 155), 1, LOGO, 'right', nil, false, false, true, true)
	dxDrawRectangle(screenWidth-230, screenHeight-70+2.5, 135.5, 1, tocolor(255, 255, 255, 155), true)
end

local function drawBlackBar()
	dxDrawRectangle(0, 0, screenWidth, 40, tocolor(0, 0, 0, 255), true)
	drawLogoProject()
	dxDrawRectangle(0, screenHeight-40, screenWidth, 40, tocolor(0, 0, 0, 255), true)
end

function ShowUI.cleanMyScreen()
	ShowUI.isVisible = not ShowUI.isVisible
    
    if ShowUI.isVisible then
    	addEventHandler("onClientRender", root, drawBlackBar)
	else
		removeEventHandler("onClientRender", root, drawBlackBar)
	end
end
addEvent('operShowUI.cleanMyScreen', true)
addEventHandler('operShowUI.cleanMyScreen', root, ShowUI.cleanMyScreen)

ShowUI.isVisibleLogo = false

function ShowUI.drawLogoProject(state)
	if state == nil then
		return
	end

    if not ShowUI.isVisibleLogo and state then
    	addEventHandler("onClientRender", root, drawLogoProject)
    elseif ShowUI.isVisibleLogo and not state then
    	removeEventHandler("onClientRender", root, drawLogoProject)
    end

    ShowUI.isVisibleLogo = state
end
addEvent('operShowUI.drawLogoProject', true)
addEventHandler('operShowUI.drawLogoProject', root, ShowUI.drawLogoProject)

