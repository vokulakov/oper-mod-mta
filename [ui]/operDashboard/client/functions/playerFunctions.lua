PlayerFunctions = {}

function PlayerFunctions.setPlayerCanBeKnockedOffBike(state)
	setPedCanBeKnockedOffBike(localPlayer, state)
end

function PlayerFunctions.playerDamage()
	if guiCheckBoxGetSelected(Dashboard.plWindow['btn_nohp']) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, PlayerFunctions.playerDamage)