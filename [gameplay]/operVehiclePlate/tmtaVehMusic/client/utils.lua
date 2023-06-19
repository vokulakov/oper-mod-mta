isEventHandlerAdded = function ( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

isMouseInPosition = function ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    
    return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

_dxDrawImage = dxDrawImage

dxDrawImage = function( x, y, w, h, ... )
    _dxDrawImage( math.floor( x ), math.floor( y ), math.floor( w ), math.floor( h ), ... )
end


_dxDrawText = dxDrawText

dxDrawText = function ( text, x, y, w, h, ... )
    _dxDrawText( text, x, y, x + w, y + h, ... )
end


dxDrawRoundRectangle = function ( x, y, w, h, color, vertical )
    if Assets.Textures[ "round" ] then
        if not vertical then
            dxDrawImage( x, y, h, h, Assets.Textures[ "round" ], 0, 0, 0, color )
            dxDrawImage( x + w - h / 2, y, h, h, Assets.Textures[ "round" ], 0, 0, 0, color )
            dxDrawRectangle( x + h / 2, y, w - h / 2, h, color )
        else
            dxDrawImage( x, y, w, w, Assets.Textures[ "round" ], 0, 0, 0, color )
            dxDrawImage( x, y + h - w / 2, w, w, Assets.Textures[ "round" ], 0, 0, 0, color )
            dxDrawRectangle( x, y + w / 2, w, h - w / 2, color )
        end
    end
end


function getMousePos()
    local xsc, ysc = guiGetScreenSize()
    local mx, my = getCursorPosition()
    if not mx or not my then
        mx, my = 0, 0
    end
    return mx * xsc, my * ysc
end


local antiDOSdelay, triggerEventPause = 2000
antiDOScheck = function ()
    if isTimer(triggerEventPause) then
        return false
    else
        triggerEventPause = setTimer(function() end, antiDOSdelay, 1)
        return true
    end
end

map = function (value, fromLow, fromHigh, toLow, toHigh)
    return (value-fromLow) * (toHigh-toLow) / (fromHigh-fromLow) + toLow
end


function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end