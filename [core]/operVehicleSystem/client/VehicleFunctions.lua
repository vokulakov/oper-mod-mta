VehicleFunctions = {}

function VehicleFunctions.flipVehicle()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle then
		local rX, rY, rZ = getElementRotation(vehicle)
		setElementRotation(vehicle, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ)
		triggerEvent('operNotification.addNotification', localPlayer, "Транспорт перевернут", 1, true)
	end
end
addCommandHandler('flip', VehicleFunctions.flipVehicle)
addCommandHandler('f', VehicleFunctions.flipVehicle)

function VehicleFunctions.exitOccupants()
	local vehicle = getPedOccupiedVehicle(localPlayer)

	if not vehicle then
		return
	end

	local owner = vehicle:getData('vehicle.isPlayer') or false

	for seat, player in pairs(getVehicleOccupants(vehicle)) do
		if player ~= owner then
  			setPedControlState(player, "enter_exit", true)
  			triggerEvent('operNotification.addNotification', player, 'Владелец транспорта высадил вас', 1, true)
  		end
	end
end

function VehicleFunctions.setSpecialProperty(property, state)
	local vehicle = getPedOccupiedVehicle(localPlayer)

	if not vehicle then
		return
	end

	local VehiclesProperty = vehicle:getData('vehicle.isProperty')

	if VehiclesProperty[property] and state and not isWorldSpecialPropertyEnabled(property) then
		setWorldSpecialPropertyEnabled(property, true)
	
	elseif not VehiclesProperty[property] and not state and isWorldSpecialPropertyEnabled(property) then
	 	setWorldSpecialPropertyEnabled(property, false)
	 	
	end

end
addEvent('VehicleFunctions.setSpecialProperty', true)
addEventHandler('VehicleFunctions.setSpecialProperty', root, VehicleFunctions.setSpecialProperty)

function VehicleFunctions.getSpecialProperty(vehicle, property, onEnter)
	if not isElement(vehicle) then return end
	local VehiclesProperty = vehicle:getData('vehicle.isProperty') or {}

	if onEnter then
		if VehiclesProperty[property] and not isWorldSpecialPropertyEnabled(property) then
			setWorldSpecialPropertyEnabled(property, true)
		end
	else
		if VehiclesProperty[property] and isWorldSpecialPropertyEnabled(property) then
			setWorldSpecialPropertyEnabled(property, false)
		end
	end
end
-- GHOST MODE --

local function hasVehicleGhost(vehicle) -- проверяем, имеет ли транспорт ghostmode
	if not isElement(vehicle) then return end
	--local driver = getVehicleController(vehicle)
	local VehiclesProperty = vehicle:getData('vehicle.isProperty') or {}

	if VehiclesProperty.ghostmode then
		return VehiclesProperty.ghostmode
	end
end

function VehicleFunctions.setVehicleGhost(sourceVehicle, value)
	local vehicles = getElementsByType("vehicle")
	for _, vehicle in ipairs(vehicles) do
		local vehicleGhost = hasVehicleGhost(vehicle)
		if isElement(sourceVehicle) and isElement(vehicle) then
		   setElementCollidableWith(sourceVehicle, vehicle, not value)
		   setElementCollidableWith(vehicle, sourceVehicle, not value)
		end
		if value == false and vehicleGhost == true and isElement(sourceVehicle) and isElement(vehicle) then
			setElementCollidableWith(sourceVehicle, vehicle, not vehicleGhost)
			setElementCollidableWith(vehicle, sourceVehicle, not vehicleGhost)
		end
	end
end

addEvent('VehicleFunctions.setVehicleGhost', true)
addEventHandler('VehicleFunctions.setVehicleGhost', root, function()
	if not isElement(sourceVehicle) then
		return
	end

	VehicleFunctions.setVehicleGhost(sourceVehicle, hasVehicleGhost(sourceVehicle))
end)

addEventHandler("onClientPlayerVehicleEnter", root, function(vehicle, seat)
	if source ~= localPlayer then
		return
	end

	if vehicle then
		VehicleFunctions.setVehicleGhost(vehicle, hasVehicleGhost(vehicle))
		VehicleFunctions.getSpecialProperty(vehicle, 'hovercars', true)
		VehicleFunctions.getSpecialProperty(vehicle, 'aircars', true)

		-- Проверка на посадку
		local VehiclesProperty = vehicle:getData('vehicle.isProperty') or {}
		local isOwner = vehicle:getData('vehicle.isPlayer') or false

		if VehiclesProperty.enterAllowed then
			local isDriver = VehiclesProperty.enterAllowed.isDriver
			local state = VehiclesProperty.enterAllowed.state
			if isDriver and state and seat == 0 and isOwner ~= localPlayer then
				setPedControlState(localPlayer, "enter_exit", true)
				triggerEvent('operNotification.addNotification', localPlayer, 'Вы не можете управлять\nданным транспортным средством', 2, true)
			elseif not isDriver and state and isOwner ~= localPlayer then
				setPedControlState(localPlayer, "enter_exit", true)
				triggerEvent('operNotification.addNotification', localPlayer, 'Владелец транспортного средства\nзапретил садиться в его транспорт', 2, true)
			end
		end


	end
end)

addEventHandler("onClientPlayerVehicleExit", root, function(vehicle)
	if source ~= localPlayer then
		return
	end

	if vehicle then
		VehicleFunctions.setVehicleGhost(vehicle, hasVehicleGhost(vehicle))
		VehicleFunctions.getSpecialProperty(vehicle, 'hovercars', false)
		VehicleFunctions.getSpecialProperty(vehicle, 'aircars', false)
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
   if source.type ~= "vehicle" then return end
   VehicleFunctions.setVehicleGhost(source, hasVehicleGhost(source))
end)

-- Exports
flipVehicle = VehicleFunctions.flipVehicle
exitOccupants = VehicleFunctions.exitOccupants
specialProperty = VehicleFunctions.specialProperty

local Names = getVehiclesNameList()

local x,y = guiGetScreenSize()
local timer = nil
local showName = nil
local hideAfter = 3 -- Hide name after 3 sec

function showVehName()
    if not showName then return end

    local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['hud'] then return end

    dxDrawText(showName, 1, y/1.5+1, x+1, y+1, tocolor(0,0,0,120), 1.7, "default-bold", "center", "center", false, false, false, true)
    dxDrawText(showName, 0, y/1.5, x, y, tocolor(220,220,220,230), 1.7, "default-bold", "center", "center", false, false, false, true)
end


addEventHandler("onClientVehicleEnter", root, function(player)
    if player ~= localPlayer then return end
        
    if isTimer(timer) then killTimer(timer) removeEventHandler("onClientRender", root, showVehName) showName = nil end
    	
    if not source:getData('vehicle.isPlayer') then
    	return
    end
    
    local vehModel = getElementModel(source)

   
	local name = Names[vehModel] or getVehicleNameFromModel(vehModel)

    showName = name..'\nВладелец: #21b1ff'..source:getData('vehicle.isPlayer'):getName()
        
    addEventHandler("onClientRender", root, showVehName)
    timer = setTimer(function() removeEventHandler("onClientRender", root, showVehName) showName = nil end, 1000*hideAfter, 1)
end)
