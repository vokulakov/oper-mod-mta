
CockpitView = {}
local speedometerState = false
local isActive = false

-- Возможность смотреть назад
local LOOK_BACK_ENABLED = true
-- Скорость вращения камеры
local CAMERA_ROTATION_SPEED = 6
-- Угол поворота при просмотре на Q и E
local SIDE_LOOK_ANGLE = 60
local MIN_DRIFT_SPEED = 0.05

local positionOffset = Vector3()
local lookOffset =  Vector3()

local targetLookOffset = Vector3()
local currentLookOffset = Vector3()

local startCameraAngle = 0
local prevTurnVelocity = 0

-- Тряска
local SHAKE_AMOUNT = 0.012
local cameraShakeZ = 0
local cameraShakeX = 0
local cameraShakeMul = 0.9

-- Костыли
local skipFrame = false -- Пропуск первого кадра, чтобы не было видно рук

local function differenceBetweenAngles(firstAngle, secondAngle)
	local difference = secondAngle - firstAngle
	while difference < -180 do
		difference = difference + 360
	end
	while difference > 180 do
		difference = difference - 360
	end
	return difference
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

local function getVectorAngle(vector)
	return math.atan2(vector.y, vector.x)
end

local CAMERA_FPZ, CAMERA_FPY, CAMERA_FPX, CAMERA_FPR = 50, 50, 50, 50

local function update(deltaTime)	
	if skipFrame then
		skipFrame = false
		return
	end
	if not localPlayer.vehicle then
		CockpitView.stop()
		return 
	end

	offsets = {}
	
	position = CAMERA_FPZ / 600
	offsets.bz = 0.4 + position
	offsets.bx = -0.42 + CAMERA_FPX / 600

	position = CAMERA_FPY / 200
	offsets.by = - position
	offsets.ay = 1

	offsets.ax = -0.34 + CAMERA_FPX / 600
	position = CAMERA_FPZ / 600
	offsets.az = 0.35 + position

	positionOffset = Vector3(offsets.bx, offsets.by, offsets.bz)
	lookOffset = (Vector3(offsets.ax, offsets.ay, offsets.az) - positionOffset):getNormalized()

	deltaTime = deltaTime / 1000

	cameraShakeX = cameraShakeX * cameraShakeMul
	cameraShakeZ = cameraShakeZ * cameraShakeMul
	cameraShake = Vector3(cameraShakeX * (math.random() * 2 - 1), 0, cameraShakeZ * (math.random() * 2 - 1))

	local sideLookAngle = 0

	-- Обзор в стороны
	local lookLeftState = getPedControlState("vehicle_look_left")
	local lookRightState = getPedControlState("vehicle_look_right")
	if LOOK_BACK_ENABLED and lookLeftState and lookRightState then
		sideLookAngle = 180
		mouseLookX = 0 
		mouseLookY = 0
	elseif lookLeftState then 
		sideLookAngle = -SIDE_LOOK_ANGLE
		mouseLookX = 0
		mouseLookY = 0
	elseif lookRightState then
		sideLookAngle = SIDE_LOOK_ANGLE
		mouseLookX = 0
		mouseLookY = 0
	end
	-- Следование камеры за дрифтом
	local driftAngle = 0 
	if localPlayer.vehicle.onGround then
		local velocity = localPlayer.vehicle.velocity
		local speedSquared = velocity:getSquaredLength()
		local angleMul = math.min(1, speedSquared / MIN_DRIFT_SPEED)
		local velocityAngle = localPlayer.vehicle.rotation.z
		if speedSquared > 0.00001 then
			velocityAngle = math.deg(getVectorAngle(velocity)) + 270
		end
		local angleDifference = -differenceBetweenAngles(localPlayer.vehicle.rotation.z, velocityAngle)
		if math.abs(angleDifference) < 120 then
			local position = CAMERA_FPR
			driftAngle = (angleDifference * angleMul) * position / 100
		end

		-- Тряска от скорости
		cameraShakeX = cameraShakeX + math.random() / 4000 * speedSquared
		cameraShakeZ = cameraShakeZ + math.random() / 6000 * speedSquared
	end

	-- Поворот камеры
	local currentCameraAngle = math.rad(startCameraAngle + driftAngle + sideLookAngle)
	targetLookOffset = Vector3(math.sin(currentCameraAngle), math.cos(currentCameraAngle), lookOffset.z)
	currentLookOffset = currentLookOffset + (targetLookOffset - currentLookOffset) * deltaTime * CAMERA_ROTATION_SPEED
	currentLookOffset = currentLookOffset + cameraShake

	-- Положение камеры в машине
	local cameraPos = localPlayer.vehicle.matrix:transformPosition(positionOffset)
	local cameraLook = localPlayer.vehicle.matrix:transformPosition(positionOffset + currentLookOffset) 
	local cameraRoll = -localPlayer.vehicle.rotation.y
	
	-- Обновление камеры
	Camera.setMatrix(cameraPos, cameraLook, cameraRoll - cameraShake.x * 50)
end

local function updateShake(collider, force)
	if force < 60 then
		return false
	end
	local mul = math.max(math.min(10, force / 60), 0) 
	cameraShakeX = cameraShakeX + SHAKE_AMOUNT * mul * 0.9
	cameraShakeZ = cameraShakeZ + SHAKE_AMOUNT * mul * 0.2
end

local function freecamMouse()
	--getKeyState ( "mouse1" ) ~= true
end

function CockpitView.start()
	if isActive then
		return false
	end

	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)

	isActive = true
	startCameraAngle = getVectorAngle(lookOffset)
	localPlayer.alpha = 0

	addEventHandler("onClientPreRender", root, update)
	addEventHandler("onClientVehicleCollision", localPlayer.vehicle, updateShake)
	addEventHandler ("onClientCursorMove", root, freecamMouse)
	skipFrame = true
	return true
end

function CockpitView.stop()
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
    --triggerEvent('operShowUI.cleanMyScreen', localPlayer)

	isActive = false
	localPlayer.alpha = 255
	setCameraTarget(localPlayer)
	removeEventHandler("onClientPreRender", root, update)
	removeEventHandler ("onClientCursorMove", root, freecamMouse)
	if isElement(localPlayer.vehicle) then
		removeEventHandler("onClientVehicleCollision", localPlayer.vehicle, updateShake)
	end
end
--toggleControl("change_camera", true)

addEvent('operCameraViews.onClientGUIScroll', true)
addEventHandler('operCameraViews.onClientGUIScroll', root, function(x, y, z, r)
	CAMERA_FPX, CAMERA_FPY, CAMERA_FPZ, CAMERA_FPR = x, y, z, r
end)

function getCockpitViewState()
	return isActive
end

bindKey("u", "down", function()
	if localPlayer:getData('operLoginPanel:isVisible') then
		return
	end
	
	if not localPlayer.vehicle then

		if isElement(getCameraTarget()) then
            setPedAnimation(localPlayer, "PED", "gang_gunstand")
            addEventHandler("onClientPreRender", root, render)
            addEventHandler("onClientCursorMove", root, mousecalc)

            --setElementData(localPlayer, 'operCamHack:isVisible', true)

            triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
            triggerEvent('operShowUI.cleanMyScreen', localPlayer)
        else
            setPedAnimation(localPlayer, false)
            removeEventHandler ( "onClientPreRender", root, render )
            removeEventHandler ( "onClientCursorMove", root, mousecalc )
            setCameraTarget ( localPlayer )

            --setElementData(localPlayer, 'operCamHack:isVisible', false)
            triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
            triggerEvent('operShowUI.cleanMyScreen', localPlayer)
        end

		return
	end

	if not localPlayer.vehicle.controller then
		if globalX then
			return
		end
		if fpsCam then
			disableFPS()
		else
			enableFPS()
		end

		return
	end

	if not isActive then
		CockpitView.start()
	else
		CockpitView.stop()
	end
end)

addEventHandler("onClientVehicleExit", root, function(player, seat)
	if player ~= localPlayer then
		return
	end
	if seat ~= 0 then
		return
	end
	currentCamera = 1
	CockpitView.stop()
	--DriftView.stop()
end)