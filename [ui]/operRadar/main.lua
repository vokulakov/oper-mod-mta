local screenW, screenH = guiGetScreenSize()

local posX, posY = 20, screenH-20
local width, height = 220, 140
local mapRenderTarget = dxCreateRenderTarget(width, height, true)

local rtW, rtH = dxGetMaterialSize(mapRenderTarget)

local WORLD_TXT = dxCreateTexture('assets/world.jpg', "dxt5", true, "wrap")
local mW, mH = dxGetMaterialSize(WORLD_TXT)
local mapZoomScale = 6000/mW

local players = {}

local function drawRadar()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    
    if type(PLAYER_UI) == 'boolean' then
        return
    end
	if not PLAYER_UI['radar'] then return end

	if Camera.interior ~= 0 then
		return
	end

	local px, py, pz = getElementPosition(localPlayer)
	local p_dimension = getElementDimension(localPlayer)
	local p_interior = getElementInterior(localPlayer)

	local camera_rotation = Camera.rotation
	
	-- DRAW MAP --
	dxSetRenderTarget(mapRenderTarget, true)
		local X, Y = rtW/2 - (px/mapZoomScale), rtH*(3/5) + (py/mapZoomScale)
		local zmW, zmH = mW, mH

		dxDrawRectangle(0, 0, rtW, rtH, tocolor(124, 167, 209))

		dxDrawImage(X - (zmW)/2, Y - (zmH)/2, zmW, zmH, WORLD_TXT, camera_rotation.z, px/mapZoomScale, -(py/mapZoomScale), 0xFFFFFFFF)
	dxSetRenderTarget()
	--------------

	dxDrawRectangle(posX-5, posY-height-5, width+10, height+10, tocolor(33, 33, 33, 200), false)

 	dxSetBlendMode("add")
		dxDrawImage(posX, posY-rtH, rtW, rtH, mapRenderTarget, 0, 0, 0, tocolor(255, 255, 255, 255))
	dxSetBlendMode("blend")


	-- SETTINGS --
	local mapWidth, mapHeight = rtW, rtH
	local centerX, centerY = mapWidth/2, mapHeight*(3/5)
	local mapLeft, mapTop = posX, posY-rtH

	-- DRAW NORTH BLIP --
	local direction = math.rad(-camera_rotation.z + 180)
	local radius = math.sqrt((mapWidth/2)^2 + (mapHeight*(3/5))^2)
	local blipX, blipY = centerX + math.sin(direction) * radius, centerY + math.cos(direction) * radius
	local blipX = math.max(0, math.min(blipX, mapWidth)) -- clamp position between 0 and mapWidth
    local blipY = math.max(0, math.min(blipY, mapHeight)) -- clamp position between 0 and mapHeight
    local blipSize = 24

    dxDrawImage(mapLeft + blipX - blipSize/2, mapTop + blipY - blipSize/2, blipSize, blipSize, 'assets/blips/4.png', 0, 0, 0, tocolor(255, 255, 255, 255))

    -- PLAYERS --
    for player in pairs(players) do
    	if player ~= localPlayer and player.streamedIn then

    		local blipz = Vector3(player.position)
    		local dist = (poszP - blipz).length

    		if dist < 80 then 
    			local resutl = blipz.z - poszP.z
    			local radius = dist/mapZoomScale

            	local direction = math.atan2(blipz.x - px, blipz.y - py) + math.rad(camera_rotation.z)

          	  	local blipX, blipY = centerX + math.sin(direction) * radius, centerY - math.cos(direction) * radius
    			local blipX = math.max(0, math.min(blipX, mapWidth)) -- clamp position between 0 and mapWidth
    			local blipY = math.max(0, math.min(blipY, mapHeight)) -- clamp position between 0 and mapHeight

    			local blippath = "assets/blips/0.png"
    			if resutl >= 5 then
					blippath = "assets/blips/+1.png"
				elseif resutl <= -5 then
					blippath = "assets/blips/-1.png"
				end


    			local blipSize = 1.3
    			dxDrawImage(mapLeft + blipX - (16*blipSize)/2, mapTop + blipY - (16*blipSize)/2, (16*blipSize), (16*blipSize), blippath, camera_rotation.z*-1, 0, 0, tocolor(255, 255, 255, 255))
    		end
    	end
    end
	
    -- LOCAL PLAYER --
    local blipSize = 20
    dxDrawImage(mapLeft + centerX - blipSize/2, mapTop + centerY - blipSize/2, blipSize, blipSize, "assets/blips/2.png", camera_rotation.z-localPlayer.rotation.z, 0, 0)
end
addEventHandler('onClientRender', root, drawRadar, false)


addEventHandler("onClientElementStreamIn", root, function()
	if source.type == "player" then
		players[source] = true
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if source.type == "player" then
		players[source] = nil
	end
end)

addEventHandler("onClientPlayerJoin", root, function()
	players[source] = true
end)

addEventHandler("onClientPlayerQuit", root, function()
	players[source] = nil
end)