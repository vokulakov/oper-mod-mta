local sX, sY = guiGetScreenSize()
local showCarIdNumberSET = true

local tableDistance = {
	{1,5,2.20,2.21},
	{5,10,2.00,2.01},
	{10,15,1.80,1.81},
	{15,20,1.60,1.61},
	{20,25,1.40,1.41},
}

function findFontToHeight(font, sizeY)
	local fontScale = 0
	local fontSize
	repeat
		fontScale = fontScale+0.03
		fontSize = dxGetFontHeight(fontScale, font)
	until fontSize >= sizeY
	return fontScale
end
fontScale = findFontToHeight("default-bold", sY*0.01)

function showCarId (cmd)
	if cmd then
		showCarIdNumberSET = not showCarIdNumberSET
	end
end
--addCommandHandler("showcarid",showCarId)

function sigVehicle()
if not showCarIdNumberSET then return end
if getElementData(localPlayer, "vehid.isAdmin") ~= true then return end
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		local vehID = getElementData(vehicle, "vehid.id")
		if vehID == false then return end
		local x, y, z = getElementPosition(vehicle)
		local cx, cy, cz = getCameraMatrix()
		if isLineOfSightClear(cx, cy, cz, x, y, z, false, false, false, false, false, false, false, vehicle) then
			local dist = getDistanceBetweenPoints3D(cx, cy, cz, x, y, z)
				for i,data in next,tableDistance do
					if dist >= data[1] and dist <= data[2] then
					local px, py = getScreenFromWorldPosition(x, y, z + 1.1, 0.06)
					if px and py then
						dxDrawText("["..vehID.."]", px+1, py+1, px+1, py+1, tocolor(0, 0, 0, 200), fontScale*data[4], "default-bold", "center", "center", false, true )
						dxDrawText("["..vehID.."]", px, py, px, py, tocolor(210, 125, 55, 255), fontScale*data[3], "default-bold", "center", "center", false, true )
					end	
				end	
			end
		end
	end
end
addEventHandler("onClientRender", root, sigVehicle)

function checkVehicleID()
	if getElementType(source) == "vehicle" then
		setTimer(triggerServerEvent, 1000, 1, "vehid.onSetVehicleID", root)
	end
end
addEventHandler("onClientElementStreamIn", root, checkVehicleID)