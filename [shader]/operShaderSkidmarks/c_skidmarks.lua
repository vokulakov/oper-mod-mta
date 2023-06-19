local Skidmarks = {}
local Settings = {}

Settings.var = {
    ['Black'] = { 
        hue1                = 0.00, 
        hue2                = 0.00, 
        hue3                = 0.00, 
        hue4                = 0.00,
        alpha1              = 1.00, 
        alpha2              = 0.84, 
        alpha3              = 0.71, 
        alpha4              = 0.55,
        saturation          = 1.00, 
        lightness           = 0.00, 
        pos_changes_hue     = 0.00, 
        time_changes_hue    = 0.00, 
        filth               = 1.00
    },

    ['Bright'] = {
        hue1                = 0.00,
        hue2                = 0.00,
        hue3                = 0.00,
        hue4                = 0.00,
        alpha1              = 1.00,
        alpha2              = 0.84,
        alpha3              = 0.71,
        alpha4              = 0.55,
        saturation          = 1.00,
        lightness           = 0.66,
        pos_changes_hue     = 0.06,
        time_changes_hue    = 0.06,
        filth               = 1.00
    },

    ['BrightTwo'] = {
        hue1                = 0.00,
        hue2                = 0.02,
        hue3                = 0.06,
        hue4                = 0.11,
        alpha1              = 1.00,
        alpha2              = 0.84,
        alpha3              = 0.71,
        alpha4              = 0.55,
        saturation          = 1.00,
        lightness           = 0.66,
        pos_changes_hue     = 0.39,
        time_changes_hue    = 0.13,
        filth               = 0.06
    }

}

function setShaderSetting(type)
    if not Skidmarks.shader then 
        return 
    end

    local v = Settings.var[type]

    dxSetShaderValue(Skidmarks.shader, "sHSVa1", v.hue1, v.saturation, v.lightness, v.alpha1)
    dxSetShaderValue(Skidmarks.shader, "sHSVa2", v.hue2, v.saturation, v.lightness, v.alpha2)
    dxSetShaderValue(Skidmarks.shader, "sHSVa3", v.hue3, v.saturation, v.lightness, v.alpha3)
    dxSetShaderValue(Skidmarks.shader, "sHSVa4", v.hue4, v.saturation, v.lightness, v.alpha4)
    dxSetShaderValue(Skidmarks.shader, "sPosAmount", v.pos_changes_hue)
    dxSetShaderValue(Skidmarks.shader, "sSpeed", v.time_changes_hue)
    dxSetShaderValue(Skidmarks.shader, "sFilth", v.filth)
end

function startShader()
    Skidmarks.shader = dxCreateShader("skidmarks.fx")

    if not Skidmarks.shader then
        return
    end

    engineApplyShaderToWorldTexture(Skidmarks.shader, "particleskid")
    setShaderSetting('Black')
end

function stopShader()
    if not Skidmarks.shader then
        return
    end

    engineRemoveShaderFromWorldTexture(Skidmarks.shader, "particleskid")
    destroyElement(Skidmarks.shader)

    Skidmarks.shader = nil
end