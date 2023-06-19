local orderPriority = "-2.7"

Settings = {}
Settings.var = {}

---------------------------------
-- Проверяем версию
---------------------------------
function isMTAUpToDate()
	local mtaVer = getVersion().sortable
	if getVersion ().sortable < "1.3.4-9.05899" then
		return false
	else
		return true
	end
end

------------------------------------
-- DepthBuffer проверка компьютера
------------------------------------
function isDepthBufferAccessible()
	local info=dxGetStatus()
	local depthStatus=false
		for k,v in pairs(info) do
			if string.find(k, "DepthBufferFormat") then
				depthStatus=true
				if tostring(v)=='unknown' then depthStatus=false end
			end
		end
	return depthStatus
end

----------------------------------------------------------------
-- Включаем шейдер
----------------------------------------------------------------
function enableDoF()
	if dEffectEnabled then return end
	scx, scy = guiGetScreenSize()
	myScreenSource = dxCreateScreenSource( scx, scy )
	
	dBlurHShader,tecName = dxCreateShader( "fx/dBlurH.fx" )
	dBlurVShader,tecName = dxCreateShader( "fx/dBlurV.fx" )	
	dBShader,tecName = dxCreateShader( "fx/getDepth.fx" )

	effectParts = {	myScreenSource,	dBlurHShader, dBlurVShader,	dBShader }

	-- Проверка список всех используемых элементов
	bAllValid = true
	for _,part in ipairs(effectParts) do
		bAllValid = part and bAllValid
	end
	
	setEffectVariables ()
	dEffectEnabled = true
	
	if not bAllValid then
		disableDoF()
	else
		distTimer = setTimer(function()
			Settings.var.farClip = getFarClipDistance () * 0.9995
		end,100,0 )
	end	
end

----------------------------------------------------------------
-- Выключаем шейдер
----------------------------------------------------------------
function disableDoF()
	if not dEffectEnabled then return end
	for _,part in ipairs(effectParts) do
		if part then
			destroyElement( part )
		end
	end
	effectParts = {}
	if distTimer then 
		killTimer(distTimer)
		distTimer = nil
	end
	bAllValid = false
	dEffectEnabled = false
end

---------------------------------
-- Настройка эффектов
---------------------------------
function setEffectVariables()
    local v = Settings.var
    -- DoF
    v.blurFactor = 0.9 -- количество размытия
    v.brightBlur = true -- темный пиксель получает меньше размытия / false - не получает
	-- Depth Spread
    v.fadeStart = 1
    v.fadeEnd = 700
    v.maxCut = true -- небо не будет размыто / false - будет
    v.farClip = 1000 -- меняется в зависимости от farClip
    v.maxCutBlur = 0.5 -- максимальное размытие неба 

	-- Debugging
    v.PreviewEnable=0
    v.PreviewPosY=0
    v.PreviewPosX=100
    v.PreviewSize=70
end

-----------------------------------------------------------------------------------
-- Рендер
-----------------------------------------------------------------------------------
addEventHandler( "onClientRender", root,
    function()
		if not bAllValid or not Settings.var or not dEffectEnabled then return end
		local v = Settings.var	
		RTPool.frameStart()
		dxUpdateScreenSource( myScreenSource, true )
		local current = myScreenSource
		local getDepth = getDepthBuffer( current,v.fadeStart,v.fadeEnd ,v.farClip,v.maxCut,v.maxCutBlur ) 
		current = applyGDepthBlurH( current,getDepth,v.blurFactor,v.brightBlur )
		current = applyGDepthBlurV( current,getDepth,v.blurFactor,v.brightBlur )
		dxSetRenderTarget()
			
		if current then dxDrawImage( 0, 0, scx, scy, current, 0, 0, 0, tocolor(255,255,255,255) ) end
		if v.PreviewEnable > 0.5 then
		end
	end
,true ,"low" .. orderPriority )

-----------------------------------------------------------------------------------
-- Применить разные этапы и структуры 
-----------------------------------------------------------------------------------
function getDepthBuffer(Src, fadeStart, fadeEnd, farClip, maxCut, maxCutBlur ) 
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( dBShader, "gFadeStart", fadeStart )
	dxSetShaderValue( dBShader, "gFadeEnd",fadeEnd )
	dxSetShaderValue( dBShader, "sFarClip", farClip )
	dxSetShaderValue( dBShader, "sMaxCut", maxCut )
	dxSetShaderValue( dBShader, "sMaxCutBlur", maxCutBlur )
	dxDrawImage( 0, 0, mx, my, dBShader )
	return newRT
end

function applyGDepthBlurH( Src,getDepth,blur,brightBlur )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( dBlurHShader, "TEX0", Src )
	dxSetShaderValue( dBlurHShader, "TEX1", getDepth )
	dxSetShaderValue( dBlurHShader, "tex0size", mx,my )
	dxSetShaderValue( dBlurVShader, "gblurFactor",blur )
	dxSetShaderValue( dBlurVShader, "gBrightBlur",brightBlur )
	dxDrawImage( 0, 0, mx, my, dBlurHShader )
	return newRT
end

function applyGDepthBlurV( Src,getDepth,blur,brightBlur )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( dBlurVShader, "TEX0", Src )
	dxSetShaderValue( dBlurVShader, "TEX1", getDepth )
	dxSetShaderValue( dBlurVShader, "tex0size", mx,my )
	dxSetShaderValue( dBlurVShader, "gblurFactor",blur )
	dxDrawImage( 0, 0, mx,my, dBlurVShader )
	return newRT
end

----------------------------------------------------------------
-- Память
----------------------------------------------------------------
_dxDrawImage = dxDrawImage
function xdxDrawImage(posX, posY, width, height, image, ... )
	if not image then return false end
	return _dxDrawImage( posX, posY, width, height, image, ... )
end

RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end
