addEvent('operTuningGarage.hornBreakModelChange', true)
addEventHandler('operTuningGarage.hornBreakModelChange', root, function(model)
	if not source then 
		return 
	end
	outputDebugString('\nWarning! Извини, но это костыль.', 0, 170, 160, 0)
	setElementModel(source, model)
end)
