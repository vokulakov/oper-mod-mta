PlayerFunctions = {}


function PlayerFunctions.setPlayerJetpack(state)
	if not source then
		return
	end

	if state then
		local status = givePlayerJetPack(source)
	else
		local status = removePlayerJetPack(source)
	end  
	
end
addEvent('PlayerFunctions.setPlayerJetpack', true)
addEventHandler('PlayerFunctions.setPlayerJetpack', root, PlayerFunctions.setPlayerJetpack)

function PlayerFunctions.killPlayer()
	if not source then 
		return
	end

	killPed(source)
end
addEvent('PlayerFunctions.killPlayer', true)
addEventHandler('PlayerFunctions.killPlayer', root, PlayerFunctions.killPlayer)


function PlayerFunctions.setPlayerFightStyle(id)
	if not source or tonumber(id) == nil then
		return
	end

	local status = setPedFightingStyle(source, tonumber(id))
	triggerClientEvent(source, 'Dashboard.fightStyleWindowUpdate', source)
end
addEvent('PlayerFunctions.setPlayerFightStyle', true)
addEventHandler('PlayerFunctions.setPlayerFightStyle', root, PlayerFunctions.setPlayerFightStyle)

function PlayerFunctions.setPlayerWalkingStyle(id)
	if not source or tonumber(id) == nil then
		return
	end

	local status = setPedWalkingStyle(source, tonumber(id))
	triggerClientEvent(source, 'Dashboard.walkingStyleWindowUpdate', source)
end
addEvent('PlayerFunctions.setPlayerWalkingStyle', true)
addEventHandler('PlayerFunctions.setPlayerWalkingStyle', root, PlayerFunctions.setPlayerWalkingStyle)

function PlayerFunctions.givePlayerWeapon(id)
	if not source or tonumber(id) == nil then
		return
	end

	local status = giveWeapon(source, tonumber(id), 99999999, true)

end
addEvent('PlayerFunctions.givePlayerWeapon', true)
addEventHandler('PlayerFunctions.givePlayerWeapon', root, PlayerFunctions.givePlayerWeapon)

function PlayerFunctions.setPlayerSkin(id)
	if not source or tonumber(id) == nil then
		return
	end

	if getElementModel(source) == id then return end

	if isPedDead(source) then
		local x, y, z = getElementPosition(source)
		if isPedTerminated(source) then
			x = 0
			y = 0
			z = 3
		end
		local r = getPedRotation(source)
		local interior = getElementInterior(source)
		spawnPlayer(source, x, y, z, r, id)
		setElementInterior(source, interior)
		setCameraInterior(source, interior)
	else
		setElementModel(source, id)
	end
	setCameraTarget(source, source)
	setCameraInterior(source, getElementInterior(source))
end
addEvent('PlayerFunctions.setPlayerSkin', true)
addEventHandler('PlayerFunctions.setPlayerSkin', root, PlayerFunctions.setPlayerSkin)


local stopAnim = {}

addEvent("PlayerFunctions.onSetAnim", true)
addEventHandler("PlayerFunctions.onSetAnim", root, function(state, group, anim)
    if (state == true and not isTimer(stopAnim[client])) then
        setPedAnimation ( client, group, anim, -1, true, false, false, true )
		stopAnim[client] = setTimer(function() end, 500, 1)
    elseif ( state == false and not isTimer(stopAnim[client]) ) then
        setPedAnimation (client)
		stopAnim[client] = setTimer(function() end, 500, 1)
    end
end)