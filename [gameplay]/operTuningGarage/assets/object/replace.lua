addEventHandler('onClientResourceStart', resourceRoot, function () 
	local txd = engineLoadTXD('assets/object/tun_garage.txd')
    engineImportTXD(txd, 1871)

    local dff = engineLoadDFF('assets/object/tun_garage.dff', 0)
    engineReplaceModel(dff, 1871)
  
    local col = engineLoadCOL('assets/object/tun_garage.col')
    engineReplaceCOL(col, 1871)
end) 