Toner = {}

Toner.textures = {
    reflx = dxCreateTexture("assets/texture/reflx.dds", "dxt5", true, "clamp"),

}

Toner.Vehicles = {}

function Toner.getColorTexture(r, g, b, a)
    local texture = dxCreateTexture(1, 1, "argb") 
    local pixels = string.char(0, 0, 0, 0, 1, 0, 1, 0)
    
    dxSetPixelColor(pixels, 0, 0, r, g, b, a)
    dxSetTexturePixels(texture, pixels)

    return texture
end

function Toner.setShaderValue(shader, data_toner)
    local texture 

    if data_toner.type == 'color' then -- если накладываем просто цвет
        texture = Toner.getColorTexture(data_toner.r, data_toner.g, data_toner.b, data_toner.a)
    end

    if not isElement(texture) then
        return
    end

    shader:setValue("gTexture", texture)
end

function Toner.addOnVehicle(vehicle, txt_toner, data_toner)
    if not isElement(vehicle) then
        return
    end

    if not data_toner.type then -- если нет данных
        return
    end

    if not Toner.Vehicles[vehicle] then
        Toner.Vehicles[vehicle] = {}
    end

    if Toner.Vehicles[vehicle][txt_toner] then
        return false
    end

    shader = dxCreateShader('assets/shader/windows.fx', 0, 200, false, "vehicle")
    shader:setValue('sReflectionTexture', Toner.textures.reflx)

    Toner.setShaderValue(shader, data_toner)
    engineApplyShaderToWorldTexture(shader, txt_toner, vehicle)

    Toner.Vehicles[vehicle][txt_toner] = {shader = shader, r = data_toner.r, g = data_toner.g, b = data_toner.b, a = data_toner.a}
end

function Toner.destroyFromVehicle(vehicle, txt_toner)
    if not isElement(vehicle) or not Toner.Vehicles[vehicle] then
        return
    end

    if not Toner.Vehicles[vehicle][txt_toner] then
        return
    end

    engineRemoveShaderFromWorldTexture(Toner.Vehicles[vehicle][txt_toner].shader, txt_toner, vehicle)
    destroyElement(Toner.Vehicles[vehicle][txt_toner].shader)

    Toner.Vehicles[vehicle][txt_toner] = nil
end

function Toner.update(vehicle, txt_toner, data_toner)
    if not isElement(vehicle) then
        return
    end

    if not Toner.Vehicles[vehicle] or not Toner.Vehicles[vehicle][txt_toner] then -- если шейдер еще не создавался, то создадим его
        return Toner.addOnVehicle(vehicle, txt_toner, data_toner)
    end

    local shader = Toner.Vehicles[vehicle][txt_toner].shader
    Toner.Vehicles[vehicle][txt_toner] = {shader = shader, r = data_toner.r, g = data_toner.g, b = data_toner.b, a = data_toner.a}
    Toner.setShaderValue(shader, data_toner)
end

function Toner.startPrewiew(vehicle, r, g, b, a)
    if not isElement(vehicle) then
        return
    end

    if not Toner.Vehicles[vehicle] then
        Toner.Vehicles[vehicle] = {}
    end

    local activeTab = guiGetSelectedTab(GUI.tabPanel)

    if activeTab == GUI.tab1 then 
        local alpha = 68 + math.ceil(107/100*math.floor((a/255)*100))
        if guiCheckBoxGetSelected(GUI.chekBoxColor_zad) then -- ЗАДНЯЯ ПОЛУСФЕРА
            Toner.update(vehicle, 'zad_steklo', {type = 'color', r = r, g = g, b = b, a = alpha})
        end

        if guiCheckBoxGetSelected(GUI.chekBoxColor_pered) then -- ПЕРЕДНИЕ СТЕКЛА
            Toner.update(vehicle, 'pered_steklo', {type = 'color', r = r, g = g, b = b, a = alpha})
        end

        if guiCheckBoxGetSelected(GUI.chekBoxColor_lob) then -- ЛОБОВОЕ СТЕКЛО
            Toner.update(vehicle, 'lob_steklo', {type = 'color', r = r, g = g, b = b, a = alpha})
        end
    end

end

function Toner.stopPrewiew(vehicle)
    if not isElement(vehicle) then
        return
    end

    local tableData = vehicle:getData('vehicle.isToner') or false

    if not tableData then
        Toner.destroyFromVehicle(vehicle, 'zad_steklo')
        Toner.destroyFromVehicle(vehicle, 'pered_steklo')
        Toner.destroyFromVehicle(vehicle, 'lob_steklo')
        return
    end

    for key, data in pairs(tableData) do 
        tableData[key].update = true
    end

    vehicle:setData('vehicle.isToner', tableData)
end

function Toner.setData(vehicle, txt_toner, data_toner) -- зафиксировать данные по тонеру (для синхронизации со всеми)
    if not isElement(vehicle) then
        return
    end

    local tableData = vehicle:getData('vehicle.isToner') or {}

    for key, v in pairs(tableData) do 
        tableData[key].update = false
    end

    if not data_toner then
        tableData[txt_toner] = {}
    else
        tableData[txt_toner] = {type = data_toner.type, txt = data_toner.txt, r = data_toner.r, g = data_toner.g, b = data_toner.b, a = data_toner.a}
    end

    tableData[txt_toner].update = true

    vehicle:setData('vehicle.isToner', tableData)
end

addEventHandler("onClientElementDataChange", root, function(data)
    if getElementType(source) == "vehicle" and data == "vehicle.isToner" then 
        if not isElementStreamedIn(source) then
            return
        end

        local tableData = source:getData('vehicle.isToner') or {}

        for key, v in pairs(tableData) do
            if v.update then
                if v.type then
                    Toner.update(source, key, v)
                else
                    Toner.destroyFromVehicle(source, key)
                end
            end
        end
    end
end)

addEventHandler('onClientResourceStart', resourceRoot, function()
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        if isElementStreamedIn(vehicle) then
            local tableData = vehicle:getData('vehicle.isToner') or false

            if not tableData then
                break
            end

            for key, v in pairs(tableData) do
                Toner.addOnVehicle(vehicle, key, v)
            end
        end
    end
end)

addEventHandler('onClientResourceStop', resourceRoot, function()
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        if Toner.Vehicles[vehicle] then
            for key, v in pairs(Toner.Vehicles[vehicle]) do
                Toner.destroyFromVehicle(vehicle, key)
            end

            --vehicle:setData('vehicle.isToner', false)
        end
    end
end)

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
        local tableData = source:getData('vehicle.isToner') or false

        if not tableData then 
            return
        end

        for key, data in pairs(tableData) do
            Toner.addOnVehicle(source, key, data)
        end
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if getElementType(source) == "vehicle" then
        if Toner.Vehicles[source] then
            for key, data in pairs(Toner.Vehicles[source]) do
                Toner.destroyFromVehicle(source, key)
            end
        end
    end
end)
