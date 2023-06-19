local x, y = guiGetScreenSize()
MAX_CAMERA_FOV = 100
MIN_CAMERA_FOV = 30

MAX_DISTANCE_FROM_PLAYER_ATTACH = 5
MAX_DISTANCE_FROM_PLAYER = 40 * 10
SPEED_SLOWER_MUL = 0.1
SPEED_FASTER_MUL = 2.5
SMOOTH_MOVEMENT_SPEED = 0.008
SMOOTH_LOOK_SPEED = 0.004

DEFAULT_MOVE_SPEED = 0.02
DEFAULT_MOUSE_SPEED = 0.001
CUSTOM_MOUSE_SPEED = 0.0002
DEFAULT_MAX_SPEED = 12

local cameraPosition
utils = {
	integer = 0,
    alpha = false,
	smoth = false,
	info = true,
	move_speed = DEFAULT_MOVE_SPEED,
	roll_speed = 0.02,
	mouse_speed = DEFAULT_MOUSE_SPEED,
	invertMouseLook = false,
	normalMaxSpeed = 2, -- обычная скорость первого режима
	slowMaxSpeed = 0.2, -- минимальная скорость
	fastMaxSpeed = DEFAULT_MAX_SPEED, -- с шифтом
	smoothMovement = true,
	maxYAngle = 188,
	key_fastMove = "lshift",
	key_slowMove = "lalt",
	key_forward = "forwards",
	key_backward = "backwards",
	key_left = "left",
	key_right = "right",
	key_forward_veh = "accelerate",
	key_backward_veh = "brake_reverse",
	key_left_veh = "vehicle_left",
	key_right_veh = "vehicle_right"
}

local control = {
	["forwards"] = "w",
	["backwards"] = "s",
	["info"] = "i",
	["left"] = "a",
	["right"] = "d",
	["qq"] = "q",
	["ee"] = "e",
	["accelerate"] = "w",
	["brake_reverse"] = "s",
	["vehicle_left"] = "a",
	["vehicle_right"] = "d",
	["move_up"] = "space",
	["move_down"] = "lctrl"
}

weather = {
	{1, "Blue sky with clouds [1]"},
	{2, "Blue sky with clouds [2]"},
	{3, "Blue sky with clouds [3]"},
	{4, "Blue sky with clouds [4]"},
	{5, "Blue sky with clouds [5]"},
	{6, "Blue sky with clouds [6]"},
	{7, "Blue sky with clouds [7]"},
	{8, "Storm [8]"},
	{9, "Foggy [9]"},
	{10, "Clear blue sky [10]"},
	{11, "Hot, heat waves [11]"},
	{12, "Dull, hazy [12]"},
	{13, "Dull, hazy [13]"},
	{14, "Dull, hazy [14]"},
	{15, "Dull, hazy [15]"},
	{16, "Dull, cloudy, rainy [16]"},
	{17, "Very hot [17]"},
	{18, "Very hot [18]"},
	{19, "Sand storm [19]"}
}


local screenW, screenH = guiGetScreenSize()
local cameraPosition
local cameraPositionActual
local cameraDirection
local cameraSpeed
local cameraFOV
local cameraFOVActual
local cameraRoll
local cameraRollActual

local rotationX = 0
local actualRotationX = 0
local rotationY = 0
local actualRotationY = 0
local isSmoothneess

-- по чекбоксам
function startSmoth()
	rotationX = 0
	isSmoothneess = true
end

function stopSmoth()
	cameraPosition = cameraPositionActual
	rotationX = actualRotationX
	rotationY = actualRotationY
	cameraRoll = cameraRollActual
	cameraFOV = cameraFOVActual
	isSmoothneess = false
end
--

local function adjustFOV(integer)
	cameraFOV = cameraFOV + integer
	if cameraFOV > MAX_CAMERA_FOV then
		cameraFOV = MAX_CAMERA_FOV
	elseif cameraFOV < MIN_CAMERA_FOV then
		cameraFOV = MIN_CAMERA_FOV
	end
end

local infoImage
local infoRenderImage_Anim_state = nil

function renderImage(  )
	local width, height = dxGetMaterialSize( infoImage )
	if infoRenderImage_Anim_state then
		local x1, y1, z1 = interpolateBetween(screenW * 0.0052, 0, 0, screenW * -0.5, 0, 0, ((getTickCount() - open) / 1500), "Linear")
		dxDrawImage ( x1, screenH/2-height/2, width, height, infoImage)
	else
		local x1, y1, z1 = interpolateBetween(screenW * -0.1, 0, 0, screenW * 0.0052, 0, 0, ((getTickCount() - open) / 800), "Linear")
		dxDrawImage ( x1, screenH/2-height/2, width, height, infoImage)
	end
end

function createRenderTexture( )
	if not infoRenderImage and (not infoImage) then
		infoImage = dxCreateTexture( "images/info.png"  )
		removeEventHandler("onClientRender", root, renderImage)
		addEventHandler("onClientRender", root, renderImage)
		open = getTickCount()
		infoRenderImage = true
	end
end

--
local function render(dt)
	if not camhack_start then
		return
	end
	if mainmenu_start then
		return
	end
	if isMTAWindowActive() or isCursorShowing() then
		updateFramesDelay = 10
		return
	elseif updateFramesDelay > 0 then
		updateFramesDelay = updateFramesDelay - 1
		return
	end
	if utils.info == true then
		createRenderTexture()
	else

	end
	if getKeyState(control["qq"]) then
		cameraRoll = cameraRoll + utils.roll_speed * dt
	elseif getKeyState(control["ee"]) then
		cameraRoll = cameraRoll - utils.roll_speed * dt
	end

	local cameraForward = Camera.matrix.forward
	local cameraRight = Vector3(cameraForward.y, -cameraForward.x, 0):getNormalized()
	cameraSpeed = Vector3(0, 0, 0) 
	if getKeyState(control["forwards"]) then
		cameraSpeed = cameraSpeed + cameraForward
	elseif getKeyState(control["backwards"]) then
		cameraSpeed = cameraSpeed - cameraForward
	end
	if getKeyState("-") or getKeyState("=")  then
		adjustFOV(2 * (getKeyState("=") and -1 or 1))
	end

	if getKeyState(control["right"]) then
		cameraSpeed = cameraSpeed + cameraRight
	elseif getKeyState(control["left"]) then
		cameraSpeed = cameraSpeed - cameraRight
	end

	if getKeyState(control["move_up"]) then
		cameraSpeed = cameraSpeed + Vector3(0, 0, 0.1)
	elseif getKeyState(control["move_down"]) then
		cameraSpeed = cameraSpeed - Vector3(0, 0, 0.1)
	end

	cameraSpeed = utils.move_speed * cameraSpeed:getNormalized()
	if getKeyState(utils.key_slowMove) then
		cameraSpeed = cameraSpeed * utils.slowMaxSpeed
	elseif getKeyState(utils.key_fastMove) then
		cameraSpeed = cameraSpeed * utils.fastMaxSpeed
	end
	cameraPosition = cameraPosition + dt * cameraSpeed

	local distance = cameraPosition - localPlayer.position
	if (distance.length) > MAX_DISTANCE_FROM_PLAYER then
		cameraPosition = localPlayer.position + distance:getNormalized() * MAX_DISTANCE_FROM_PLAYER
	end

	if isSmoothneess then
		rotationX = rotationX * 0.97
		cameraPositionActual = cameraPositionActual + (cameraPosition - cameraPositionActual) * dt * SMOOTH_MOVEMENT_SPEED
		actualRotationX = actualRotationX + rotationX * dt * SMOOTH_LOOK_SPEED
		actualRotationY = actualRotationY + differenceBetweenAnglesRadians(actualRotationY, rotationY) * dt * SMOOTH_LOOK_SPEED
		cameraRollActual = cameraRollActual + (cameraRoll - cameraRollActual) * dt * SMOOTH_MOVEMENT_SPEED
		cameraFOVActual = cameraFOVActual + (cameraFOV - cameraFOVActual) * dt * SMOOTH_MOVEMENT_SPEED
	else
		cameraPositionActual = cameraPosition
		actualRotationX = rotationX
		actualRotationY = rotationY
		cameraRollActual = cameraRoll
		cameraFOVActual = cameraFOV
	end
	cameraDirection.x = cameraPosition.x + dt * 100 * math.cos(actualRotationY) * math.sin(actualRotationX)
	cameraDirection.y = cameraPosition.y + dt * 100 * math.cos(actualRotationY) * math.cos(actualRotationX)
	cameraDirection.z = cameraPosition.z + dt * 100 * math.sin(actualRotationY)

	setCameraMatrix(cameraPositionActual, cameraDirection, cameraRollActual, cameraFOVActual)
end

local function onCursorMove(cX, cY, aX, aY)
	if isMTAWindowActive() or isCursorShowing() then
		mouseFrameDelay = 10
		return
	elseif mouseFrameDelay > 0 then
		mouseFrameDelay = mouseFrameDelay - 1
		return
	end

	local width, height = guiGetScreenSize()

	aX = aX - width / 2
	aY = aY - height / 2

	local sensitivity = utils.mouse_speed
	if isSmoothneess then
		sensitivity = sensitivity / 3
	end
	if isSmoothneess then
		rotationX = rotationX + aX * sensitivity * 0.6
	else
		rotationX = rotationX + aX * sensitivity
	end
	rotationY = rotationY - aY * sensitivity
	local PI = math.pi
	if rotationY > PI then
		rotationY = rotationY - 2 * PI
	elseif rotationY < -PI then
		rotationY = rotationY + 2 * PI
	end

	if rotationY < - PI / 2.05 then
		rotationY = -PI / 2.05
	elseif rotationY > PI / 2.05 then
		rotationY = PI / 2.05
	end
end

-- функцию для работы с настройками
function checkToOpen( )
	removeEdit("hours")
	removeEdit("minutes")
	stopSettingMenu(  )
	if mainmenu_start then
		stopMainMenu()
	elseif weather_start then
		stopWeatherMainMenu()
	end
end

function startMainMenu(  )
	checkToOpen()
	mainmenu_start = true
	showCursor(true)
	scroll1 = (x - 385) / 2 + (3850*utils.move_speed)
	scroll2 = ((x - 385) / 2) + (22*utils.fastMaxSpeed)
	addEventHandler('onClientRender', root, mainmenu_render)
end

function stopMainMenu(  )
	mainmenu_start = false
	showCursor(false)
	removeEventHandler('onClientRender', root, mainmenu_render)
end

function startWeatherMainMenu(  )
	checkToOpen()
	weather_start = true
	showCursor(true)
	k = 1
	addEventHandler('onClientRender', root, weather_render)
end

function stopWeatherMainMenu(  )
	removeEdit("hours")
	removeEdit("minutes")
	weather_start = false
	showCursor(false)
	removeEventHandler('onClientRender', root, weather_render)
end

local function startSettingMenu(  )
	checkToOpen()
	setting_start = true
	showCursor(true)
	addEventHandler('onClientRender', root, setting_render)
end

function stopSettingMenu( )
	setting_start = false
	showCursor(false)
	removeEventHandler('onClientRender', root, setting_render)
end
--

-- export
function getCamHackState()
	if camhack_start then
		return true
	else
		return false
	end
end
--

local function onKey(key, isDown)
	if not isDown then
		return false
	end
	if key == "mouse_wheel_up" or key == "mouse_wheel_down" then
		adjustFOV(4 * (key == "mouse_wheel_up" and -1 or 1))
	end
	if key == "i" then
		open = getTickCount()
		infoRenderImage_Anim_state = not infoRenderImage_Anim_state
	end
	if key == "o" then
		if setting_start then
			stopSettingMenu()
		else
			startSettingMenu()
		end
	end
	if key == "escape" and not (weather_start) and not (mainmenu_start) then
		cancelEvent()
		stopSettingMenu( )
		if camhack_start then
			open = getTickCount()
			stopCamHack()
		end
	end
end

addEventHandler("onClientKey", root, function(key, isDown)
	if not isDown then
		return false
	end

	local screenshotBoundKeys = getBoundKeys("screenshot")
	if screenshotBoundKeys then
		for screenshotKey, state in pairs(screenshotBoundKeys) do
			if key == screenshotKey then
				fadeCamera(false, 0.5, 255, 255, 255) 
				setTimer(fadeCamera, 150, 1, true, 0.5) 
				Sound("sound.wav")
			end
		end
	end
end)

local function checkCamHack()
	if camhack_start then
		stopCamHack()
	else
		startCamHack()
	end
end

function startCamHack()
	if camhack_start then
		return false
	end
	setElementData(localPlayer, 'operCamHack:isVisible', true)

	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
	triggerEvent('operShowUI.cleanMyScreen', localPlayer)
	
	showChat(false)
	--setPlayerHudComponentVisible ( "radar", false )
	camhack_start = true
	savedWeather = getWeather()
	currentWeather = 0
	cameraRoll = 0
	rotationX, rotationY = 0, 0
	mouseFrameDelay, updateFramesDelay = 0, 0
	isSmoothneess = false
	if localPlayer.vehicle then
		cameraFOV = Camera.getFieldOfView("vehicle")
	else
		cameraFOV = Camera.getFieldOfView("player")
	end
	cameraSpeed = Vector3(0, 0, 0)
	cameraDirection = Vector3(0, 0, 0)
	cameraPosition = Camera.matrix.position

	local direction = (Camera.matrix.forward):getNormalized()
	rotationX = math.atan2(direction.x, direction.y)
	if direction.length ~= 0 then
		rotationY = math.asin(direction.z / direction.length)
	end
	toggleAllControls(false)
	
	addEventHandler("onClientPreRender", root, render)
	addEventHandler("onClientCursorMove", root, onCursorMove)
	addEventHandler("onClientKey", root, onKey)
	-- 
	cameraPositionActual = cameraPosition
	actualRotationX = rotationX
	actualRotationY = rotationY
	cameraRollActual = cameraRoll
	cameraFOVActual = cameraFOV
end

function stopCamHack(  )
	if not camhack_start then
		return
	end

	setElementData(localPlayer, 'operCamHack:isVisible', false)
	triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
	triggerEvent('operShowUI.cleanMyScreen', localPlayer)

	if not infoRenderImage_Anim_state then
		infoRenderImage_Anim_state = true
		setTimer(function (  )
			infoRenderImage = nil
			removeEventHandler("onClientRender", root, renderImage)
			infoRenderImage_Anim_state = nil
			if infoImage then 
				destroyElement(infoImage)
				infoImage = nil
			end
		end, 200, 1)
	else
		infoRenderImage = nil
		removeEventHandler("onClientRender", root, renderImage)
		infoRenderImage_Anim_state = nil
		destroyElement(infoImage)
		infoImage = nil
	end
	--setPlayerHudComponentVisible ( "radar", true )
	-- сброс настроек
	if isTimer(timerAlpha) then killTimer(timerAlpha) end
	utils.smoth = false
	utils.alpha = false
	localPlayer.alpha = 255
	utils.move_speed = DEFAULT_MOVE_SPEED
	utils.fastMaxSpeed = DEFAULT_MAX_SPEED
	--
	showChat(true)
	camhack_start = false
	setCameraTarget(localPlayer)
	if savedWeather then setWeather(savedWeather) end
	toggleAllControls(true)
	toggleControl("radar", false) -- отключение стандартной карты
	
	removeEventHandler("onClientPreRender", root, render)
	removeEventHandler("onClientCursorMove", root, onCursorMove)
	removeEventHandler("onClientKey", root, onKey)
	-- пишешь тут свою экспортную функцию на сброс времени
end
--addCommandHandler("camhack", checkCamHack)

local function restartScript( )
	stopCamHack()
	setTimer(function()
		camhack_start = nil
	end, 1000, 1)
end
addEventHandler("onClientResourceStop", resourceRoot, restartScript, true, "high")

addEventHandler ( "onClientPlayerWasted", localPlayer, function (  )
	stopCamHack()
end )

