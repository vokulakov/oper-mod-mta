local isClientRestore = false

pX, pY = 1, 1

addEventHandler("onClientRestore", root, function()
	isClientRestore = true
    setTimer(
        function()
            isClientRestore = false
        end, 500, 1)
end)