local MOUSE_LOOK_SPEED = 200
local MOUSE_LOOK_VERTICAL_MAX = 45
local MOUSE_LOOK_VERTICAL_MIN = 0

local MOUSE_LOOK_DISTANCE_DELTA = 0.5
local MOUSE_LOOK_DISTANCE_MIN = 3
local MOUSE_LOOK_DISTANCE_MAX = 6

local screenSize = Vector2(guiGetScreenSize())

local isActive = false
local mouseLookActive = false
local mouseScrollEnabled = true
local oldCursorPosition
local skipMouseMoveEvent = false

-- Состояние камеры
local camera = {
    targetPosition = Vector3(0, 0, 0),
    rotationHorizontal = -28,
    rotationVertical = 15,
    distance = MOUSE_LOOK_DISTANCE_MAX,
    FOV = 70,
    roll = 0,
    -- Смещение центра камеры вправо, чтобы машины не перекрывалась левой панелью
    centerOffset = 0.9
}

local function update(deltaTime)
    deltaTime = deltaTime / 1000

    -- Прикрепить камеру к автомобилю
    if localPlayer.vehicle then
        camera.targetPosition = localPlayer.vehicle.position
    end

    local pitch = math.rad(camera.rotationVertical)
    local yaw = math.rad(camera.rotationHorizontal)
    local cameraOffset = Vector3(math.cos(yaw) * math.cos(pitch), math.sin(yaw) * math.cos(pitch), math.sin(pitch))
    local rotationOffset = Vector3(math.cos(yaw - 90), math.sin(yaw - 90), 0) * camera.centerOffset
    setCameraMatrix(
        camera.targetPosition + cameraOffset * camera.distance,
        camera.targetPosition + rotationOffset,
        camera.roll,
        camera.FOV
    )
end

local function mouseMove(x, y)
    if not mouseLookActive or isMTAWindowActive() then
        return
    end
    -- Пропустить первый эвент, чтобы избежать резкого дёргания камеры
    if skipMouseMoveEvent then
        skipMouseMoveEvent = false
        return
    end
    local mx = x - 0.5
    local my = y - 0.5
    camera.rotationHorizontal = camera.rotationHorizontal - mx * MOUSE_LOOK_SPEED
    camera.rotationVertical = camera.rotationVertical + my * MOUSE_LOOK_SPEED

    if camera.rotationVertical > MOUSE_LOOK_VERTICAL_MAX then
        camera.rotationVertical = MOUSE_LOOK_VERTICAL_MAX
    elseif camera.rotationVertical < MOUSE_LOOK_VERTICAL_MIN then
        camera.rotationVertical = MOUSE_LOOK_VERTICAL_MIN
    end
end

local function handleKey(key, down)
    if down and mouseScrollEnabled then
        if key == "mouse_wheel_down" then
            camera.distance = camera.distance + MOUSE_LOOK_DISTANCE_DELTA
            if camera.distance > MOUSE_LOOK_DISTANCE_MAX then
                camera.distance = MOUSE_LOOK_DISTANCE_MAX
            end
        elseif key == "mouse_wheel_up" then
            camera.distance = camera.distance - MOUSE_LOOK_DISTANCE_DELTA
            if camera.distance < MOUSE_LOOK_DISTANCE_MIN then
                camera.distance = MOUSE_LOOK_DISTANCE_MIN
            end
        end
    end

    if key == "mouse2" then
        -- Включить/выключить свободный обзор
        if down then
            -- Сохранить положение курсора
            oldCursorPosition = Vector2(getCursorPosition())
            -- Переместить курсор в центр, чтобы избежать дёргания камеры
            setCursorPosition(screenSize.x / 2, screenSize.y / 2)
            guiSetInputEnabled(false) 
            showCursor(false)

            mouseLookActive = true
            skipMouseMoveEvent = true
        else
            mouseLookActive = false
            guiSetInputEnabled(true) 
            showCursor(true)

            -- Восстановить положение курсора
            setCursorPosition(oldCursorPosition.x * screenSize.x, oldCursorPosition.y * screenSize.y)
        end
    end
end

local function disableScroll()
    mouseScrollEnabled = false
end

local function enableScroll()
    mouseScrollEnabled = true
end

function startTuningCamera()
    if isActive then
        return
    end
    --showCursor(true)

    isActive = true
    mouseScrollEnabled = true
    addEventHandler("onClientPreRender", root, update)
    addEventHandler("onClientCursorMove", root, mouseMove)
    addEventHandler("onClientKey", root, handleKey)
    addEventHandler("onClientMouseEnter", root, disableScroll)
    addEventHandler("onClientMouseLeave", root, enableScroll)
end

function stopTuningCamera()
    if not isActive then
        return
    end
    --showCursor(false)

    isActive = false
    removeEventHandler("onClientPreRender", root, update)
    removeEventHandler("onClientCursorMove", root, mouseMove)
    removeEventHandler("onClientKey", root, handleKey)
    removeEventHandler("onClientMouseEnter", root, disableScroll)
    removeEventHandler("onClientMouseLeave", root, enableScroll)
    setCameraTarget(localPlayer)
end

