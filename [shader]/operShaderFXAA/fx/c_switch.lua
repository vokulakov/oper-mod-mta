--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchfxAA", root, 4 )
--
--	To switch off:
--			triggerEvent( "switchfxAA", root, 0 )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		if (vCardPSVer()~="3") then outputChatBox('fxAA: Shader Model 3 not supported',255,0,0) return end
		triggerEvent( "switchfxAA", resourceRoot, 4 )
		addCommandHandler( "sFxAA",
			function(_,aValue)
				triggerEvent( "switchfxAA", resourceRoot, aValue )
			end
		)
	end
)


--------------------------------
-- Switch effect on or off
--------------------------------
function switchfxAA( aaOn )
	local aaVal = tonumber( aaOn )
	outputDebugString( "switchfxAA: " .. tostring(aaVal) )
	if (aaVal~=nil and aaVal>0) then
		enablefxAA(aaVal)
	else
		disablefxAA()
	end
end

addEvent( "switchfxAA", true )
addEventHandler( "switchfxAA", resourceRoot, switchfxAA )
