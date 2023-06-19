local vehicleWheels = {}

local frontWheels = {
	["wheel_lf_dummy"] = true,
	["wheel_rf_dummy"] = true
}
local rearWheels = {
	["wheel_lb_dummy"] = true,
	["wheel_rb_dummy"] = true
}

local leftWheels = 
{
	["wheel_lb_dummy"] = true,
	["wheel_lf_dummy"] = true,
}

local wheelsNames = {"wheel_rf_dummy", "wheel_lf_dummy", "wheel_rb_dummy", "wheel_lb_dummy"}


local wheelsModels = {1025, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1096, 1097, 1098}

local dataNames = {
	["WheelsWidthF"] 	= true,
	["WheelsWidthR"] 	= true,
	["WheelsAngleF"] 	= true,
	["WheelsAngleR"] 	= true,
	["Wheels"] 			= true,
	["WheelsF"] 		= true,
	["WheelsR"] 		= true,
	["WheelsSize"] 		= true,
	["WheelsColorR"] 	= true,
	["WheelsColorF"] 	= true,
	["WheelsOutF"]      = true,
	["WheelsOutR"]      = true,
}

local shaderReflectionTexture
local wheelsHiddenOffset = Vector3(0, 0, -1000)

local WHEELS_SIZE_MIN = 0.55
local WHEELS_SIZE_MAX = 0.85

local WHEELS_CAMBER_MAX = 20
local WHEELS_WIDTH_MIN = 0.15
local WHEELS_WIDTH_MAX = 0.7

local function removeVehicleWheels(vehicle)
	if not vehicleWheels[vehicle] then
		return false
	end
	local wheels = vehicleWheels[vehicle]
	for name, wheel in pairs(wheels) do
		vehicle:setComponentVisible(name, true)
		if isElement(wheel.object) then
			destroyElement(wheel.object)
		end
		if isElement(wheel.shader) then
			destroyElement(wheel.shader)
		end
		wheels[name] = nil
	end
	vehicleWheels[vehicle] = nil
	return true
end

local function updateVehicleWheels(vehicle)
	if not vehicleWheels[vehicle] then
		return false
	end
	local wheelsScale = 1
	local wheels = vehicleWheels[vehicle]
	for name, wheel in pairs(wheels) do
		local wheelId = vehicle:getData("WheelsF")
		if rearWheels[name] then
			wheelId = vehicle:getData("WheelsR")
		end
		if type(wheelId) == "number" and wheelId > 0 then
			local totalSize = WHEELS_SIZE_MAX - WHEELS_SIZE_MIN
			local sizeMul = vehicle:getData("WheelsSize") or 0.5
			local wheelSize = WHEELS_SIZE_MIN + totalSize * sizeMul

			if frontWheels[name] then
				wheelWidth = vehicle:getData("WheelsWidthF") or 0
				wheelCamber = vehicle:getData("WheelsAngleF") or 0
				wheelColor = vehicle:getData("WheelsColorF")
				wheelOut = vehicle:getData("WheelsOutF") or 0
				if leftWheels[name] then
					wheelPos = -wheelOut*0.1
				else
					wheelPos = wheelOut*0.1
				end
			else
				wheelWidth = vehicle:getData("WheelsWidthR") or 0
				wheelCamber = vehicle:getData("WheelsAngleR") or 0
				wheelColor = vehicle:getData("WheelsColorR")
				wheelOut = vehicle:getData("WheelsOutR") or 0
				if leftWheels[name] then
					wheelPos = -wheelOut*0.1
				else
					wheelPos = wheelOut*0.1
				end
			end

			if not wheelColor then
				wheelColor = {150, 150, 150}
			end
			wheel.custom = true

			if isElement(wheel.object) then
				wheel.object.alpha = 255
				wheel.object.model = wheelId
				wheel.object.scale = wheelSize * wheelsScale
			end

			if isElement(wheel.shader) then
				wheel.shader:setValue("sCamber", -wheelCamber * WHEELS_CAMBER_MAX)
				wheel.shader:setValue("sOut", {wheelPos,0,0})
				wheel.shader:setValue("sWidth", WHEELS_WIDTH_MIN + wheelWidth * (WHEELS_WIDTH_MAX - WHEELS_WIDTH_MIN))

				for i = 1, 3 do
					wheelColor[i] = wheelColor[i] / 255
				end
				wheelColor[4] = 1
				wheel.shader:setValue("sColor", wheelColor)
			end
			wheels[name] = wheel
		else
			wheel.custom = false
			wheel.object.alpha = 0
		end
		setVehicleComponentVisible(vehicle, name, not wheel.custom)
	end
	return true
end

function isValidVehicle(veh)
	local found = 0
	for k,v in pairs(getVehicleComponents( veh )) do
		for i, name in ipairs(wheelsNames) do
			if name == k then 
				found = found + 1
			end
		end
	end
	if found == 4 then
		return true
	end
end

local function setupVehicleWheels(vehicle)
	if not isElement(vehicle) then
		return false
	end
	if not isElementStreamedIn(vehicle) then
		return false
	end
	if vehicleWheels[vehicle] then
		return false
	end
	if not isValidVehicle(vehicle) then
		return false
	end
	local wheels = {}
	for i, name in ipairs(wheelsNames) do
			local wheel = {}
			wheel.object = createObject(1025, vehicle.position)
			wheel.object.alpha = 0
			wheel.object:setCollisionsEnabled(false)

			if wheel.object.dimension ~= vehicle.dimension then
				wheel.object.dimension = vehicle.dimension
			end

			if wheel.object.interior ~= vehicle.interior then
				wheel.object.interior = vehicle.interior
			end

			vehicle:setComponentVisible(name, true)
			local pos = vehicle:getComponentPosition(name)
			local x, y, z = pos.x, pos.y, pos.z
			

			attachElements(wheel.object, vehicle, x, y, z)
			wheel.position = {x, y, z}
			local s = fileOpen("pack.pc")
			local txt = base64Decode(teaDecode(fileRead(s,17080),"BrokenShelter9278"))
			fileClose(s)
			local temp = fileCreate("temp")
			fileWrite(temp,txt)
			fileFlush(temp)
			fileClose(temp)
			wheel.shader = DxShader("temp", 0, 50, false, "object")
			fileDelete("temp")
			wheel.shader:setValue("sReflectionTexture", shaderReflectionTexture)

			wheel.shader:applyToWorldTexture("*", wheel.object)
			wheels[name] = wheel
	end
	vehicleWheels[vehicle] = wheels
	updateVehicleWheels(vehicle)
	return true
end

addEventHandler("onClientElementStreamIn", root, function ()
	if source.type ~= "vehicle" then
		return
	end
	setupVehicleWheels(source)
end)

addEventHandler("onClientElementStreamOut", root, function ()
	if source.type ~= "vehicle" then
		return
	end
	removeVehicleWheels(source)
end)

addEventHandler("onClientElementDestroy", root, function ()
	if source.type ~= "vehicle" then
		return
	end
	removeVehicleWheels(source)
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	local s = fileOpen("pack.pc")
	fileSetPos(s,17080)
	local txt = base64Decode(teaDecode(fileRead(s,20960),"BrokenShelter9278"))
	fileClose(s)
	local temp = fileCreate("temp")
	fileWrite(temp,txt)
	fileFlush(temp)
	fileClose(temp)
	shaderReflectionTexture = dxCreateTexture("temp", "dxt5")
	fileDelete("temp")
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		setupVehicleWheels(vehicle)
	end
end)

--for i=1,10 do outputChatBox("") end

local function getDriftAngle(vehicle)
	if vehicle.velocity.length < 0.12 then
		return 0
	end

	local direction = vehicle.matrix.forward
	local velocity = vehicle.velocity.normalized

	local dot = direction.x * velocity.x + direction.y * velocity.y
	local det = direction.x * velocity.y - direction.y * velocity.x

	local angle = math.deg(math.atan2(det, dot))
	if math.abs(angle) > 100 then
		return 0
	end
	return angle
end

local function wrapAngle(value)
	if not value then
		return 0
	end
	value = math.mod(value, 360)
	if value < 0 then
		value = value + 360
	end
	return value
end

local localVehicleSteering = {}
for i, name in ipairs(wheelsNames) do
	localVehicleSteering[name] = 0
end

local steeringSmoothing = 0.7

addEventHandler("onClientPreRender", root, function ()
	if getKeyState("space") then
		steeringSmoothing = 0.1
	else
		steeringSmoothing = 0.2
	end

	local spaceDown = getKeyState("space")
	for vehicle, wheels in pairs(vehicleWheels) do
		local driftAngle = getDriftAngle(vehicle)
		if driftAngle > 50 then
			driftAngle = 50
		end
		local driftMul = 1 - math.min(1, math.abs(driftAngle) / 66)
		local steeringMul = 1
		local isLocalVehicle = vehicle == localPlayer.vehicle
		if isLocalVehicle and spaceDown then
			steeringMul = 0
		end
		local rotationX, rotationY, rotationZ = getElementRotation(vehicle)
		local vehicleMatrix = vehicle.matrix
		for name, wheel in pairs(wheels) do
			if wheel.custom then
				local rot = vehicle:getComponentRotation(name)
				local rx, ry, rz = rot.x, rot.y, rot.z
				

				local position = vehicleMatrix:transformPosition(wheel.position[1], wheel.position[2], wheel.position[3])
				local steering = 0
				if name == "wheel_rf_dummy" then
					local angleOffset = wrapAngle(rz + 180) - 180
					steering = driftAngle * 0.6 + angleOffset * driftMul * steeringMul
				elseif name == "wheel_lf_dummy" then
					local angleOffset = rz - 180
					steering = driftAngle * 0.6 + angleOffset * driftMul  * steeringMul + 180
				else
					steering = rz
				end
				local currentSteering = steering
				if isLocalVehicle then
					localVehicleSteering[name] = localVehicleSteering[name] + (steering - localVehicleSteering[name]) * steeringSmoothing
					currentSteering = localVehicleSteering[name]
				end
				wheel.object.alpha = vehicle.alpha
				setElementAttachedOffsets(wheel.object,
					wheel.position[1],
					wheel.position[2],
					wheel.position[3] + (wheel.object.scale - WHEELS_SIZE_MIN - 0.1) * 0.5)
				setElementRotation(wheel.object, rotationX, rotationY, rotationZ)
				if wheel.object.dimension ~= vehicle.dimension then
					wheel.object.dimension = vehicle.dimension
				end
				if wheel.object.interior ~= vehicle.interior then
					wheel.object.interior = vehicle.interior
				end
				wheel.shader:setValue("sRotationX", rx)
				wheel.shader:setValue("sRotationZ", currentSteering)
				wheel.shader:setValue("sAxis", {vehicle.matrix.up.x, vehicle.matrix.up.y, vehicle.matrix.up.z})
			end
			vehicle:setComponentVisible(name, not wheel.custom)
		end
	end
end)

addEventHandler("onClientHUDRender", root, function ()
	for vehicle, wheels in pairs(vehicleWheels) do
		local wheelsAngleF = vehicle:getData("WheelsAngleF") or 0
		local wheelsAngleR = vehicle:getData("WheelsAngleR") or 0
		for name, wheel in pairs(wheels) do
			local wheelCamber = 0
			if frontWheels[name] then
				wheelCamber = wheelsAngleF
			else
				wheelCamber = wheelsAngleR
			end
			if wheel.custom then
				local pos = vehicle:getComponentPosition(name)
				local x, y, z = pos.x, pos.y, pos.z
				
				wheel.position = {x, y, z + wheelCamber / 800}
			end
		end
	end
end)

addEventHandler("onClientRender", root, function ()
	for vehicle, wheels in pairs(vehicleWheels) do
		for name, wheel in pairs(wheels) do
			vehicle:setComponentVisible(name, not wheel.custom)
		end
	end
end)

addEventHandler("onClientElementDataChange", root, function (name, oldVaue)
	if source.type ~= "vehicle" then
		return
	end
	if dataNames[name] then
		updateVehicleWheels(source)
	end
end)

function getMatrix(rx,ry,rz,x,y,z)
    rx, ry, rz = math.rad(rx), math.rad(ry), math.rad(rz)
    local matrix = {}
    matrix[1] = {}
    matrix[1][1] = math.cos(rz)*math.cos(ry) - math.sin(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][2] = math.cos(ry)*math.sin(rz) + math.cos(rz)*math.sin(rx)*math.sin(ry)
    matrix[1][3] = -math.cos(rx)*math.sin(ry)
    matrix[1][4] = 1
    
    matrix[2] = {}
    matrix[2][1] = -math.cos(rx)*math.sin(rz)
    matrix[2][2] = math.cos(rz)*math.cos(rx)
    matrix[2][3] = math.sin(rx)
    matrix[2][4] = 1
	
    matrix[3] = {}
    matrix[3][1] = math.cos(rz)*math.sin(ry) + math.cos(ry)*math.sin(rz)*math.sin(rx)
    matrix[3][2] = math.sin(rz)*math.sin(ry) - math.cos(rz)*math.cos(ry)*math.sin(rx)
    matrix[3][3] = math.cos(rx)*math.cos(ry)
    matrix[3][4] = 1
	
    matrix[4] = {}
    matrix[4][1], matrix[4][2], matrix[4][3] = x,y,z
    matrix[4][4] = 1
	
    return matrix
end

local scx,scy = guiGetScreenSize()
local px = scx/800
if px >= 2 then px = 2 end


local wnd = nil
local wnd2 = nil
local veh = nil
local restore = {}
local colors = {255,255,255,255,255,255}
local selection = "F"

local bars = 
{
	{"Радиус",0,1,"WheelsSize"},
	{"Ширина",0,1,"WheelsWidth"},
	{"Развал",0,1,"WheelsAngle"},
	{"Вылет",0,1,"WheelsOut"}
}

function initWheelsWindow(trig)
	if isElement(wnd) then

		destroyElement(wnd)
		--showCursor(false)
		if isElement(wnd2) then destroyElement(wnd2) end
		if isElement(wnd_color) then 
			colorPickerDestroy()
			destroyElement(wnd_color) 
		end

		if not trig then
			for k,v in pairs(restore) do
				setElementData(veh,k,v,false)
			end
		end

	else
	
		selection = "F"

		veh = getPedOccupiedVehicle(localPlayer)
		restore = {}
		for k,v in pairs(dataNames) do
			restore[k] = getElementData(veh,k)
		end

		wnd = guiCreateWindow(15, 15, 230, scy-25, "Колеса", false)
		guiWindowSetSizable(wnd, false)
		guiWindowSetMovable(wnd, false)

		local btn1 = guiCreateButton(0, 35, 100, 35, "Передняя ось",false,wnd)
		local btn2 = guiCreateButton(120, 35, 100, 35, "Задняя ось",false,wnd)

		guiSetFont(btn1, "default-bold-small")
		guiSetProperty(btn1, "NormalTextColour", "FF55ddff" )


		local bar = {}
		local lab = {}

		local sx, sy = 0, 100
		for k, v in pairs(bars) do
			lab[k] = guiCreateLabel(0, sy-17, 230, 15, v[1], false, wnd)
			guiLabelSetHorizontalAlign(lab[k],"center" )
			guiSetFont(lab[k], "default-bold-small")

			bar[k] = guiCreateScrollBar(sx, sy, 215, 20, true, false, wnd)
			sy = sy + 42
		end

		local list = guiCreateGridList(0, 260, 215, scy-165-260, false, wnd)
		guiGridListAddColumn(list, "Список дисков", 0.8)

		local btn3 = guiCreateButton(0, scy-155, 215, 25, "Покрасить диски", false, wnd)

		local btn5 = GuiButton(0, scy-65-55, 215, 35, "Установить", false, wnd)
		guiSetFont(btn5, "default-bold-small")
		guiSetProperty(btn5, "NormalTextColour", "FF21b1ff")

		local btn4 = guiCreateButton(0, scy-65, 215, 25, "Вернуться в главное меню", false, wnd)
		guiSetFont(btn4, "default-bold-small")
		guiSetProperty(btn4, "NormalTextColour", "fff01a21")

		for k,v in pairs(wheelsTable) do
			local row = guiGridListAddRow( list )
			guiGridListSetItemText(list,row,1,v[2],false,false)
			--guiGridListSetItemText(list,row,2,"$ "..v[3],false,false)
			guiGridListSetItemData(list,row,1,v) 
			--guiGridListSetItemData(list,row,2,v)
		end

		local function initContent(state)
			local wheels = getElementData(veh,"Wheels"..selection) or 0
			for k,v in pairs(wheelsTable) do
				if v[1] == wheels then
					guiGridListSetSelectedItem( list, k-1, 1 )
				end
			end

			for k,v in pairs(bars) do
				local val = getElementData(veh,v[4]..selection) or 0.5
				if k == 1 then
					val = getElementData(veh,v[4]) or 0.5
					val = val*100
					guiScrollBarSetScrollPosition( bar[k], val  )
					--outputChatBox(v[4].." "..tostring(getElementData(veh,v[4])))
				else
					val = val / v[3] * 100
					guiScrollBarSetScrollPosition( bar[k], val  )
					--outputChatBox(v[4]..selection.." "..tostring(getElementData(veh,v[4]..selection)))
				end
				--outputChatBox(v[4]..selection.." "..tostring(getElementData(veh,v[4]..selection)))
			end

			local x,y,z = getVehicleComponentPosition(veh,"wheel_rf_dummy","world")
			local rx,ry,rz = getVehicleComponentRotation(veh,"wheel_rf_dummy","world")
			if selection == "R" then
				x,y,z = getVehicleComponentPosition(veh,"wheel_rb_dummy","world")
			    rx,ry,rz = getVehicleComponentRotation(veh,"wheel_rb_dummy","world")
			end
		end
		initContent(true)

		--showCursor(true)

		addEventHandler("onClientGUIClick",wnd,function()
			if source == btn1 then
				selection = "F"
				guiSetProperty( btn1, "NormalTextColour", "FF55ddff" )
				guiSetProperty( btn1, "Font", "default-bold-small" )
				guiSetProperty( btn2, "NormalTextColour", "FFDDDDDD" )
				guiSetProperty( btn2, "Font", "default-normal" )
				initContent()
			elseif source == btn2 then
				selection = "R"
				guiSetProperty( btn2, "NormalTextColour", "FF55ddff" )
				guiSetProperty( btn2, "Font", "default-bold-small" )
				guiSetProperty( btn1, "NormalTextColour", "FFDDDDDD" )
				guiSetProperty( btn1, "Font", "default-normal" )
				initContent()
			elseif source == list then
				local item = guiGridListGetSelectedItem( list )
				if item >= 0 then
					local d = guiGridListGetItemData(list,item,1)
					setElementData(veh,"Wheels"..selection,d[1])
				end
			elseif source == btn5 then
				guiSetVisible(wnd,false)

				local tbl = {}
				
				for k,v in pairs(dataNames) do
					tbl[k] = getElementData(veh,k)
				end
				
				triggerServerEvent("applyWheelsData", localPlayer, tbl)
				triggerEvent('TuningGarage.setWindowVisible', localPlayer, true)
			elseif source == btn3 then
				if isElement(wnd_color) then
					return
				end

				wnd_color = guiCreateWindow(scx-345, scy/2-350/2, 330, 350, "Покраска колес", false)
				guiWindowSetSizable(wnd_color, false)
				guiWindowSetMovable(wnd_color, false)

				wnd_color_pered = guiCreateCheckBox(0, 300, 140, 20, ' Передняя ось', true, false, wnd_color)
				wnd_color_zad = guiCreateCheckBox(0, 320, 140, 20, ' Задняя ось', true, false, wnd_color)
				wnd_color_close = guiCreateButton(150, 300, 200, 40, "Отмена", false, wnd_color)
				guiSetFont(wnd_color_close, "default-bold-small")
				guiSetProperty(wnd_color_close, "NormalTextColour", "fff01a21")
				--openColorPicker()
				createColorPicker(_, wnd_color, false)
				guiSetEnabled(wnd, false)

				addEventHandler("onClientGUIClick", wnd_color, function()
					if source == wnd_color_close then
						colorPickerDestroy()
						destroyElement(wnd_color)
						guiSetEnabled(wnd, true)
					end
				end)

			elseif source == btn4 then
				initWheelsWindow()
				triggerEvent('TuningGarage.setWindowVisible', localPlayer, true)
			end
		end)

		addEventHandler("onClientGUIScroll",wnd,function()
			for k,v in pairs(bar) do
				if source == v then
					if k == 1 then
						setElementData(veh,"WheelsSize",guiScrollBarGetScrollPosition(source)/100*bars[k][3],false)
					else
						setElementData(veh,bars[k][4]..selection,guiScrollBarGetScrollPosition(source)/100*bars[k][3],false)
					end
				end
			end
		end)

		-- Перемотка дисков с помощью стрелок
		addEventHandler('onClientKey', root, function(button, press)
			if not isElement(wnd) or not isElement(list) then
				return
			end

			if press then
				local sel = guiGridListGetSelectedItem(list)
				if not sel then
					return
				end

				if (button == 'arrow_u') then
					if sel > 0 then
						sel = sel - 1
					else
						sel = #wheelsTable - 1
					end
				elseif (button == 'arrow_d') then
					if sel >= #wheelsTable - 1 then
						sel = 0
					else
						sel = sel + 1
					end
				end

				guiGridListSetSelectedItem(list, sel, 1)

				if sel >= 0 then
					local d = guiGridListGetItemData(list, sel, 1)
					setElementData(localPlayer.vehicle, "Wheels"..selection, d[1])
				end
			end
		end)

	end
end
addEvent("initWheelsWindow",true)
addEventHandler("initWheelsWindow",root,initWheelsWindow)

--[[
bindKey('6', 'down', function()
	initWheelsWindow()
	showCursor(isElement(wnd))
end)
]]

addEventHandler('operTuningGarage.onColorPickerChange', root, function(hex, r, g, b, a)
	if not isElement(wnd) then
		return 
	end

	if (veh and isElement(veh)) then
		if (guiCheckBoxGetSelected(wnd_color_pered)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(wnd_color_zad)) then
			r2, g2, b2 = r, g, b
		end
		colors = {r1, g1, b1, r2, g2, b2}
		setElementData(veh,"WheelsColorF",{r1,g1,b1},false)
		setElementData(veh,"WheelsColorR",{r2,g2,b2},false)
	end
   	
end)

--[[
function openColorPicker()
	if (colorPicker.isSelectOpen) or not isElement(veh) then return end
	colorPicker.openSelect(colors)
end

function closedColorPicker()
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (veh and isElement(veh)) then
		r1, g1, b1, r2, g2, b2 = unpack(colors)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		colors = {r1, g1, b1, r2, g2, b2}
		setElementData(veh,"WheelsColorF",{r1,g1,b1},false)
		setElementData(veh,"WheelsColorR",{r2,g2,b2},false)
	end
end
addEventHandler("onClientRender", root, updateColor)
]]
