VehicleAccessories = {}

isPreviewObject = nil
isPreviewActivate = false

function dxDrawCordinats()
	if not isElement(isPreviewObject) then
		return
	end

	local x1, y1, z1 = getElementPosition(isPreviewObject)
				
	--X
	dxDrawLine3D(x1 - 2, y1, z1, x1 + 2, y1, z1, tocolor(255, 0, 0, 230), 1)
	dxDrawLine3D(x1 + 1, y1 - 0.2, z1, x1 + 1, y1 + 0.2, z1, tocolor(255, 0, 0, 230), 1)
	dxDrawLine3D(x1 + 2, y1 - 0.2, z1, x1 + 2, y1 + 0.2, z1, tocolor(255, 0, 0, 230), 1)
	dxDrawLine3D(x1 - 1, y1 - 0.2, z1, x1 - 1, y1 +  0.2, z1, tocolor(255, 0, 0, 230), 1)
	dxDrawLine3D(x1 - 2, y1 - 0.2, z1, x1 - 2, y1 + 0.2, z1, tocolor(255, 0, 0, 230), 1)
	--Y
	dxDrawLine3D(x1, y1 - 2, z1, x1, y1 + 2, z1, tocolor(0, 255, 0, 230), 1)
	dxDrawLine3D(x1 - 0.2, y1 + 1, z1, x1 + 0.2, y1 + 1, z1, tocolor(0, 255, 0, 230), 1)
	dxDrawLine3D(x1 - 0.2, y1 + 2, z1, x1 + 0.2, y1 + 2, z1, tocolor(0, 255, 0, 230), 1)
	dxDrawLine3D(x1 - 0.2, y1 - 1, z1, x1 + 0.2, y1 - 1, z1, tocolor(0, 255, 0, 230), 1)
	--Z
	dxDrawLine3D(x1, y1, z1 - 2, x1, y1, z1 + 2, tocolor(0, 0, 255, 230), 1)
	dxDrawLine3D(x1 - 0.2, y1, z1 + 1, x1 + 0.2, y1, z1 + 1, tocolor(0, 0, 255, 230), 1)
	dxDrawLine3D(x1 - 0.2, y1, z1 + 2, x1 + 0.2, y1, z1 + 2, tocolor(0, 0, 255, 230), 1)
	dxDrawLine3D(x1 - 0.2, y1, z1 - 1, x1 + 0.2, y1, z1 - 1, tocolor(0, 0, 255, 230), 1)

	--dxDrawText(x1..' | '..y1, 0, 0, 100, 100, tocolor(255, 0, 0, 255))

	isPreviewActivate = true
end

local isTonerP, isTonerZ, isTonerL

function VehicleAccessories.startPreviewObject(model)
	local veh = localPlayer.vehicle 

	if not isElement(veh) then 
		return 
	end

	VehicleAccessories.stopPreviewObject()

	-- Скрыть транспорт и его объекты --
	veh.alpha = 0
	localPlayer.alpha = 0

	local isAccessories = localPlayer.vehicle:getData('vehicle.isAccessories') or {}

	for _, accessories in ipairs(isAccessories) do
		accessories.object.interior = 99
		accessories.object.alpha = 0
	end

	local x, y, z = getElementPosition(veh)
    isPreviewObject = createObject(model, x, y, z)
    isPreviewObject.interior = veh.interior
    isPreviewObject.dimension = veh.dimension
    attachElements(isPreviewObject, veh, 0, 0, 0.3, 0, 0, 0)

    guiSetEnabled(GUI.btn_obj_add, true)

   -- exports.operTuningGarage:hideVehicleToner(localPlayer.vehicle)

    addEventHandler("onClientPreRender", root, dxDrawCordinats)
end

function VehicleAccessories.stopPreviewObject()
	if not isElement(isPreviewObject) then
		return
	end

	localPlayer.vehicle.alpha = 255
	localPlayer.alpha = 255

	local isAccessories = localPlayer.vehicle:getData('vehicle.isAccessories') or {}

	for _, accessories in ipairs(isAccessories) do
		accessories.object.interior = localPlayer.vehicle.interior
		accessories.object.alpha = 255
	end

	--exports.operTuningGarage:showVehicleToner(localPlayer.vehicle)

	guiSetEnabled(GUI.btn_obj_add, false)

	removeEventHandler("onClientPreRender", root, dxDrawCordinats)
	destroyElement(isPreviewObject)
end

-- Управление аксессуаром
local editorSettings = {
	key_forward = "num_8",
	key_backward = "num_2",
	key_left = "num_4",
	key_right = "num_6",
	key_up = "num_add",
	key_down = "num_sub",
}

function math.clamp(low, value, high)
    return math.max(low, math.min(value, high))
end


function VehicleAccessories.onKey()

	if isElement(isPreviewObject) then
		local step = math.clamp(0.01, -100, 100)
		local posX, posY, posZ, rotsX, rotsY, rotsZ = getElementAttachedOffsets(isPreviewObject)
		local scaleX, scaleY = getObjectScale(isPreviewObject)

		local state = false

		if step then
			local altState = getKeyState("lalt") or getKeyState("ralt")
			local ctrlState = getKeyState("lctrl") or getKeyState("rctrl")
			local shiftState = getKeyState("lshift") or getKeyState("rshift")

			if ctrlState then -- ускорение
				step = math.clamp(0.05, -100, 100)
				stepRot = math.clamp(0.2, -100, 100)
			else
				step = math.clamp(0.01, -100, 100)
				stepRot = math.clamp(0.1, -100, 100)
			end

			if getKeyState(editorSettings.key_up) then
				if altState then

					rotsZ = rotsZ + (stepRot * 4)
				elseif shiftState then -- увеличить размер
    				if scaleX < 1.3 then
    					scaleX = scaleX + 0.01
    				end
				else
					posZ = posZ + step
				end

				state = true
			elseif getKeyState(editorSettings.key_down) then
				if altState then
					rotsZ = rotsZ - (stepRot * 4)
				elseif shiftState then -- уменьшить размер
					if scaleX > 0.5 then
    					scaleX = scaleX - 0.01
    				end
				else
					posZ = posZ - step
				end

				state = true
			elseif getKeyState(editorSettings.key_forward) then
				if altState then
					rotsY = rotsY + (stepRot * 4)
				else
					posY = posY + step
				end

				state = true
			elseif getKeyState(editorSettings.key_backward) then
				if altState then
					rotsY = rotsY - (stepRot * 4)
				else
					posY = posY - step
				end

				state = true
			elseif getKeyState(editorSettings.key_right) then 
				if altState then
					rotsX = rotsX + (stepRot * 4)
				else
					posX = posX + step
				end

				state = true
			elseif getKeyState(editorSettings.key_left) then
				if altState then
					rotsX = rotsX - (stepRot * 4)
				else
					posX = posX - step
				end

				state = true
			end

			if not state then 
				return
			end

			triggerServerEvent('operVehicleObject.updateVehicleAccessories', localPlayer, localPlayer.vehicle, isPreviewObject, posX, posY, posZ, rotsX, rotsY, rotsZ, scaleX)
		end
	end
end


