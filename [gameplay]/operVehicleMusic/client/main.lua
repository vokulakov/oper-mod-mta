local screenSize = Vector2( guiGetScreenSize( ) )

local music = { }

music.colors = {
    bg = tocolor( 23, 28, 38 ),
    button = tocolor( 31, 38, 51 ),
    gray = tocolor( 98, 105, 128 ),
    hover = tocolor( 59, 69, 92 ),
    white = tocolor( 255, 255, 255 ),
}

music.data_default = { 
	name = "Аудиозапись",
	author = "не выбрана",
	playlist = { },
	url = "nil",
	pause = false,
}

music.sounds = { }
music.currentVehicle = localPlayer.vehicle

music.loading = false
music.click = false
music.visible = false

music.animations = {
	soundAlpha = 1,

	main_volume = false,
	all_vehicles_volume = false,

	scrollList = 0,
	scrollListTarget = 0,

	loading = 0,
}

music.edit = {
	active = false,
	text = "",
}

music.repeate = false
music.reverse = false

music.tab = "main"

music.settings = {
	visible = false,

	all_vehicles = false,
	all_vehicles_volume = 100,

	main_volume = 100,
}

music.scroll = false

music.saveList = { }
music.searchList = { }
music.list = { }

music.listFullScroll = #music.list * 44 - 396

local listRT = dxCreateRenderTarget( 430, 396 )
local editRT = dxCreateRenderTarget( 135, 36, true )

local repeatEditTimer
local repeatEditStartTimer

local getMusic = function ( url )
	for i,v in pairs( music.saveList ) do
		if v.url == url then
			return v
		end
	end
	return false
end

local deleteSaveMusic = function ( url )
	for i,v in pairs( music.saveList ) do
		if v.url == url then
			table.remove( music.saveList, i )
			return true
		end
	end
	return false
end

local loadSaves = function ()
	local data = {}
	if fileExists( "@music_2.1" ) then 
		local file = fileOpen( "@music_2.1", true )
		if (file) then
			data = fromJSON( fileRead( file, fileGetSize( file ) ) )
			fileClose( file )
		end
	end
	music.saveList = data
end

local saveSaves = function ()
	local file = fileCreate( "@music_2.1" )
	if file then
		fileWrite( file, toJSON( music.saveList, true ) )
		fileClose( file )
	end
end

local filterSaveList = function ( )
	music.list = { }
	for i,v in pairs( music.saveList ) do
		if string.find( utf8.upper( v.name .. "" .. v.author ), utf8.upper( music.edit.text ) ) then
			table.insert( music.list, v )
		end
	end
	music.listFullScroll = #music.list * 44 - 396
	music.animations.scrollListTarget = 0
end

local updateVolume = function ( typeVolume )
	if music.currentVehicle then
		if typeVolume == "main" then
			if isElement( music.sounds[ music.currentVehicle ] ) then
				music.sounds[ music.currentVehicle ]:setVolume( music.settings.main_volume / 100 )
				music.sounds[ music.currentVehicle ]:setMaxDistance( map( music.settings.main_volume, 0, 100, 20, 50 ) )
			end
		end
	end
	if typeVolume == "all" then
		if music.settings.all_vehicles then
			for i,v in pairs(getElementsByType("vehicle")) do
				if v ~= music.currentVehicle then
					if isElement( music.sounds[ v ] ) then
						music.sounds[ v ]:setVolume( music.settings.all_vehicles_volume / 100 )
						music.sounds[ v ]:setMaxDistance( map( music.settings.all_vehicles_volume, 0, 100, 20, 50 ) )
					end
				end
			end
		else
			for i,v in pairs(getElementsByType("vehicle")) do
				if v ~= music.currentVehicle then
					if isElement( music.sounds[ v ] ) then
						music.sounds[ v ]:setVolume( 0 )
						music.sounds[ v ]:setMaxDistance( map( 0, 0, 100, 20, 50 ) )
					end
				end
			end
		end
	end
end

local update = function ( deltaTime )
	deltaTime = deltaTime / 1000

	if isElement( music.sounds[ music.currentVehicle ] ) and not isSoundPaused( music.sounds[ music.currentVehicle ] ) then
		music.animations.soundAlpha = math.abs( math.sin( getTickCount( ) * 0.003 ) )
	end

	music.animations.scrollList = music.animations.scrollList + ( music.animations.scrollListTarget - music.animations.scrollList ) * 5 * deltaTime

	if music.animations.main_volume then
		music.settings.main_volume = math.max( math.min( music.settings.main_volume + music.animations.main_volume * 10 * deltaTime, 100 ), 0 )
	end

	if music.animations.all_vehicles_volume then
		music.settings.all_vehicles_volume = math.max( math.min( music.settings.all_vehicles_volume + music.animations.all_vehicles_volume * 10 * deltaTime, 100 ), 0 )
	end

	if music.loading then
		music.animations.loading = music.animations.loading + 2 * 200 * deltaTime
	end
end

local getColor = function ( color, alpha )
	local color = music.colors[ color ]
	local b = bitExtract ( color, 0, 8 ) 
    local g = bitExtract ( color, 8, 8 ) 
    local r = bitExtract ( color, 16, 8 ) 

	return tocolor( r, g, b, alpha or 255 )
end


local getSoundIndex = function ( playlist, url )
	for i,v in pairs( playlist ) do
		if v.url == url then
			return i
		end
	end

	return false
end

local removeSound = function ( vehicle )
	if isElement( music.sounds[ vehicle ] ) then
		stopSound( music.sounds[ vehicle ] )
	end
	music.sounds[ vehicle ] = nil
end

local setSound = function ( vehicle, data )
	removeSound( vehicle )
	
	local results = { pcall( loadstring( "return playSound3D( " .. tostring( data.url ) .. ", 5000, 5000, 5000, false, true )" ) ) }

	music.sounds[ vehicle ] = results[ 2 ]
	
	if vehicle == music.currentVehicle then
		updateVolume( "main" )
	else
		updateVolume( "all" )
	end
	music.sounds[ vehicle ]:setMinDistance( 10 )
	music.sounds[ vehicle ]:attach( vehicle )
	
	music.sounds[ vehicle ]:setPaused( data.pause )
end

local nextSound = function ( vehicle, force )
	if vehicle and isElement( vehicle ) then
		local data = vehicle:getData( "music:data" )

		if isElement( music.sounds[ vehicle ] ) and data and data.url ~= "nil" then
			local index = getSoundIndex( data.playlist, data.url )
			local new_index = index
			
			if not music.repeate or force then
				if music.reverse then
					repeat new_index = ( math.random( 1, #data.playlist ) ) until new_index ~= index
				else
					if new_index >= #data.playlist then
						new_index = 1
					else
						new_index = new_index + 1
					end
				end
			end

			triggerServerEvent( "setVehicleSound", resourceRoot, vehicle, data.playlist[ new_index ], data.playlist )
		end
	end
end

local prevSound = function ( vehicle, force )
	if vehicle and isElement( vehicle ) then
		local data = vehicle:getData( "music:data" )

		if isElement( music.sounds[ vehicle ] ) and data and data.url ~= "nil" then
			local index = getSoundIndex( data.playlist, data.url )
			local new_index = index

			if not music.repeate or force then
				if music.reverse then
					repeat new_index = ( math.random( 1, #data.playlist ) ) until new_index ~= index
				else
					if new_index <= 1 then
						new_index = #data.playlis
					else
						new_index = new_index - 1
					end
				end
			end

			triggerServerEvent( "setVehicleSound", resourceRoot, vehicle, data.playlist[ new_index ], data.playlist )
		end
	end
end

local startSearch = function ( )
	if utf8.find( music.edit.text, "https://" ) or utf8.find( music.edit.text, "http://" ) or utf8.find( music.edit.text, "ftp://" ) then
		music.list = { }

		table.insert( music.list, { url = '"' .. music.edit.text .. '"', name = "Пользовательская ссылка №"..( #music.saveList + 1 ), author = music.edit.text } )
		music.edit.text = ""

		music.searchList = music.list
		music.listFullScroll = #music.list * 44 - 396
		music.animations.scrollListTarget = 0
	else
		triggerServerEvent( "onPlayerSearchMusic", localPlayer, music.edit.text )
		music.loading = true
	end
end

local draw = function (  )
	local w, h = 800, 540
	local x, y = screenSize.x / 2 - w / 2, screenSize.y / 2 - h / 2

	local music_data = isElement( music.currentVehicle ) and music.currentVehicle:getData( "music:data" ) or music.data_default

	if music.settings.visible then
		dxDrawImage( x + w + 16, y + 64, 230, 72, Assets.Textures[ "settings_bg" ], 0, 0, 0, getColor( "bg", 255 ) )

		dxDrawImage( x + w + 16 + 36, y + 64 + 16 + 16 / 2 - 12 / 2, 146, 12, Assets.Textures[ "all_vehs_label" ], 0, 0, 0, getColor( "white", 255 ) )
		if music.settings.all_vehicles then
			if isMouseInPosition( x + w + 16 + 12, y + 64 + 16, 16, 16 ) then
				dxDrawImage( x + w + 16 + 12, y + 64 + 16, 16, 16, Assets.Textures[ "checkbox_active" ], 0, 0, 0, getColor( "white", 255  ) )
			else
				dxDrawImage( x + w + 16 + 12, y + 64 + 16, 16, 16, Assets.Textures[ "checkbox_active" ], 0, 0, 0, getColor( "gray", 255  ) )
			end

			dxDrawRoundRectangle( x + w + 16 + 36, y + 64 + 54, 158, 4, getColor( "button", 255 ), false )
			if music.settings.all_vehicles_volume > 1 then
				dxDrawRoundRectangle( x + w + 16 + 36, y + 64 + 54, 158 / 100 * music.settings.all_vehicles_volume, 4, getColor( "white", 255  ), false )
			end
			if isMouseInPosition( x + w + 16 + 36, y + 64 + 54, 158, 4 ) and not music.scroll then
				if getKeyState( "mouse1" ) then
					if not music.click then
						music.click = true
						
						music.scroll = "all_vehicles_volume"
					end
				else
					music.click = false
				end
			end

			if isMouseInPosition( x + w + 16 + 12, y + 64 + 48, 16, 16 ) then
				dxDrawImage( x + w + 16 + 12, y + 64 + 48, 16, 16, Assets.Textures[ "volume-low-small" ], 0, 0, 0, getColor( "white", 255 ) )
				if getKeyState( "mouse1" ) then
					music.animations.all_vehicles_volume = -5
					updateVolume( "all" )
				else
					music.animations.all_vehicles_volume = false
				end
			else
				dxDrawImage( x + w + 16 + 12, y + 64 + 48, 16, 16, Assets.Textures[ "volume-low-small" ], 0, 0, 0, getColor( "gray", 255 ) )
			end

			if isMouseInPosition( x + w + 16 + 202, y + 64 + 48, 16, 16 ) then
				dxDrawImage( x + w + 16 + 202, y + 64 + 48, 16, 16, Assets.Textures[ "volume-up-small" ], 0, 0, 0, getColor( "white", 255 ) )
				if getKeyState( "mouse1" ) then
					music.animations.all_vehicles_volume = 5
					updateVolume( "all" )
				else
					music.animations.all_vehicles_volume = false
				end
			else
				dxDrawImage( x + w + 16 + 202, y + 64 + 48, 16, 16, Assets.Textures[ "volume-up-small" ], 0, 0, 0, getColor( "gray", 255 ) )
			end
		else
			if isMouseInPosition( x + w + 16 + 12, y + 64 + 16, 16, 16 ) then
				dxDrawImage( x + w + 16 + 12, y + 64 + 16, 16, 16, Assets.Textures[ "checkbox" ], 0, 0, 0, getColor( "white", 255 ) )
			else
				dxDrawImage( x + w + 16 + 12, y + 64 + 16, 16, 16, Assets.Textures[ "checkbox" ], 0, 0, 0, getColor( "gray", 255 ) )
			end
		end


		if isMouseInPosition( x + w + 16 + 12, y + 64 + 16, 16, 16 ) then
			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true

					music.settings.all_vehicles = not music.settings.all_vehicles
					updateVolume( "all" )
				end
			else
				music.click = false
			end
		end

		if isMouseInPosition( x + w + 16 + 202, y + 64 + 16, 16, 16 ) then
			dxDrawImage( x + w + 16 + 202, y + 64 + 16, 16, 16, Assets.Textures[ "close" ], 0, 0, 0, getColor( "white", 255  ) )

			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true

					music.settings.visible = false
				end
			else
				music.click = false
			end
		else
			dxDrawImage( x + w + 16 + 202, y + 64 + 16, 16, 16, Assets.Textures[ "close" ], 0, 0, 0, getColor( "gray", 255  ) )
		end
	end

	dxDrawImage( x, y, w, h, Assets.Textures[ "main_bg" ], 0, 0, 0, getColor( "bg", 255 ) )

	dxDrawImage( x + w / 2 - 185 / 2, y + 16, 185, 18, Assets.Textures[ "player_label" ], 0, 0, 0, getColor( "white", 255 ) )

	dxDrawImage( x + 32, y + 64, 272, 240, Assets.Textures[ "cover_bg" ], 0, 0, 0, getColor( "button", 255 ) )
	dxDrawImage( x + 32 + 272 / 2 - 128 / 2, y + 64 + 240 / 2 - 128 / 2, 128, 128, Assets.Textures[ "cover" ], 0, 0, 0, getColor( "white", 255 ) )

	local name = music_data.name

	if utf8.len( name ) >= 18 then
		name = utf8.sub( music_data.name, 1, 18 ) .. "..."
	end

	local author = music_data.author

	if utf8.len( author ) >= 25 then
		author = utf8.sub( music_data.author, 1, 25 ) .. "..."
	end
	dxDrawText( name, x + 32, y + 322, 272, 25, getColor( "white", 255 ), 0.5, Assets.Fonts[ "bold" ], "center", "center" )
	dxDrawText( author, x + 32, y + 348, 272, 25, getColor( "gray", 255 ), 0.5, Assets.Fonts[ "medium" ], "center", "center" )


	if isMouseInPosition( x + 32, y + 322, 24, 24 ) then
		dxDrawImage( x + 32, y + 322, 24, 24, Assets.Textures[ "copy" ], 0, 0, 0, getColor( "white", 255 ) )
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true

				if isElement( music.sounds[ music.currentVehicle ] ) then 
					setClipboard( music_data.author .. " - " .. music_data.name )
					outputChatBox( "[Музыкальный плеер]#ffffff " .. music_data.author .. " - " .. music_data.name .. " #999999- скопировано в буфер обмена.", 200, 200, 200, true )
				end
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 32, y + 322, 24, 24, Assets.Textures[ "copy" ], 0, 0, 0, getColor( "gray", 255 ) )
	end


	if getMusic( music_data.url ) then
		if isMouseInPosition( x + 280, y + 322, 24, 24 ) then
			dxDrawImage( x + 280, y + 322, 24, 24, Assets.Textures[ "like_active" ], 0, 0, 0, getColor( "white", 255 ) )
			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true

					if isElement( music.sounds[ music.currentVehicle ] ) then 
						deleteSaveMusic( music_data.url )
					end
				end
			else
				music.click = false
			end
		else
			dxDrawImage( x + 280, y + 322, 24, 24, Assets.Textures[ "like_active" ], 0, 0, 0, getColor( "gray", 255 ) )
		end
	else
		if isMouseInPosition( x + 280, y + 322, 24, 24 ) then
			dxDrawImage( x + 280, y + 322, 24, 24, Assets.Textures[ "like" ], 0, 0, 0, getColor( "white", 255 ) )
			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true

					if isElement( music.sounds[ music.currentVehicle ] ) then 
						table.insert( music.saveList, { url = music_data.url, author = music_data.author, name = music_data.name } )
					end
				end
			else
				music.click = false
			end
		else
			dxDrawImage( x + 280, y + 322, 24, 24, Assets.Textures[ "like" ], 0, 0, 0, getColor( "gray", 255 ) )
		end
	end

	dxDrawRoundRectangle( x + 32, y + 381, 272, 4, getColor( "gray", 255 ), false )

	if isElement( music.sounds[ music.currentVehicle ] ) then
		local soundLength = getSoundLength( music.sounds[ music.currentVehicle ] )
        local soundPosition = getSoundPosition( music.sounds[ music.currentVehicle ] )

        if soundLength and soundLength > 0 and soundPosition > 1 then
	        if soundPosition then
	        	dxDrawRoundRectangle( x + 32, y + 381, 272 * ( soundPosition / soundLength ), 4, getColor( "white", 255 ), false )
	        end
	    end

	    dxDrawText( ( "%d:%02d" ) : format( soundPosition / 60, soundPosition % 60 ), x + 32, y + 388, 272, 20, getColor( "gray", 255 ), 0.5, Assets.Fonts[ "medium" ], "left", "top" )
	    dxDrawText( ( "%d:%02d" ) : format( soundLength / 60, soundLength % 60 ), x + 32, y + 388, 272, 20, getColor( "gray", 255 ), 0.5, Assets.Fonts[ "medium" ], "right", "top" )
	end

	dxDrawRoundRectangle( x + 88, y + 495, 160, 4, getColor( "gray", 255 ), false )
	if music.settings.main_volume > 1 then
		dxDrawRoundRectangle( x + 88, y + 495, 160 / 100 * music.settings.main_volume, 4, getColor( "white", 255 ), false )
	end
	if isMouseInPosition( x + 88, y + 495, 160, 4 ) and not music.scroll then
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true
	
				music.scroll = "main_volume"
			end
		else
			music.click = false
		end
	end

	if music.scroll then
		music.animations.main_volume = false
		music.animations.all_vehicles_volume = false
		if not getKeyState( "mouse1" ) then
			music.scroll = false
		end

		local cX, cY = getMousePos( )

		if music.scroll == "main_volume" then
			music.settings.main_volume = math.max( math.min ( ( ( 100 / 160 ) * ( cX - ( x + 88 ) ) ), 100 ), 0 )

			updateVolume( "main" )
		elseif music.scroll == "all_vehicles_volume" and music.settings.visible and music.settings.all_vehicles then
			music.settings.all_vehicles_volume = math.max( math.min ( ( ( 100 / 158 ) * ( cX - ( x + w + 16 + 36 ) ) ), 100 ), 0 )
			updateVolume( "all" )
		elseif music.scroll == "scrollList" then
			music.animations.scrollListTarget = math.max( math.min ( ( ( music.listFullScroll / 396 ) * ( cY - ( y + 112 ) ) ), music.listFullScroll ), 0 )
		end
	end

	if isMouseInPosition( x + 56, y + 483, 24, 24 ) then
		dxDrawImage( x + 56, y + 483, 24, 24, Assets.Textures[ "volume-low" ], 0, 0, 0, getColor( "white", 255 ) )
	
		if getKeyState( "mouse1" ) then
			music.animations.main_volume = -5
			updateVolume( "main" )
		else
			music.animations.main_volume = false
		end
	else
		dxDrawImage( x + 56, y + 483, 24, 24, Assets.Textures[ "volume-low" ], 0, 0, 0, getColor( "gray", 255 ) )
	end
	
	if isMouseInPosition( x + 256, y + 483, 24, 24 ) then
		dxDrawImage( x + 256, y + 483, 24, 24, Assets.Textures[ "volume-up" ], 0, 0, 0, getColor( "white", 255 ) )
	
		if getKeyState( "mouse1" ) then
			music.animations.main_volume = 5
			updateVolume( "main" )
		else
			music.animations.main_volume = false
		end
	else
		dxDrawImage( x + 256, y + 483, 24, 24, Assets.Textures[ "volume-up" ], 0, 0, 0, getColor( "gray", 255 ) )
	end

	if isElement( music.sounds[ music.currentVehicle ] ) and not isSoundPaused( music.sounds[ music.currentVehicle ] ) then
		if isMouseInPosition( x + 140, y + 415, 56, 56 ) then
			dxDrawImage( x + 140, y + 415, 56, 56, Assets.Textures[ "pause" ], 0, 0, 0, getColor( "white", 155 ) )

			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true
					if antiDOScheck( ) then
						triggerServerEvent( "setVehicleSoundPaused", resourceRoot, music.currentVehicle, true )
					end
				end
			else
				music.click = false
			end
		else
			dxDrawImage( x + 140, y + 415, 56, 56, Assets.Textures[ "pause" ], 0, 0, 0, getColor( "white", 255 ) )
		end
	else
		if isMouseInPosition( x + 140, y + 415, 56, 56 ) then
			dxDrawImage( x + 140, y + 415, 56, 56, Assets.Textures[ "play" ], 0, 0, 0, getColor( "white", 155 ) )
			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true

					if antiDOScheck( ) then
						if isElement( music.sounds[ music.currentVehicle ] ) and isSoundPaused( music.sounds[ music.currentVehicle ] ) then
							triggerServerEvent( "setVehicleSoundPaused", resourceRoot, music.currentVehicle, false )
						end
					end
				end
			else
				music.click = false
			end
		else
			dxDrawImage( x + 140, y + 415, 56, 56, Assets.Textures[ "play" ], 0, 0, 0, getColor( "white", 255 ) )
		end
	end

	if isMouseInPosition( x + 84, y + 431, 24, 24 ) then
		dxDrawImage( x + 84, y + 431, 24, 24, Assets.Textures[ "prev" ], 0, 0, 0, getColor( "white", 255 ) )
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true
				if antiDOScheck( ) then
					prevSound( music.currentVehicle, true )
				end
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 84, y + 431, 24, 24, Assets.Textures[ "prev" ], 0, 0, 0, getColor( "gray", 255 ) )
	end

	if isMouseInPosition( x + 228, y + 431, 24, 24 ) then
		dxDrawImage( x + 228, y + 431, 24, 24, Assets.Textures[ "next" ], 0, 0, 0, getColor( "white", 255 ) )
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true
				if antiDOScheck( ) then
					nextSound( music.currentVehicle, true )
				end
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 228, y + 431, 24, 24, Assets.Textures[ "next" ], 0, 0, 0, getColor( "gray", 255 ) )
	end

	if music.reverse then
		dxDrawImage( x + 32, y + 431, 24, 24, Assets.Textures[ "reverse" ], 0, 0, 0, getColor( "white", 255 ) )
	else
		dxDrawImage( x + 32, y + 431, 24, 24, Assets.Textures[ "reverse" ], 0, 0, 0, getColor( "gray", 255 ) )
	end

	if isMouseInPosition( x + 32, y + 431, 24, 24 ) then
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true
				
				music.reverse = not music.reverse
			end
		else
			music.click = false
		end
	end

	if music.repeate then
		dxDrawImage( x + 280, y + 431, 24, 24, Assets.Textures[ "repeate" ], 0, 0, 0, getColor( "white", 255 ) )
	else
		dxDrawImage( x + 280, y + 431, 24, 24, Assets.Textures[ "repeate" ], 0, 0, 0, getColor( "gray", 255 ) )
	end

	if isMouseInPosition( x + 280, y + 431, 24, 24 ) then
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true
				
				music.repeate = not music.repeate
			end
		else
			music.click = false
		end
	end

	if not music.loading then
		dxSetRenderTarget( listRT )
		dxDrawRectangle( 0, 0, 430, 396, getColor( "bg", 255 ) )
		for i,v in pairs( music.list ) do
			if 44 * ( i - 1 ) - music.animations.scrollList >= -44 and 44 * ( i - 1 ) - music.animations.scrollList <= 380 then
				if v.url == music_data.url then
					dxDrawImage( 0, 44 * ( i - 1 ) - music.animations.scrollList, 430, 44, Assets.Textures[ "string_bg" ], 0, 0, 0, getColor( "button", 255 ) )

					if isElement( music.sounds[ music.currentVehicle ] ) and not isSoundPaused( music.sounds[ music.currentVehicle ] ) then
						dxDrawImage( 44 / 2 - 16 / 2, 44 / 2 - 16 / 2 + 44 * ( i - 1 ) - music.animations.scrollList, 16, 16, Assets.Textures[ "sound" ], 0, 0, 0, getColor( "white", 255 * music.animations.soundAlpha ) )
					else
						dxDrawImage( 44 / 2 - 16 / 2, 44 / 2 - 16 / 2 + 44 * ( i - 1 ) - music.animations.scrollList, 16, 16, Assets.Textures[ "sound" ], 0, 0, 0, getColor( "white", 100 ) )
					end
				elseif isMouseInPosition( x + 336, y + 112 + 44 * ( i - 1 ) - music.animations.scrollList, 430, 44 ) and isMouseInPosition( x + 336, y + 112, 430, 396 ) then
					dxDrawImage( 0, 44 * ( i - 1 ) - music.animations.scrollList, 430, 44, Assets.Textures[ "string_bg" ], 0, 0, 0, getColor( "button", 255 ) )
					dxDrawText( string.format( "%02d", i ), 0, 44 * ( i - 1 ) - music.animations.scrollList, 44, 44, getColor( "white", 255 ), 0.5, Assets.Fonts[ "medium" ], "center", "center" )

					if not isMouseInPosition( x + 336 + 390, y + 112 + 44 / 2 - 16 / 2 + 44 * ( i - 1 ) - music.animations.scrollList, 16, 16 ) then
						if getKeyState( "mouse1" ) then
							if not music.click then
								music.click = true
								triggerServerEvent( "setVehicleSound", resourceRoot, music.currentVehicle, v, music.list )
							end
						else
							music.click = false
						end
					end
				else
					dxDrawText( string.format( "%02d", i ), 0, 44 * ( i - 1 ) - music.animations.scrollList, 44, 44, getColor( "white", 255 ), 0.5, Assets.Fonts[ "medium" ], "center", "center" )
				end


				local name = v.name

				if utf8.len( name ) >= 30 then
					name = utf8.sub( v.name, 1, 30 ) .. "..."
				end

				local author = v.author

				if utf8.len( author ) >= 40 then
					author = utf8.sub( v.author, 1, 40 ) .. "..."
				end

				dxDrawText( name, 61, 6 + 44 * ( i - 1 ) - music.animations.scrollList, 400, 16, getColor( "white", 255 ), 0.5, Assets.Fonts[ "bold_small" ], "left", "center" )
				dxDrawText( author, 61, 24 + 44 * ( i - 1 ) - music.animations.scrollList, 400, 16, getColor( "gray", 255 ), 0.5, Assets.Fonts[ "medium" ], "left", "center" )

				if getMusic( v.url ) then
					dxDrawImage( 390, 44 / 2 - 16 / 2 + 44 * ( i - 1 ) - music.animations.scrollList, 16, 16, Assets.Textures[ "saved" ], 0, 0, 0, getColor( "white", 255 ) )
				else
					dxDrawImage( 390, 44 / 2 - 16 / 2 + 44 * ( i - 1 ) - music.animations.scrollList, 16, 16, Assets.Textures[ "no_saved" ], 0, 0, 0, getColor( "gray", 255 ) )
				end

				if isMouseInPosition( x + 336 + 390, y + 112 + 44 / 2 - 16 / 2 + 44 * ( i - 1 ) - music.animations.scrollList, 16, 16 ) and isMouseInPosition( x + 336, y + 112, 430, 396 ) then
					if getKeyState( "mouse1" ) then
						if not music.click then
							music.click = true

							if getMusic( v.url ) then
								deleteSaveMusic( v.url )
							else
								table.insert( music.saveList, v )
							end

							saveSaves( )
						end
					else
						music.click = false
					end
				end
			end
		end
		dxSetRenderTarget( )
	end

	if not music.loading then
		if #music.list == 0 then
			dxDrawText( "Ничего не найдено", x + 336, y + 112, 430, 396, getColor( "gray", 255 ), 0.5, Assets.Fonts[ "medium" ], "center", "center" )
		else
			dxDrawImage( x + 336, y + 112, 430, 396, listRT, 0, 0, 0, getColor( "white", 255 ) )
		end
	else
		dxDrawImage( x + 336 + 430 / 2 - 48 / 2, y + 112 + 396 / 2 - 48 / 2, 48, 48, Assets.Textures[ "loading" ], music.animations.loading, 0, 0, getColor( "white", 255 ) )
	end


	if music.listFullScroll + 396 > 396 then
		dxDrawRoundRectangle( x + 784, y + 112, 4, 396, getColor( "button", 255 ), true )


		local scroll_height = 80
		local scroll_position = music.animations.scrollList / music.listFullScroll * ( 396 - scroll_height )

		dxDrawRoundRectangle( x + 784, y + 112 + math.max( scroll_position, 0 ), 4, scroll_height, getColor( "white", 255 ), true )

		if isMouseInPosition( x + 784, y + 112, 4, 396 ) and not music.scroll then
			if getKeyState( "mouse1" ) then
				if not music.click then
					music.click = true

					music.scroll = "scrollList"
				end
			else
				music.click = false
			end
		end
	end

	if isMouseInPosition( x + 336, y + 64, 175, 36 ) then
		dxDrawImage( x + 336, y + 64, 175, 36, Assets.Textures[ "edit" ], 0, 0, 0, getColor( "hover", 255 ) )
		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true

				music.edit.active = true
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 336, y + 64, 175, 36, Assets.Textures[ "edit" ], 0, 0, 0, getColor( "button", 255 ) )
		if getKeyState( "mouse1" ) then
			music.edit.active = false
		end
	end

	local edit_text = music.edit.text == "" and "Название / ссылка" or music.edit.text
	if music.edit.active then
		dxDrawImage( x + 336 + 36 / 2 - 16 / 2, y + 64 + 36 / 2 - 16 / 2, 16, 16, Assets.Textures[ "search" ], 0, 0, 0, getColor( "white", 255 ) )

		dxSetRenderTarget( editRT, true )
		dxSetBlendMode( "add" )
		local edit_width = dxGetTextWidth( edit_text, 0.5, Assets.Fonts[ "medium" ] )
		dxDrawText( edit_text, edit_width > 135 and 135 - edit_width or 0, 0, 135, 36, getColor( "white", 255 ), 0.5, Assets.Fonts[ "medium" ], "left", "center"  )
		dxSetBlendMode( "blend" )
		dxSetRenderTarget( )
		dxDrawImage( x + 336 + 34, y + 64, 135, 36, editRT )
	else
		dxDrawImage( x + 336 + 36 / 2 - 16 / 2, y + 64 + 36 / 2 - 16 / 2, 16, 16, Assets.Textures[ "search" ], 0, 0, 0, getColor( "gray", 255 ) )
		dxSetRenderTarget( editRT, true )
		dxSetBlendMode( "add" )
		local edit_width = dxGetTextWidth( edit_text, 0.5, Assets.Fonts[ "medium" ] )
		dxDrawText( edit_text, edit_width > 135 and 135 - edit_width or 0, 0, 135, 36, getColor( "gray", 255 ), 0.5, Assets.Fonts[ "medium" ], "left", "center"  )
		dxSetBlendMode( "blend" )
		dxSetRenderTarget( )
		dxDrawImage( x + 336 + 34, y + 64, 135, 36, editRT )
	end

	if isMouseInPosition( x + 523, y + 64, 59, 36 ) then
		dxDrawImage( x + 523, y + 64, 59, 36, Assets.Textures[ "search_btn" ], 0, 0, 0, getColor( "hover", 255 ) )


		if getKeyState( "mouse1" ) then
			if not music.click then
				if not music.loading then
					music.click = true
					if music.tab ~= "saved" then
						if antiDOScheck( ) then
							startSearch( )
						end
					else
						filterSaveList( )
					end
				end
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 523, y + 64, 59, 36, Assets.Textures[ "search_btn" ], 0, 0, 0, getColor( "button", 255 ) )
	end
	dxDrawImage( x + 523 + 59 / 2 - 37 / 2, y + 64 + 36 / 2 - 11 / 2, 37, 11, Assets.Textures[ "search_label" ], 0, 0, 0, getColor( "white", 255 ) )

	if isMouseInPosition( x + 594, y + 64, 124, 36 ) then
		dxDrawImage( x + 594, y + 64, 124, 36, Assets.Textures[ "saved_btn" ], 0, 0, 0, getColor( "hover", 255 ) )

		if getKeyState( "mouse1" ) then
			if not music.click then
				if not music.loading then
					music.click = true

					music.tab = music.tab == "saved" and "main" or "saved"

					if music.tab == "saved" then
						music.searchList = music.list
						music.list = table.copy( music.saveList )

						music.listFullScroll = #music.list * 44 - 396
					else
						music.list = music.searchList

						music.listFullScroll = #music.list * 44 - 396
					end


					music.edit.text = ""

					music.animations.scrollListTarget = 0
				end
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 594, y + 64, 124, 36, Assets.Textures[ "saved_btn" ], 0, 0, 0, getColor( "button", 255 ) )
	end

	dxDrawImage( x + 594 + 36, y + 64 + 36 / 2 - 13 / 2 + 1, 76, 13, Assets.Textures[ "my_music_label" ], 0, 0, 0, getColor( "white", 255 ) )

	if music.tab == "saved" then
		dxDrawImage( x + 594 + 36 / 2 - 16 / 2, y + 64 + 36 / 2 - 16 / 2, 16, 16, Assets.Textures[ "saved" ], 0, 0, 0, getColor( "white", 255 ) )
	else
		dxDrawImage( x + 594 + 36 / 2 - 16 / 2, y + 64 + 36 / 2 - 16 / 2, 16, 16, Assets.Textures[ "no_saved" ], 0, 0, 0, getColor( "white", 255 ) )
	end

	if isMouseInPosition( x + 730, y + 64, 36, 36 ) then
		dxDrawImage( x + 730, y + 64, 36, 36, Assets.Textures[ "settings_btn" ], 0, 0, 0, getColor( "hover", 255 ) )

		if getKeyState( "mouse1" ) then
			if not music.click then
				music.click = true

				music.settings.visible = not music.settings.visible

				if music.settings.visible then
					music.animations.settingsAlphaTarget = 1
				else
					music.animations.settingsAlphaTarget = 0
				end
			end
		else
			music.click = false
		end
	else
		dxDrawImage( x + 730, y + 64, 36, 36, Assets.Textures[ "settings_btn" ], 0, 0, 0, getColor( "button", 255 ) )
	end
	dxDrawImage( x + 730 + 36 / 2 - 16 / 2, y + 64 + 36 / 2 - 16 / 2, 16, 16, Assets.Textures[ "settings" ], 0, 0, 0, getColor( "white", 255 ) )
end

local onCharacter = function ( character )
	if music.edit.active then
    	music.edit.text = music.edit.text .. character
    end
end

handleKey = function ( key, repeatKey )
	local w, h = 800, 540
	local x, y = screenSize.x / 2 - w / 2, screenSize.y / 2 - h / 2

	if music.edit.active then
        if key == "backspace" then
        	if getKeyState( "lshift" ) or getKeyState( "rshift" ) then
        		music.edit.text = ""
        	else
        		music.edit.text = utf8.sub( music.edit.text, 1, utf8.len( music.edit.text ) - 1 )
        	end
        elseif key == "enter" then
        	if music.tab ~= "saved" then
	        	if not antiDOScheck( ) then return end
	        	if not music.loading then
		        	startSearch( )
		        end
	        else
	        	filterSaveList( )
	        end
        elseif key == "lctl" then
       	elseif key == "rctl" then
       	elseif key == "v" then
        else
        	cancelEvent( )
        end
    end

	if isMouseInPosition( x + 336, y + 112, 430, 396 ) then
	    if key ==  "mouse_wheel_up" then
	        if music.animations.scrollListTarget > 0  then
	            music.animations.scrollListTarget = math.max( music.animations.scrollListTarget - 44, 0 )
	        end
	    elseif key == "mouse_wheel_down" then
	    	if music.animations.scrollListTarget < music.listFullScroll  then
	        	music.animations.scrollListTarget = math.min( music.animations.scrollListTarget + 44, music.listFullScroll )
	        end
	    end
	end

	if key == "backspace" and repeatKey and getKeyState( key ) then
		repeatEditTimer = setTimer( handleKey, 50, 1, key, true )
	end
end

local onKey = function ( key, press )
	if not press then
		if isTimer( repeatEditStartTimer ) then
			killTimer( repeatEditStartTimer )
		end
		if isTimer( repeatEditTimer ) then
			killTimer( repeatEditTimer )
		end		
		return
	end
	handleKey( key, false )

	if key == "backspace" then
		repeatEditStartTimer = setTimer( handleKey, 500, 1, key, true )
	end
end

local onPaste = function ( text )
	if music.edit.active then
    	music.edit.text = music.edit.text .. text
    end
end

bindKey( "0", "down", function ( )
	
	if not getPedOccupiedVehicle (localPlayer) then return end

	music.visible = not music.visible

	if music.visible then
		if localPlayer.interior == 0 and localPlayer.dimension == 0 then
			if not isEventHandlerAdded( "onClientRender", root, draw ) then
				
				triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, false)
				showChat(false)
				triggerEvent('operShowUI.drawBlurShader', localPlayer, true)		


				addEventHandler( "onClientPreRender", root, update )
				addEventHandler( "onClientRender", root, draw )
				addEventHandler( "onClientCharacter", root, onCharacter )
				addEventHandler( "onClientKey", root, onKey )
				addEventHandler( "onClientPaste", root, onPaste )
			end
		end
		
	else
		if isEventHandlerAdded( "onClientRender", root, draw ) then
			removeEventHandler( "onClientPreRender", root, update )
			removeEventHandler( "onClientRender", root, draw )
			removeEventHandler( "onClientCharacter", root, onCharacter )
			removeEventHandler( "onClientKey", root, onKey )
			removeEventHandler( "onClientPaste", root, onPaste )
			
			triggerEvent('operShowUI.setVisiblePlayerUI', localPlayer, true)
			showChat(true)
			triggerEvent('operShowUI.drawBlurShader', localPlayer, false)
		end
		
		

	end
	showCursor( music.visible )
end )


addEvent("returnMusicSearch", true)
addEventHandler("returnMusicSearch", root, function ( data )
	local music_list = { }
    local lastPos = 0

	if data ~= "ERROR" then
	    local count = 50--select ( 2, utf8.gsub( data, 'c-artist">', "" ) )
	
	    for i = 0, count do
		
			
	        local _, startArtist = utf8.find( data, 'c-artist">', lastPos )
			
			-- iprint (startArtist)
			
	        local stopArtist = utf8.find( data, '</s', startArtist )
	        local _, startName = utf8.find( data, 'c-title">', lastPos )
	        local stopName = utf8.find( data, '</s', startName )
	        local preStartSUrl, startSUrl = utf8.find( data, 'url":"', lastPos )
	        local _, endSUrl = utf8.find( data, '.mp3"', startSUrl )
	
			-- iprint (startName)
	
	        if startSUrl and endSUrl then
	            if i > 0 then
	                local url = utf8.sub( data, startSUrl, endSUrl ) or ""
					
					if startArtist ~= nil then
						author = utf8.sub( data, startArtist + 1, stopArtist - 1) or ""
					end
					
					if startName ~= nil then
						name = utf8.sub( data, startName + 1, stopName - 1 ) or ""
					end
					-- iprint (startArtist)
	
					-- if 
	                table.insert( music_list, { author = author, name = name, url = url })
					
	                lastPos = stopName
					
	            else
	                lastPos = preStartSUrl
	            end
	        end
			
			
			
	    end
	
		music.list = music_list
		music.searchList = music_list
		music.listFullScroll = #music.list * 44 - 396
		music.animations.scrollListTarget = 0
	end

	music.loading = false
end )


addEventHandler( "onClientResourceStart", resourceRoot, function ( )
	loadSaves( )
	triggerServerEvent( "onPlayerSearchMusic", localPlayer, "" )
	music.loading = true

	-- вырубаем нахуй дефолт радио
	setRadioChannel( 0 )

	addEventHandler( "onClientPlayerRadioSwitch", localPlayer, function ( )
		cancelEvent( )
	end )
end )

addEventHandler("onClientResourceStop", resourceRoot, function ()
	for i,v in pairs(getElementsByType("vehicle")) do
		setElementData(v, "music:data", false)
	end
end)

addEventHandler( "onClientSoundStopped", root, function ( reason )
	if reason == "finished" then
		if music.currentVehicle and music.sounds[ music.currentVehicle ] and source == music.sounds[ music.currentVehicle ] then
			nextSound( music.currentVehicle )
		end
	end
end )

addEventHandler( "onClientVehicleEnter", root, function( player, seat )
	if player == localPlayer and seat == 0 then
		music.currentVehicle = localPlayer.vehicle

		updateVolume( "all" )
		updateVolume( "main" )
	end
end )

addEvent( "setVehicleSound", true )
addEventHandler( "setVehicleSound", resourceRoot, function( vehicle, data )
    if isElement( vehicle ) then
    	setSound( vehicle, data )
    end
end )

addEvent( "setVehicleSoundPaused", true )
addEventHandler( "setVehicleSoundPaused", resourceRoot, function( vehicle, state )
    if isElement( vehicle ) then
    	if music.sounds[ vehicle ] then
    		music.sounds[ vehicle ]:setPaused( state )
    	end
    end
end )

addEventHandler("onClientElementStreamIn", root, function()
	if source.type == "vehicle" then
		local data = source:getData( "music:data" )
		if data then
			setSound( source, data )
		end
	end
end )

onCarStreamOut = function ()
	if source.type == "vehicle" then
		removeSound( source )
	end
end
addEventHandler( "onClientElementStreamOut", root, onCarStreamOut )
addEventHandler( "onClientElementDestroy", root, onCarStreamOut )
