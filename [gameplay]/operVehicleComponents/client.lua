Components = {}

function Components.setComponentVisible(vehicle, component, boolean)
	if not isElement(vehicle) then return end

	setVehicleComponentVisible(vehicle, component, boolean)

	local components = {}

	for c in pairs(getVehicleComponents(vehicle)) do
		table.insert(components, {c, getVehicleComponentVisible(vehicle, c)})
	end
	
	vehicle:setData('vehicle.isComponents', components)
end

function Components.updateVisible(vehicle, components)
	if not isElement(vehicle) then return end

	for _, v in ipairs(components) do
		setVehicleComponentVisible(vehicle, v[1], v[2])
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    for i, vehicle in ipairs(getElementsByType("vehicle")) do
        if isElementStreamedIn(vehicle) then
        	local components = vehicle:getData('vehicle.isComponents') or false
        	if components then
        		Components.updateVisible(vehicle, components)
        	end
        end
    end
end)

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
    	local components = source:getData('vehicle.isComponents') or false
        if components then
        	Components.updateVisible(source, components)
        end
    end
end)

addEventHandler("onClientElementDataChange", root, function(data)
	if getElementType(source) == "vehicle" then
		if data == "vehicle.isComponents" and isElementStreamedIn(source) then
			Components.updateVisible(source, source:getData(data))
		end
	end
end)

-- Exports
addEvent('operVehicleComponents.setComponentVisible', true)
addEventHandler('operVehicleComponents.setComponentVisible', root, Components.setComponentVisible)
