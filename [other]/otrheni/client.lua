
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		outputDebugString('/shader включить/выключить отражeния')
		triggerEvent( "shader", resourceRoot, true )
		addCommandHandler( "sCarPaint",
			function()
				triggerEvent( "shader", resourceRoot, not cpEffectEnabled )
			end
		)
	end
)

function shader( cpOn )
	outputDebugString( "shader: " .. tostring(cpOn) )
	if cpOn then
		startCarPaint()
	else
		stopCarPaint()
	end
end

addEvent( "shader", true )
addEventHandler( "shader", resourceRoot, shader )