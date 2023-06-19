local screenWidth,screenHeight = guiGetScreenSize()
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        myScreenSource = dxCreateScreenSource ( screenWidth, screenHeight )         
    end
)
	

 
function cleanmyscreen()
	if myScreenSource then
		dxUpdateScreenSource( myScreenSource )                  
		dxDrawImage( screenWidth - screenWidth,  screenHeight - screenHeight,  screenWidth, screenHeight, myScreenSource, 0, 0, 0, tocolor (255, 255, 255, 255), true)      
	end
end


function tooglecleanmyscreen ()
enabled = not enabled
if enabled then
	addEventHandler( "onClientRender", root, cleanmyscreen)
	else
	removeEventHandler( "onClientRender", root, cleanmyscreen)
end
end
bindKey ("f4", "down", tooglecleanmyscreen)