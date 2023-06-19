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

   -- if localPlayer:getData('operCamHack:isVisible') then
       -- return
   -- end

	if Camera.interior ~= 0 then
		return
	end

	-- DRAW MAP --
	dxSetRenderTarget(mapRenderTarget, true)
		local pos = Vector2(localPlayer.position)
		local X, Y = rtW/2 - (pos.x/mapZoomScale), rtH*(3/5) + (pos.y/mapZoomScale)
		local zmW, zmH = mW, mH

		dxDrawRectangle(0, 0, rtW, rtH, tocolor(124, 167, 209))

		dxDrawImage(X - (zmW)/2, Y - (zmH)/2, zmW, zmH, WORLD_TXT, Camera.rotation.z, pos.x/mapZoomScale, -(pos.y/mapZoomScale), 0xFFFFFFFF)
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
	local direction = math.rad(-Camera.rotation.z + 180)
	local radius = math.sqrt((mapWidth/2)^2 + (mapHeight*(3/5))^2)
	local blipX, blipY = centerX + math.sin(direction) * radius, centerY + math.cos(direction) * radius
	local blipX = math.max(0, math.min(blipX, mapWidth)) -- clamp position between 0 and mapWidth
    local blipY = math.max(0, math.min(blipY, mapHeight)) -- clamp position between 0 and mapHeight
    local blipSize = 24

    dxDrawImage(mapLeft + blipX - blipSize/2, mapTop + blipY - blipSize/2, blipSize, blipSize, 'assets/blips/4.png', 0, 0, 0, tocolor(255, 255, 255, 255))

    -- BLIPS -- 
    --[[
    for _, blip in ipairs(getElementsByType("blip")) do
    	local blipPos = blip.position
    	local dist = (localPlayer.position - blip.position).length
    	local maxdist = blip.visibleDistance

    	if dist <= maxdist and blip.icon ~= 0 then
    		local radius = dist/mapZoomScale

            local direction = math.atan2(blip.position.x - localPlayer.position.x, blip.position.y - localPlayer.position.y) + math.rad(Camera.rotation.z)

            local blipX, blipY = centerX + math.sin(direction) * radius, centerY - math.cos(direction) * radius
    		local blipX = math.max(0, math.min(blipX, mapWidth)) -- clamp position between 0 and mapWidth
    		local blipY = math.max(0, math.min(blipY, mapHeight)) -- clamp position between 0 and mapHeight

    		local blippath = "assets/blips/"..blip.icon..".png"

    		local blipSize = 1.3
    		local blipColor = tocolor(getBlipColor(blip))

    		local visible = true

    		if blipX == rtW or blipX == 0 or blipY == rtH or blipY == 0 then
    			if blip.icon ~= 41 then
    				visible = false
    			end

    			local r, g, b = getBlipColor(blip)
    			blipColor = tocolor(r, g, b, 125)
    		end

    		if blip.icon >= 1 and blip.icon <= 63 and visible then
    			dxDrawImage(mapLeft + blipX - (16*blipSize)/2, mapTop + blipY - (16*blipSize)/2, 16*blipSize, 16*blipSize, blippath, 0, 0, 0, blipColor)
    		end
    	end
    end
    ]]
    -- PLAYERS --
    for player in pairs(players) do
    	if player ~= localPlayer and player.streamedIn then

    		local blipz = Vector3(player.position)
    		local poszP = Vector3(localPlayer.position)
    		local dist = (poszP - blipz).length

    		if dist < 80 then 
    			local resutl = blipz.z - poszP.z
    			local radius = dist/mapZoomScale

            	local direction = math.atan2(blipz.x - poszP.x, blipz.y - poszP.y) + math.rad(Camera.rotation.z)

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
    			dxDrawImage(mapLeft + blipX - (16*blipSize)/2, mapTop + blipY - (16*blipSize)/2, (16*blipSize), (16*blipSize), blippath, Camera.rotation.z*-1, 0, 0, tocolor(255, 255, 255, 255))
    		end
    	end
    end
	
    -- LOCAL PLAYER --
    local blipSize = 20
    dxDrawImage(mapLeft + centerX - blipSize/2, mapTop + centerY - blipSize/2, blipSize, blipSize, "assets/blips/2.png", Camera.rotation.z-localPlayer.rotation.z, 0, 0)
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