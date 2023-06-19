local vehicles = { }

local CURRENT_RADIO_IND = 1

local SOUND_TIMER = nil
local SHOW_TIMER = nil
local SOUND_TUNE = nil
local SOUND_RADIO = nil

local SHOW_RADIO_UI = false

local RADIO_STATIONS = {

	0, -- выключение радио

	{
		name = 'Дорожное', 
		url = 'https://dorognoe.hostingradio.ru/dorognoe', 
		logo = dxCreateTexture('assets/drj.png')
	},

	{
		name = 'Радио Родных Дорог', 
		url = 'https://stream1.radiord.ru:8000/live128.mp3', 
		logo = dxCreateTexture('assets/Rodnyix-doroG.png')
	},

	{
		name = 'Европа +', 
		url = 'http://ep256.hostingradio.ru:8052/europaplus256.mp3', 
		logo = dxCreateTexture('assets/ep.png')
	},

	{
		name = 'Radio Record', 
		url = 'https://radiorecord.hostingradio.ru/rr_main96.aacp', 
		logo = dxCreateTexture('assets/rr.png')
	},
	
	{
		name = 'Радио ENERGY', 
		url = 'https://srv21.gpmradio.ru:8443/stream/air/aac/64/99?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJrZXkiOiIwNGUwMGNjZmMwOGQ2NTk1NWU4NzIyMDI2MzhmNjQ3YSIsIklQIjoiNzcuNDAuNjEuMTQxIiwiVUEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE0LjAuMC4wIFNhZmFyaS81MzcuMzYiLCJSZWYiOiJodHRwczovL3d3dy5lbmVyZ3lmbS5ydS8iLCJ1aWRfY2hhbm5lbCI6Ijk5IiwidHlwZV9jaGFubmVsIjoiY2hhbm5lbCIsInR5cGVEZXZpY2UiOiJQQyIsIkJyb3dzZXIiOiJDaHJvbWUiLCJCcm93c2VyVmVyc2lvbiI6IjExNC4wLjAuMCIsIlN5c3RlbSI6IldpbmRvd3MgMTAiLCJleHAiOjE2ODY3NDIzNTh9.ljPMydmIY-Xs7INsj-ip00l4VOAVJiYDUEZHkyXMLV8', 
		logo = dxCreateTexture('assets/energy.png')
	},

	{
		name = 'Пульс радио', 
		url = 'https://radiosolo.ru/radio/puls/icecast.audio', 
		logo = dxCreateTexture('assets/pr.png')
	},

	{
		name = 'Rap Hits - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/rap96.aacp', 
		logo = dxCreateTexture('assets/record-rap-hits.png')
	},
	
	{
		name = 'Маруся ФМ', 
		url = 'https://radio-holding.ru:9433/marusya_default', 
		logo = dxCreateTexture('assets/marusyafm.png')
	},

	{
		name = 'Детское радио', 
		url = 'https://pub0301.101.ru:8443/stream/air/mp3/256/199', 
		logo = dxCreateTexture('assets/detifm.png')
	},

	{
		name = 'Like FM', 
		url = 'https://pub0301.101.ru:8443/stream/air/mp3/256/219', 
		logo = dxCreateTexture('assets/likefm.jpg')
	},
	
	{
		name = 'На Хайпе - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/hype96.aacp', 
		logo = dxCreateTexture('assets/na-haype.png')
	},

	
	{
		name = 'Супердискотека 90-х - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/sd9096.aacp', 
		logo = dxCreateTexture('assets/rekord-superdiskoteka-90-x.jpg')
	},

	{
		name = 'Русское радио', 
		url = 'https://rusradio.hostingradio.ru/rusradio96.aacp', 
		logo = dxCreateTexture('assets/rusradio.png')
	},

	{
		name = 'Радио ВАНЯ', 
		url = 'https://radiokrug.ru/radio/vanya/icecast.audio', 
		logo = dxCreateTexture('assets/radio-vanya.png')
	},

	
	{
		name = 'Chill-Out - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/chil96.aacp', 
		logo = dxCreateTexture('assets/record-chill-out.jpg')
	},

	{
		name = 'Авторадио', 
		url = 'https://pub0101.101.ru:8443/stream/air/mp3/256/100', 
		logo = dxCreateTexture('assets/auto.png')
	},

	{
		name = 'Black Rap - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/yo96.aacp', 
		logo = dxCreateTexture('assets/rr_black.png')
	},
	
	{
		name = 'Ретро FM', 
		url = 'https://retro.hostingradio.ru:8043/retro256.mp3', 
		logo = dxCreateTexture('assets/retro_fm.png')
	},
	
	{
		name = 'Bass House - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/jackin96.aacp', 
		logo = dxCreateTexture('assets/record-bass-house.jpg')
	},

	{
		name = 'DFM', 
		url = 'https://dfm.hostingradio.ru/dfm96.aacp', 
		logo = dxCreateTexture('assets/dfm.png')
	},

	{
		name = 'НАШЕ Радио', 
		url = 'https://nashe1.hostingradio.ru/nashe-256', 
		logo = dxCreateTexture('assets/nase-radio.png')
	},

	{
		name = 'Радио Дача', 
		url = 'https://stream.n340.com/14_dacha_64?type=aac&UID=20C75AA49D2EF24BA90D926120588E77', 
		logo = dxCreateTexture('assets/radio-dacha.png')
	},

	{
		name = 'Trap - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/trap96.aacp', 
		logo = dxCreateTexture('assets/recordtrap.png')
	},
	
	{
		name = 'Милицейская Волна', 
		url = 'https://radiomv.hostingradio.ru:80/radiomv256.mp3', 
		logo = dxCreateTexture('assets/radiomv.jpg')
	},

	{
		name = 'Гоп FM - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/gop96.aacp', 
		logo = dxCreateTexture('assets/gop-fm.jpg')
	},
	
	{
		name = 'Новое Радио', 
		url = 'https://stream.newradio.ru/novoe96.aacp', 
		logo = dxCreateTexture('assets/novoe-v2.png')
	},
	
	{
		name = 'Russian Mix - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/rus96.aacp', 
		logo = dxCreateTexture('assets/record-russian-mix.jpg')
	},
	
	{
		name = 'Юмор FM', 
		url = 'https://ic5.101.ru:8000/v5_1', 
		logo = dxCreateTexture('assets/humorfm.jpg')
	},

	{
		name = 'Relax FM', 
		url = 'https://pub0301.101.ru:8443/stream/air/mp3/256/200', 
		logo = dxCreateTexture('assets/relax-fm.png')
	},
	
	{
		name = 'Rock - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/rock96.aacp', 
		logo = dxCreateTexture('assets/rekord-rock.jpg')
	},

	{
		name = 'Rap Classics - Радио Рекорд', 
		url = 'https://radiorecord.hostingradio.ru/rapclassics96.aacp', 
		logo = dxCreateTexture('assets/rap-classics-record.jpg')
	},
	
}

local sX, sY = guiGetScreenSize()

local FONTS = { 
	['TITTLE'] = dxCreateFont("assets/fonts/Roboto-Bold.ttf", 11),
	['INFO'] = dxCreateFont("assets/fonts/Roboto-Regular.ttf", 9)
}

local posY = 10

local function showRadioSwitch() -- UI
	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['speed'] then return end
	
	local veh = getPedOccupiedVehicle(localPlayer) 
	if not veh then return end

	local radio = RADIO_STATIONS[CURRENT_RADIO_IND]
	if type(radio) == 'number' then return end

	dxDrawRectangle(sX/2-410/2, posY, 90, 90, tocolor(33, 33, 33, 255), false)
	dxDrawRectangle(sX/2-320/2+90/2, posY, 320, 90, tocolor(33, 33, 33, 200), false)

	dxDrawImage(sX/2-400/2, posY + 5, 80, 80, radio.logo)

	dxDrawText(string.upper(radio.name), sX/2-100, posY + 15, sX/2+190, 0, tocolor(255, 255, 255), 1, FONTS['TITTLE'], 'left', 'top', false, true)

	local tittle = 'Название трека неизвестно'

	if isElement(SOUND_RADIO) then 
		local sound_meta = getSoundMetaTags(SOUND_RADIO)
		if sound_meta.stream_title then
			tittle = sound_meta.stream_title  
		end
	end

	dxDrawText(tittle, sX/2-100, posY + 50, sX/2+190, posY + 85, tocolor(255, 255, 255, 175), 1, FONTS['INFO'], 'left', 'top', true, true)
end

local function stopRadio()
	if isElement(SOUND_RADIO) then 
		destroyElement(SOUND_RADIO)
	end

	if isTimer(SOUND_TIMER) then
		killTimer(SOUND_TIMER)
		if isElement(SOUND_TUNE) then
			stopSound(SOUND_TUNE)
		end
	end

	if isTimer(SHOW_TIMER) then
		killTimer(SHOW_TIMER)
		removeEventHandler("onClientPreRender", root, showRadioSwitch)
		SHOW_RADIO_UI = false
	end
end

local function onPlayerRadioSwitch()
	
	stopRadio()

	if CURRENT_RADIO_IND == 1 then -- ВЫКЛЮЧИТЬ РАДИО
		return
	end

	if not isElement(SOUND_TUNE) then
		SOUND_TUNE = playSound('assets/sounds/radio_tune.mp3', false)

		if not SHOW_RADIO_UI then
			SHOW_RADIO_UI = true
			addEventHandler("onClientPreRender", root, showRadioSwitch)
		end

		SOUND_TIMER = setTimer(
			function()
				stopSound(SOUND_TUNE)

				local radio = RADIO_STATIONS[CURRENT_RADIO_IND]
	
				if isElement(SOUND_RADIO) then 
					destroyElement(SOUND_RADIO) 
				end

				if type(radio) == 'number' then return end

				SOUND_RADIO = playSound(radio.url)
				setSoundVolume(SOUND_RADIO, 1.0)

				SHOW_TIMER = setTimer(function()
					removeEventHandler("onClientPreRender", root, showRadioSwitch)
					SHOW_RADIO_UI = false
				end, 5000, 1)

			end, 2000, 1)

	end

end 

local function onRadioNext()
	local vehicle = localPlayer.vehicle
    if not isElement(vehicle) or vehicle.controller ~= localPlayer then
        return
    end

	local nextIndex = CURRENT_RADIO_IND + 1 < #RADIO_STATIONS and CURRENT_RADIO_IND + 1 or 1 --((CURRENT_RADIO_IND)%(#RADIO_STATIONS))+1
	CURRENT_RADIO_IND = nextIndex
	vehicle:setData("vehicle:radio_station", tonumber(CURRENT_RADIO_IND))
	onPlayerRadioSwitch()
end

local function onRadioPrevios()
	local vehicle = localPlayer.vehicle
    if not isElement(vehicle) or vehicle.controller ~= localPlayer then
        return
    end

	local nextIndex = CURRENT_RADIO_IND - 1 > 0 and CURRENT_RADIO_IND - 1 or #RADIO_STATIONS --((CURRENT_RADIO_IND-2)%(#RADIO_STATIONS))+1
    CURRENT_RADIO_IND = nextIndex
	vehicle:setData("vehicle:radio_station", tonumber(CURRENT_RADIO_IND))
    onPlayerRadioSwitch()
end

addEventHandler("onClientElementDataChange", root, function(dataName, _, value)
	local vehicle = source
	if isElement(vehicle) and getElementType(vehicle) == "vehicle" and dataName == "vehicle:radio_station" then
		CURRENT_RADIO_IND = value
		onPlayerRadioSwitch()
	end
end)

addEventHandler('onClientPlayerVehicleEnter', root, function(veh, seat)
	if source ~= localPlayer then return end
	bindKey("5", "down", onRadioNext)
	bindKey("4", "down", onRadioPrevios)
	setRadioChannel(0)
	CURRENT_RADIO_IND = veh:getData('vehicle:radio_station') or 1
	onPlayerRadioSwitch()
end)

addEventHandler('onClientVehicleExit', root, function(player, seat)
	if player ~= localPlayer then return end
	stopRadio()
	unbindKey("5", "down", onRadioNext)
	unbindKey("4", "down", onRadioPrevios)	
end)

addEventHandler("onClientVehicleStartExit", root, function(player, seat)
	if player ~= localPlayer then return end
	stopRadio()
	unbindKey("5", "down", onRadioNext)
	unbindKey("4", "down", onRadioPrevios)	
end)

addEventHandler("onClientElementDestroy", root, function()
	if source and getElementType(source) == "vehicle" then
		if source == getPedOccupiedVehicle(localPlayer) then
			if isElement(SOUND_RADIO) then 
				stopRadio()
			end
		end
	end
end)

addEventHandler("onClientVehicleExplode", root, function()
	if source and getElementType(source) == "vehicle" then
		if source == getPedOccupiedVehicle(localPlayer) then
			if isElement(SOUND_RADIO) then 
				stopRadio()
			end
		end
	end
end)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	if isElement(SOUND_RADIO) then 
		stopRadio()
	end
end)

addEventHandler("onClientPlayerRadioSwitch", localPlayer, function(station) 
	if station ~= 0 then 
		cancelEvent() 
	end 
end)
