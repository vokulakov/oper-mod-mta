local isActive = false
local currentPosition, currentRotation = nil
local musicBackground 

local Time = {}

-- Обработка выхода в тюнинг
local function handleTuningExit()
    
    if not isActive then
        return
    end

    if localPlayer.vehicle then
        removeEventHandler("onClientElementDestroy", localPlayer.vehicle, playerExitGarage)
    end

    -- Телепортировать игрока к выходу
    if currentPosition then
        local targetPosition = currentPosition
        local targetRotation = currentRotation
        if localPlayer.vehicle then
            if localPlayer.vehicle.vehicleType == "Bike" then
                localPlayer.vehicle.frozen = true
                setTimer(function ()
                    localPlayer.vehicle.position = targetPosition + Vector3(0, 0, 1)
                    setElementRotation(localPlayer.vehicle, targetRotation)
                    setCameraTarget(localPlayer)
                end, 50, 1)

                setTimer(function ()
                    localPlayer.vehicle.velocity = Vector3()
                    localPlayer.vehicle.frozen = false
                end, 500, 1)
            else
                localPlayer.vehicle.position = targetPosition + Vector3(0, 0, 1)
                setElementRotation(localPlayer.vehicle, targetRotation)
                setTimer(function ()
                    setCameraTarget(localPlayer)
                    localPlayer.vehicle.frozen = false
                    localPlayer.vehicle.velocity = Vector3()
                end, 50, 1)
            end
        else
            localPlayer.position = targetPosition
            localPlayer.rotaion = targetRotation
        end
    end
    currentPosition = nil
    currentRotation = nil   

    --showTonerUI(false)
    stopTuningCamera()

    -------------------------------------------------------
    -- ТУТ МОЖНО ВСТАВИТЬ ФУНКЦИИ ПРИ ВЫХОДЕ ИЗ ПОКРАСКИ --
    if isElement(musicBackground) then
        stopSound(musicBackground)
    end

    triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
    exports.operVehicleFSO:updateVisible(localPlayer.vehicle) -- костыль для ФСО

    setTime(Time.h, Time.m)
    setMinuteDuration(Time.d)

    Time = nil
    -------------------------------------------------------

    isActive = false
    guiSetInputEnabled(false) 
    --toggleAllControls(true, true)

    if localPlayer.vehicle:getData('vehicle.isHorn') then -- костыль для сигнала
        toggleControl("horn", false)
    end

    fadeCamera(true, 1)
end


-- Обработка выхода из тюнинга
addEvent("operTuningGarage.playerExitGarage", true)
addEventHandler("operTuningGarage.playerExitGarage", resourceRoot, handleTuningExit)


function playerExitGarage()
    if not isActive then
        return
    end
    triggerServerEvent("operTuningGarage.playerExitGarage", resourceRoot)
end

addEvent("operTuningGarage.playerEnterGarage", true)
addEventHandler("operTuningGarage.playerEnterGarage", resourceRoot, function()
    if not localPlayer.vehicle then
        handleTuningExit()
        return
    end
    GarageObject.dimension = localPlayer.dimension
    GarageObject.interior  = localPlayer.interior

    addEventHandler("onClientElementDestroy", localPlayer.vehicle, playerExitGarage)

    --toggleAllControls(false, true)

    ------------------------------------------------------
    -- ТУТ МОЖНО ВСТАВИТЬ ФУНКЦИИ ПРИ ВХОДЕ В ТОНЕРОВКУ --
    --setPlayerHudComponentVisible("radar", false)
    --showTonerUI(true)
    guiSetInputEnabled(true) 

    setupColorPreview()
    startTuningCamera()

    local timehour, timeminute = getTime()
    Time = {h = timehour, m = timeminute, d = getMinuteDuration()}

    setTime(12, 0)
    setMinuteDuration(60000)

    --saveVehicleToner()
    TuningGarage.setWindowVisible(true)
    musicBackground = playSound('assets/sound/background.wav', true)
    setSoundVolume(musicBackground, 0.3)
    ------------------------------------------------------

    isActive = true

    setTimer(function ()
        if localPlayer.vehicle and isActive then
            localPlayer.vehicle.frozen = true
        end
    end, 3000, 1)
end)

function playerEnterGarage() -- вход в гараж
    if localPlayer.vehicle and localPlayer.vehicle.controller == localPlayer then
        currentPosition = Vector3(localPlayer.vehicle.position)
        currentRotation = Vector3(getVehicleRotation(localPlayer.vehicle))
        triggerServerEvent("operTuningGarage.playerEnterGarage", resourceRoot)
    end
end


addEventHandler("onClientResourceStart", resourceRoot, function ()
    GarageObject = createObject(Config.tonerGarageModel, Config.tonerGaragePosition)
    GarageObject.dimension = 1871
    GarageObject.interior = Config.garageInterior
end)
