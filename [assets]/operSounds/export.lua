local sounds = { 

	-- vehicles --
	['veh_horn_sound_1'] = "assets/vehicles/signal/sound_1.wav",
	['veh_horn_sound_2'] = "assets/vehicles/signal/sound_2.wav",
	['veh_horn_sound_3'] = "assets/vehicles/signal/sound_3.wav",
	['veh_horn_sound_4'] = "assets/vehicles/signal/sound_4.wav",
	['veh_horn_sound_5'] = "assets/vehicles/signal/sound_5.wav",
	['veh_horn_sound_6'] = "assets/vehicles/signal/sound_6.wav",
	['veh_horn_sound_7'] = "assets/vehicles/signal/sound_7.wav",
	['veh_horn_sound_8'] = "assets/vehicles/signal/sound_8.wav",
	
	-- --
	['veh_sgu_airhorn_1'] = "assets/vehicles/sgu/sgu_airhorn_1.mp3",
	['veh_sgu_airhorn_2'] = "assets/vehicles/sgu/sgu_airhorn_2.mp3",
	['veh_sgu_airhorn_3'] = "assets/vehicles/sgu/sgu_airhorn_3.mp3",
	['veh_sgu_airhorn_4'] = "assets/vehicles/sgu/sgu_airhorn_4.mp3",

	['veh_sgu_manual_1'] = "assets/vehicles/sgu/sgu_manual_1.mp3",
	['veh_sgu_manual_2'] = "assets/vehicles/sgu/sgu_manual_2.mp3",
	['veh_sgu_manual_3'] = "assets/vehicles/sgu/sgu_manual_3.mp3",
	['veh_sgu_manual_4'] = "assets/vehicles/sgu/sgu_manual_4.mp3",

	['veh_sgu_sirena_1'] = "assets/vehicles/sgu/sgu_sirena_1.mp3",
	['veh_sgu_sirena_2'] = "assets/vehicles/sgu/sgu_sirena_2.mp3",
	['veh_sgu_sirena_3'] = "assets/vehicles/sgu/sgu_sirena_3.mp3",
	['veh_sgu_sirena_4'] = "assets/vehicles/sgu/sgu_sirena_4.mp3",
	['veh_sgu_sirena_5'] = "assets/vehicles/sgu/sgu_sirena_5.mp3",
	['veh_sgu_sirena_6'] = "assets/vehicles/sgu/sgu_sirena_6.mp3",
	['veh_sgu_sirena_7'] = "assets/vehicles/sgu/sgu_sirena_7.mp3",
	['veh_sgu_sirena_8'] = "assets/vehicles/sgu/sgu_sirena_8.mp3",

	['veh_sgu_voice_1'] = "assets/vehicles/sgu/sgu_voice_1.mp3",
	['veh_sgu_voice_2'] = "assets/vehicles/sgu/sgu_voice_2.mp3",
	['veh_sgu_voice_3'] = "assets/vehicles/sgu/sgu_voice_3.mp3",
	['veh_sgu_voice_4'] = "assets/vehicles/sgu/sgu_voice_4.mp3",
	['veh_sgu_voice_5'] = "assets/vehicles/sgu/sgu_voice_5.mp3",
	-- --

	['veh_doorlock'] = "assets/vehicles/doorlock.mp3",
	['veh_lightswitch'] = "assets/vehicles/lightswitch.mp3",
	['veh_starter_car'] = "assets/vehicles/starter_car.mp3",
	['veh_starter_moto'] = "assets/vehicles/starter_moto.wav",
	['veh_turnsignal'] = "assets/vehicles/turnsignal.mp3",
	['veh_handbrake'] = "assets/vehicles/handbrake.wav",

	-- 
	['ui_change'] = "assets/systems_sound/ui_change.wav",
	['ui_select'] = "assets/systems_sound/ui_select.wav",
	['ui_back'] = "assets/systems_sound/ui_back.wav"
}

function playSound(name, ...)
	local sound = sounds[name]
	
	if not sound then
		return false
	end

	if type(name) ~= "string" then
		return false
	end

	return Sound(sound, ...)
end

addEvent('operSound.playSound', true)
addEventHandler('operSound.playSound', root, function(name, ...)
	if source ~= localPlayer then
		return
	end

	playSound(name, ...)
end)

function playSound3D(name, ...)
	local sound = sounds[name]

	if not sound then
		return false
	end

	if type(name) ~= "string" then
		return false
	end

	return Sound3D(sound, ...)
end


-- НЕОБХОДИМО СДЕЛАТЬ ОЧИСТКУ!