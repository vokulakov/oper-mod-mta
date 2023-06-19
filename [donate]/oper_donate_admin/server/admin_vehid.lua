function setVehicleID()
local startID = 1
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		setElementData(vehicle, "vehid.id", startID)
		startID = startID+1
	end
end
addEvent("vehid.onSetVehicleID", true)
addEventHandler("vehid.onSetVehicleID", root, setVehicleID)
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), setVehicleID)

function loadVehidRights(_, playeraccount)
	if (playeraccount) then
		if isObjectInACLGroup("user." .. getAccountName(playeraccount), aclGetGroup("Admin_4_lvl")) or isObjectInACLGroup("user." .. getAccountName(playeraccount), aclGetGroup("Admin_5_lvl")) or isObjectInACLGroup("user." .. getAccountName(playeraccount), aclGetGroup("Admin_6_lvl")) or isObjectInACLGroup("user." .. getAccountName(playeraccount), aclGetGroup("Admin")) then
			setElementData(source, "vehid.isAdmin", true)
		end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), loadVehidRights)

function updateVehicleID(player)
if getElementData(player, "vehid.isAdmin") ~= true then return end
	setVehicleID()
	outputChatBox("ID автомобилей перезагружены.", player, 0, 255, 0)
end
--addCommandHandler("updatevehid", updateVehicleID)

function destroyVehicleID(player, command, id)
if getElementData(player, "vehid.isAdmin") ~= true then return end
	if not id then
		outputChatBox("", player, 255, 0, 0)
		return
	end
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		local vehID = getElementData(vehicle, "vehid.id")
		if isElement(vehicle) and vehID then
			if tonumber(vehID) == tonumber(id) then
				destroyElement(vehicle)
				outputChatBox("", player, 0, 255, 0)
			end
		end
	end
end
--addCommandHandler("rcar", destroyVehicleID)