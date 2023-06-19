Dashboard.mapWindow = {}

setTimer(toggleControl, 1000, 0, "radar", false)

local g_MapSide = (sHeight * 0.85)

local wndWidht, wndHeight = g_MapSide, g_MapSide+70

local g_PlayerData = {}

Dashboard.mapWindow['wnd'] = guiCreateWindow(sWidth/2-wndWidht/2, sHeight/2-wndHeight/2, wndWidht, wndHeight, "Двойной клик для телепортации", false)
guiWindowSetSizable(Dashboard.mapWindow['wnd'], false)
guiSetVisible(Dashboard.mapWindow['wnd'], false)
guiWindowSetMovable(Dashboard.mapWindow['wnd'], false)

Dashboard.mapWindow['map'] = guiCreateStaticImage(0, 25, g_MapSide, g_MapSide, "assets/map.png", false, Dashboard.mapWindow['wnd'])


Dashboard.mapWindow['btn_close'] = guiCreateButton(0, wndHeight-35, wndWidht, 25, "Закрыть", false, Dashboard.mapWindow['wnd'])
guiSetFont(Dashboard.mapWindow['btn_close'], "default-bold-small")

local g_TeleportTimer, g_TeleportMatrixTimer

local function calmVehicle(veh)
	if not isElement(veh) then return end
	local z = veh.rotation.z
	veh.velocity = Vector3(0,0,0)
	veh.turnVelocity = Vector3(0,0,0)
	veh.rotation = Vector3(0,0,z)
	if not (localPlayer.inVehicle and localPlayer.vehicle) then
		triggerServerEvent('mapFunctions.warpMeIntoVehicle', localPlayer, veh)
	end

end

local function setCameraPlayerMode()
	local r
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		local rx, ry, rz = getElementRotation(vehicle)
		r = rz
	else
		r = getPedRotation(localPlayer)
	end
	local x, y, z = getElementPosition(localPlayer)
	setCameraMatrix(x - 4*math.cos(math.rad(r + 90)), y - 4*math.sin(math.rad(r + 90)), z + 1, x, y, z + 1)
	setTimer(setCameraTarget, 100, 1, localPlayer)
end

local function retryTeleport(elem,x,y,z,isVehicle,distanceToGround)

	local hit, groundX, groundY, groundZ = processLineOfSight(x, y, 3000, x, y, -3000)
	if hit then
		local waterZ = getWaterLevel(x, y, 100)
		z = (waterZ and math.max(groundZ, waterZ) or groundZ) + distanceToGround
		setElementPosition(elem,x, y, z + distanceToGround)
		setCameraPlayerMode()

		if isVehicle then
			triggerServerEvent('mapFunctions.fadeVehiclePassengersCamera', localPlayer, true)
			setTimer(calmVehicle,100,1,elem)
		else
			fadeCamera(true)
		end
		killTimer(g_TeleportTimer)
		g_TeleportTimer = nil
		grav = nil
	end

end

local function setPlayerPosition(x, y, z)
	local elem = getPedOccupiedVehicle(localPlayer)
	local isVehicle

	if elem and getPedOccupiedVehicle(localPlayer) then
		local controller = getVehicleController(elem)
		if controller and controller ~= localPlayer then
			--Только водитель транспортного средства может установить свою позицию.
			return false
		end
		isVehicle = true
	else
		elem = localPlayer
		isVehicle = false
	end

	if isPedDead(localPlayer) then
		-- если игрок умер, то спавн невозможен
		return
	end

	local distanceToGround = getElementDistanceFromCentreOfMassToBaseOfModel(elem)
	local hit, hitX, hitY, hitZ = processLineOfSight(x, y, 3000, x, y, -3000)
	if not hit then
		if isVehicle then
			triggerServerEvent('mapFunctions.fadeVehiclePassengersCamera', localPlayer, false)
		else
			fadeCamera(false)
		end
		if isTimer(g_TeleportMatrixTimer) then killTimer(g_TeleportMatrixTimer) end
		g_TeleportMatrixTimer = setTimer(setCameraMatrix, 1000, 1, x, y, z)
		if isTimer(g_TeleportTimer) then killTimer(g_TeleportTimer) end
		g_TeleportTimer = setTimer(retryTeleport,50,0,elem,x,y,z,isVehicle,distanceToGround)
	else
		setElementPosition(elem, x, y, z + distanceToGround)
		if isVehicle then
			setTimer(calmVehicle, 100, 1, elem)
		end
	end

end

--[[
addCommandHandler('pos', 
	function()
		local lol = Vector3(getElementPosition(localPlayer))
		outputDebugString(lol.x..' '..lol.y)
	end
)
]]
function onMapDoubleClick(button, state, relX, relY)
	if source ~= Dashboard.mapWindow['map'] then
		return
	end

	local wndX, wndY = guiGetPosition(Dashboard.mapWindow['wnd'], false)
	local mapX, mapY = guiGetPosition(Dashboard.mapWindow['map'], false)

	local x, y = (relX-(wndX-mapX/2))/g_MapSide, (relY-(wndY+mapY))/g_MapSide
	local px = x*6000 - 3000
	local py = 3000 - y*6000

	local hit, hitX, hitY, hitZ
	hit, hitX, hitY, hitZ = processLineOfSight(px, py, 3000, px, py, -3000)

	hitZ = hitZ or 0

	if tonumber(px) and tonumber(py) then
		--outputDebugString(px..' '..py)
		if setPlayerPosition(px, py, hitZ) ~= false then
			if getElementInterior(localPlayer) ~= 0 then
				local vehicle = localPlayer.vehicle
				if vehicle and vehicle.interior ~= 0 then
					triggerServerEvent('mapFunctions.setElementInterior', localPlayer, getPedOccupiedVehicle(localPlayer), 0)
					--server.setElementInterior(getPedOccupiedVehicle(localPlayer), 0)
					local occupants = vehicle.occupants
					for seat,occupant in pairs(occupants) do
						if occupant.interior ~= 0 then
							--server.setElementInterior(occupant,0)
							triggerServerEvent('mapFunctions.setElementInterior', localPlayer, occupant, 0)
						end
					end
				end
				if localPlayer.interior ~= 0 then
					--server.setElementInterior(localPlayer,0)
					triggerServerEvent('mapFunctions.setElementInterior', localPlayer, localPlayer, 0)
				end
			end
		end

		Dashboard.mapWindow.setVisible(false)

	end
end
addEventHandler("onClientGUIDoubleClick", Dashboard.mapWindow['map'], onMapDoubleClick, true)


local blipPlayers = {}

function warpMe(targetPlayer, isAdmin)
	--[[
	if not g_settings["warp"] then
		errMsg("Warping is disallowed!")
		return
	end
	]]

	if targetPlayer == localPlayer then
		triggerEvent('operNotification.addNotification', localPlayer, "Вы не можете телепортироваться\nк самому себе!", 2, true)
		--errMsg("You can't warp to yourself!")
		return 
	end

	if targetPlayer:getData('player.isPlayerTeleport') and not isAdmin then
		triggerEvent('operNotification.addNotification', localPlayer, "К сожалению, игрок запретил\nтелепортироваться к нему", 2, true)
		return
	end
	--if g_PlayerData[targetPlayer].warping then
		--errMsg("This player has disabled warping to them!")
		--return
	--end

	local vehicle = getPedOccupiedVehicle(targetPlayer)
	local interior = getElementInterior(targetPlayer)
	if not vehicle then
		-- target player is not in a vehicle - just warp next to him
		local vec = targetPlayer.position + targetPlayer.matrix.right*2
		local x, y, z = vec.x,vec.y,vec.z
		if localPlayer.interior ~= interior then
			fadeCamera(false,1)
			setTimer(setPlayerInterior,1000,1,x,y,z,interior)
		else
			setPlayerPosition(x,y,z)
		end
	else
		-- target player is in a vehicle - warp into it if there's space left
		--server.warpMeIntoVehicle(vehicle)
		triggerServerEvent('mapFunctions.warpMeIntoVehicle', localPlayer, vehicle)
	end

end

local function destroyBlip()
	blipPlayers[source] = nil
end

local function warpToBlip()
	local elem = blipPlayers[source]
	if isElement(elem) then
		warpMe(elem)

		Dashboard.mapWindow.setVisible(false)
	end
end

function Dashboard.mapWindow.updatePlayerBlips()
	if not g_PlayerData then
		return
	end

	for elem, player in pairs(g_PlayerData) do
		if isElement(elem) then
			-- Здесь нужно сделать проверку на то, авторизовался ли игрок
			if elem:getData('player.accountData') then

				if not player.mapBlip then
					player.mapBlip = guiCreateStaticImage(0, 0, 9, 9, elem == localPlayer and 'assets/localplayerblip.png' or 'assets/playerblip.png', false, Dashboard.mapWindow['wnd'])
					player.mapLabelShadow = guiCreateLabel(0, 0, 100, 14, player.name, false, Dashboard.mapWindow['wnd'])

					local labelWidth = guiLabelGetTextExtent(player.mapLabelShadow)
					guiSetSize(player.mapLabelShadow, labelWidth, 14, false)
					guiSetFont(player.mapLabelShadow, 'default-bold-small')
					guiLabelSetColor(player.mapLabelShadow, 255, 255, 255)
					player.mapLabel = guiCreateLabel(0, 0, labelWidth, 14, player.name, false, Dashboard.mapWindow['wnd'])

					guiSetFont(player.mapLabel, 'default-bold-small')
					guiLabelSetColor(player.mapLabel, 0, 0, 0)

					for i, data in ipairs({'mapBlip', 'mapLabelShadow'}) do
						blipPlayers[player[data]] = elem
						addEventHandler('onClientGUIDoubleClick', player[data], warpToBlip, false)
						addEventHandler("onClientElementDestroy", player[data], destroyBlip)
					end
				end

				local mapX, mapY = guiGetPosition(Dashboard.mapWindow['map'], false)
				local x, y = getElementPosition(elem)
				local visible = (localPlayer.interior == elem.interior and localPlayer.dimension == elem.dimension)
				x = math.floor((x + 3000) * g_MapSide / 6000) - 4
				y = math.floor((3000 - y) * g_MapSide / 6000) - 4
				guiSetPosition(player.mapBlip, x - mapX/2, y + mapY, false)
				guiSetPosition(player.mapLabelShadow, x + 14 - mapX/2, y - 4 + mapY , false)
				guiSetPosition(player.mapLabel, x + 13 - mapX/2, y - 5 + mapY, false)
				guiSetVisible(player.mapBlip,visible)
				guiSetVisible(player.mapLabelShadow,visible)
				guiSetVisible(player.mapLabel,visible)

				guiMoveToBack(Dashboard.mapWindow['map'])
			end
		end
	end
end

function Dashboard.mapWindow.setVisible(state)
	local x, y, z = getElementPosition(localPlayer)
	posX, posY, posZ = x, y, z

	if state and guiGetVisible(Dashboard.mapWindow['wnd']) then
		return
	end

	if state then
		Dashboard.setVisible(false)

		Dashboard.activeWindowShow(Dashboard.mapWindow['wnd'])

		guiSetVisible(Dashboard.mapWindow['wnd'], true)
		addEventHandler('onClientRender', root, Dashboard.mapWindow.updatePlayerBlips)
		showCursor(true)

		triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'dashboard', true) -- ну отключать dashboard
		showChat(false)
		triggerEvent('operShowUI.drawBlurShader', localPlayer, true)
	else
		if not guiGetVisible(Dashboard.mapWindow['wnd']) then
			return
		end
		guiSetVisible(Dashboard.mapWindow['wnd'], false)
		removeEventHandler('onClientRender', root, Dashboard.mapWindow.updatePlayerBlips)
		showCursor(false)

		triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
		triggerEvent('operShowUI.setVisiblePlayerComponentUI', localPlayer, 'dashboard', true) -- ну отключать dashboard
		showChat(true)
		triggerEvent('operShowUI.drawBlurShader', localPlayer, false)
	end
end

bindKey('f11', 'down', function()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")
    if type(PLAYER_UI) == 'boolean' then return end
	if not PLAYER_UI['dashboard'] then return end

	--if localPlayer:getData('operLoginPanel:isVisible') then
		--return
	--end

	Dashboard.mapWindow.setVisible(not guiGetVisible(Dashboard.mapWindow['wnd']))
end)

addEventHandler("onClientGUIClick", root, function()
	if not guiGetVisible(Dashboard.mapWindow['wnd']) then
		return
	end

	if source == Dashboard.mapWindow['btn_close'] then
		Dashboard.mapWindow.setVisible(false)
	end
end)

-- Utils

local function getPlayers()
	g_PlayerData = {}
	for _, player in ipairs(getElementsByType('player')) do
		g_PlayerData[player] = { name = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""), gui = {} }
	end
end

local function joinHandler()
	if (not g_PlayerData) then return end
	g_PlayerData[source] = { name = getPlayerName(source):gsub("#%x%x%x%x%x%x", ""), gui = {} }
end

local function changeNick()
	if (not g_PlayerData[source]) then return end  

	g_PlayerData[source].name = getPlayerName(source):gsub("#%x%x%x%x%x%x", "")
end

local function quitHandler()
	if (not g_PlayerData) then return end 
	
	if not g_PlayerData[source].mapBlip then
		return
	end
	
	destroyElement(g_PlayerData[source].mapBlip)
	destroyElement(g_PlayerData[source].mapLabelShadow)
	destroyElement(g_PlayerData[source].mapLabel)
	g_PlayerData[source] = nil
end

addEventHandler('onClientPlayerJoin', root, joinHandler)
addEventHandler('onClientPlayerQuit', root, quitHandler)
addEventHandler('onClientPlayerChangeNick', root, changeNick)

addEventHandler('onClientResourceStart', resourceRoot,
	function()
		setTimer(getPlayers, 1000, 1)
		Dashboard.mapWindow.updatePlayerBlips()
	end)
