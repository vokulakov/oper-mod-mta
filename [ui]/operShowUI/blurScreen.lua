local sx, sy = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(sx, sy)
local BLUR_SHADER = dxCreateShader("assets/blur.fx")
local blurShow = false

local function blurShaderShow()
    dxUpdateScreenSource(myScreenSource)     
    dxSetShaderValue(BLUR_SHADER, "ScreenSource", myScreenSource)
	dxSetShaderValue(BLUR_SHADER, "BlurStrength", 6);
	dxSetShaderValue(BLUR_SHADER, "UVSize", sx, sy);
    dxDrawImage(-10, -10, sx+10, sy+10, BLUR_SHADER)
end


local function drawBlurShader(state)
	if state == nil then
		return
	end

	if not blurShow and state then
    	addEventHandler("onClientRender", root, blurShaderShow)
    elseif blurShow and not state then
    	removeEventHandler("onClientRender", root, blurShaderShow)
    end

    blurShow = state
end
addEvent("operShowUI.drawBlurShader", true)
addEventHandler("operShowUI.drawBlurShader", root, drawBlurShader)
