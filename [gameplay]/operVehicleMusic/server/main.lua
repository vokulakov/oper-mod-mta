local char_to_hex = function( c )
    return string.format( "%%%02X", string.byte( c ))
end

local urlencode = function ( url )
    if url == nil then
        return
    end
    url = url:gsub( "\n", "\r\n" )
    url = url:gsub( "([^%w ])", char_to_hex )
    url = url:gsub( " ", "+" )
    return url
end

readMusicData = function ( data, err, player )
    
    local _, preStart = utf8.find( data, '<body>' )
    local _, startS = utf8.find( data, 'c-section', preStart )
    local endS = utf8.find( data, 'l-side', startS )

    data = utf8.sub( data, startS, endS )

	-- iprint (data)

    triggerClientEvent( player, "returnMusicSearch", player, data )
end

addEvent( "onPlayerSearchMusic", true )
addEventHandler( "onPlayerSearchMusic", root, function ( text )
    if utf8.len( text ) >= 1 then
		-- https://savemusic.me/search/
        fetchRemote( "https://savemusic.me/search/"..urlencode( text ).."/", readMusicData, "", false, client )
    else
        fetchRemote( "https://savemusic.me/", readMusicData, "", false, client )
    end
end )

addEvent( "setVehicleSound", true )
addEventHandler( "setVehicleSound", resourceRoot, function( vehicle, data, playlist )
    if isElement( vehicle ) then

        local music_data = {
            name = data.name,
            author = data.author,
            url = data.url,
            playlist = playlist,
            pause = false,
        }

        vehicle:setData( "music:data", music_data )
        
        triggerClientEvent( "setVehicleSound", resourceRoot, vehicle, music_data )
    end
end )

addEvent( "setVehicleSoundPaused", true )
addEventHandler( "setVehicleSoundPaused", resourceRoot, function( vehicle, state )
    if isElement( vehicle ) then
        local data = vehicle:getData( "music:data" )
        if data then
            data.pause = state
            vehicle:setData( "music:data", data )

            triggerClientEvent( "setVehicleSoundPaused", resourceRoot, vehicle, state )
        end
    end
end )