function updateDimension(dim)
	setElementDimension(client,dim)
	if getPedOccupiedVehicle( client ) then
		setElementDimension(getPedOccupiedVehicle( client ),dim)
	end
end
addEvent("updateDimension",true)
addEventHandler("updateDimension",root,updateDimension)

function applyWheelsData(data)
	local veh = getPedOccupiedVehicle( client )

	for k,v in pairs(data) do
		setElementData(veh,k,v)
	end
	
	triggerClientEvent(client,"initWheelsWindow",client,true)
end
addEvent("applyWheelsData",true)
addEventHandler("applyWheelsData",root,applyWheelsData)
