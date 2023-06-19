fpsCam = false

function setCameraPoint(x,y,z)
	globalX, globalY, globalZ  = x,y,z
	if globalX then
		enableFPS()
	else
		disableFPS()
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - (angle)*-1);
	local dx = math.cos(a) * dist;
	local dy = math.sin(a) * dist;
	return x+dx, y+dy;
end

function rollCam( _, _, x, y, worldX, worldY, worldZ )
	if not isCursorShowing() then
		glX = worldX
		glY = worldY
		glZ = worldZ
	end
end

function cameraAttach()
	if glX then
		if not globalX then
			local xn, yn, zn = getPedBonePosition(localPlayer, 6)
			local angleX, angleY, angleZ = getElementRotation(localPlayer)
			local newXl, newYl = getPointFromDistanceRotation(xn, yn, 0.001, angleZ)		
			setCameraMatrix ( newXl, newYl, zn+0.05, glX, glY, glZ,0,60)
		else
			setCameraMatrix ( globalX, globalY, globalZ, glX, glY, glZ,0,60)
		end
	end	
end

function enableFPS()
	--Orlin: Если у игрока был включен FPS, запрещаем повторное включение
	if fpsCam then
		return
	end
	fpsCam = true
	localPlayer.alpha = 0
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
	local x,y,z = getElementPosition(localPlayer)
	setCameraMatrix ( x,y,z+1, x,y,z )	
	addEventHandler("onClientCursorMove", root, rollCam)
	addEventHandler("onClientPreRender",  root, cameraAttach)
end

function disableFPS()
	--Orlin: выключаем в любом случае
	fpsCam = false
	localPlayer.alpha = 255
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
	removeEventHandler( "onClientCursorMove", root, rollCam)
	removeEventHandler("onClientPreRender",root, cameraAttach)
	setCameraTarget ( localPlayer )
end
