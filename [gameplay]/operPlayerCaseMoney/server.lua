local Cases = {}

local function addPlayerCaseOfMoney(player)
	if isElement(getElementData(player, 'operPlayerCaseMoney.playerCase')) then return end

	local x, y, z = getElementPosition (player)
	local case = createObject(1210, x, y, z)
	local i = getElementInterior(player)
	local d = getElementDimension(player)
	setElementDimension(case, d)
	setElementInterior(case, i)
	exports.operBoneAttach:attachElementToBone(case, player, 11, 0, -0.02, 0.3, 180, 0, 0)
	setElementData(player, 'operPlayerCaseMoney.playerCase', case)

	case:setData('operPlayerCaseMoney.isPlayer', player)
	table.insert(Cases, case)
end

local function destroyPlayerCaseOfMoney(player)
	local case = getElementData(player, 'operPlayerCaseMoney.playerCase')

	if not isElement(case) then 
		return 
	end

	removeElementData(player, 'operPlayerCaseMoney.playerCase')
	removeElementData(case, 'operPlayerCaseMoney.isPlayer')
	
	destroyElement(case)
end

setTimer(
	function()
		for _, case in ipairs(Cases) do 
			if isElement(case) and not isElement(case:getData('operPlayerCaseMoney.isPlayer')) then 
				destroyElement(case)
				Cases[case] = nil
			end
		end 
	end, 5000, 0)

addEventHandler('onElementDataChange', getRootElement(), function(dataName)
	if getElementType(source) ~= 'player' or dataName ~= 'player.isPlayerAttachedCase' then return end
	
	if getElementData(source, 'player.isPlayerAttachedCase') then
		if not source.vehicle then
			addPlayerCaseOfMoney(source)
		end
	else
		destroyPlayerCaseOfMoney(source)
	end
end)

addEventHandler('onPlayerSpawn', root, function()
	if not getElementData(source, 'player.isPlayerAttachedCase') then return end
	addPlayerCaseOfMoney(source)
end)

addEventHandler('onPlayerQuit', root, function() destroyPlayerCaseOfMoney(source) end)

addEventHandler('onResourceStop', resourceRoot, function()
    for _, player in ipairs(getElementsByType('player')) do
		destroyPlayerCaseOfMoney(player)
	end
end)

addEventHandler('onPlayerVehicleEnter', root, function()
    destroyPlayerCaseOfMoney(source)
end)

addEventHandler('onVehicleStartExit', root, function(player)
    if not getElementData(player, 'player.isPlayerAttachedCase') then return end
    addPlayerCaseOfMoney(player)
end)

addEventHandler("onElementDestroy", root, function()
  	if getElementType(source) == "vehicle" then
    	local nPassengers = getVehicleMaxPassengers(source)
    	for i = 0, nPassengers - 1 do
      		local occupant = getVehicleOccupant(source, i)
      		if occupant then
      			if getElementData(occupant, 'player.isPlayerAttachedCase') then
        			addPlayerCaseOfMoney(occupant)
        		end
      		end
    	end
  	end
end)

addEventHandler('onPlayerWeaponSwitch', root, function(previousWeaponID, currentWeaponID)
	local slot = getSlotFromWeapon(currentWeaponID)
	if slot == 0 or slot == 2 then
		if getElementData(source, 'player.isPlayerAttachedCase') and not source.vehicle then
        	addPlayerCaseOfMoney(source)
        end
    else
    	destroyPlayerCaseOfMoney(source)
	end
end)

