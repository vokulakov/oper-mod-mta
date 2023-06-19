-- shad_exp

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()

	for _, v in ipairs(Config.lampNeon) do
		local dff = engineLoadDFF(v.url, v.id)
		engineReplaceModel(dff, v.id) 

	end

end)

--[[
local x, y, z = 1042, 1722, 10.8

for i = 1, 2 do 
    local obj = createObject(14400, x, y + i * 5, z)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
end
]]
--[[
local function getColor(r, g, b, a)
    local texture = dxCreateTexture(1, 1, "argb") 
    local pixels = string.char(0, 0, 0, 0, 1, 0, 1, 0)
    dxSetPixelColor(pixels, 0, 0, r, g, b, a)
    dxSetTexturePixels(texture, pixels)
    return texture
end

local sh = dxCreateShader("assets/texreplace.fx", 0, 200, false)
    engineApplyShaderToWorldTexture(sh, 'shad_exp')

    dxSetShaderValue(
        sh, 
        "gTexture", 
        getColor(255, 0, 0, 255)
    )
]]