local screenWidth, screenHeight = guiGetScreenSize()
local screenSource	= dxCreateScreenSource(screenWidth, screenHeight)
local darkness		= 0.5
local radius		= 5

function startVignette()
	vignetteShader = dxCreateShader("vignette.fx")
	if not(vignetteShader) then

		return
	end
	
	addEventHandler("onClientPreRender", root, renderVignette)
end

function renderVignette()
	dxUpdateScreenSource(screenSource)
	if(vignetteShader) then
		dxSetShaderValue(vignetteShader, "ScreenSource", screenSource)
		dxSetShaderValue(vignetteShader, "radius", radius)
		dxSetShaderValue(vignetteShader, "darkness", darkness)
		dxDrawImage(0, 0, screenWidth, screenHeight, vignetteShader)
	end
end

function stopVignette()
	removeEventHandler("onClientPreRender", root, renderVignette)
end