local reportPlayers = {}
local isTegVisible = {}

function getPlayerRow ( player, table_f )
    local account = getAccountName ( getPlayerAccount ( player ) )
    if table_f =="1" then
        for i, data in ipairs ( reportPlayers ) do
	        if data[1] == account then
		        return data
		    end
	    end
		table.insert(reportPlayers, {account, true} )
    elseif table_f =="2" then
        for i, data in ipairs ( isTegVisible ) do
	        if data[1] == account then
		        return data
		    end
	    end
		table.insert(isTegVisible, {account, true} )
    end
	
	return {account, true}
end

function updatePlayerRow ( player, table_f  )
	local account = getAccountName ( getPlayerAccount ( player ) )
    if table_f =="1" then
        for i, data in ipairs ( reportPlayers ) do
	    	if data[1] == account then
		    	rawset(reportPlayers, i, {data[1], not data[2] } )
				return
			end
		end
    elseif table_f =="2" then
        for i, data in ipairs ( isTegVisible ) do
	    	if data[1] == account then
		    	rawset(isTegVisible, i, {data[1], not data[2] } )
				return
			end
		end
    end
end

function isReportAllowed ( player )
	local row = getPlayerRow ( player, "1" )

	return row[2]
end

function isChatTegVisible ( player )
	local row = getPlayerRow ( player, "2" )

	return row[2]
end

function showReportChat ( ThePlayer )
    local row = getPlayerRow ( ThePlayer, "1" )
	updatePlayerRow ( ThePlayer, "1" )
end
--addCommandHandler("showreport", showReportChat)

function doChatTegVisible ( ThePlayer )
    local row = getPlayerRow ( ThePlayer, "2" )
	updatePlayerRow ( ThePlayer, "2" )
end
--addCommandHandler("showadminteg", doChatTegVisible)

function getPlayerFromID ( id )
        for k, player in ipairs ( getElementsByType ( "player" ) ) do
                local p_id = getElementData ( player, "ID" )
                if ( p_id == tonumber(id) ) then
                        player_n = getPlayerName ( player )
                        return player, player_n
                end
        end
                return false, "No player has been found with the ID " .. id .. "."
end

local last_msg 			= {{ }}
local cooldownTimers 		= { }
local characteraddition 	= 100
local antiSpamTime 		= 1000
local maxbubbles 		= 4
local chat_range 		= 180
local showtime 			= 7500
local hideown 			= true
local defR,defG,defB		= 240, 235, 255

local nameOfIRCResource	= "irc"

local lawTeams = {
	["Government"] 			= true,
	["Emergency service"] 		= true,
}
local policeTeams = {
	["Government"] 			= true,
}

local enable_bad_word_replacement 	= false
local patterns = {
	{ "fuck", "feck" },
	{ "fuk", "feck" },
	{ "shit", "feck" },
	{ "bitch", "feck" },
	{ "cock", "feck" },
	{ "cunt", "feck" },
	{ "nigger", "feck" },
	{ "dick", "feck" },
	{ "whore", "feck" },
	{ "fag", "feck" },
	{ "pussy", "feck" },
	{ "hoe", "feck" },
	{ "slut", "feck" },
	{ "twat", "feck" },
	{ "tits", "feck" },
	{ "mtasa://", "gtw://" },
}

function getGroupChatColor(group)
	local r,g,b = exports.GTWgroups:getGroupChatColor(group)
	if not r or not g or not b then
		r,g,b = defR,defG,defB
	end
	return r,g,b
end

function outputToChat(text, visible_to, red, green, blue, color_coded)
	if enable_bad_word_replacement then
		for k,v in pairs(patterns) do
			text = string.gsub(text, v[1], v[2])
		end
	end
	outputChatBox(text, visible_to, red, green, blue, color_coded)
end

function cleanUpChat()
	last_msg[source] = nil
	cooldownTimers[source] = nil
end
addEventHandler("onPlayerQuit", root, cleanUpChat)

function is_player_in_range(player,x,y,z,range)
   local px,py,pz = getElementPosition(player)
   return((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end

function isServerStaff(plr)
	if (not plr) or (not getPlayerAccount(plr)) then return false end

	local acc = getAccountName(getPlayerAccount(plr))
	if isObjectInACLGroup("user."..acc, aclGetGroup("Admin")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Admin_1_lvl")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Admin_2_lvl")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Admin_3_lvl")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Admin_4_lvl")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Admin_5_lvl")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Admin_6_lvl")) or
		isObjectInACLGroup("user."..acc, aclGetGroup("Console")) then
		return true
	else
		return false
	end
end

function validateChatInput(plr, chatID, text)
	if isPlayerMuted(plr) then
		outputToChat("У вас мут, вы не можете что-либо писать", plr, 255, 100, 0)
		return false
	end
	if isTimer(cooldownTimers[plr]) then
		outputToChat("Не спамьте!", plr, 255, 100, 0)
		return false
	end
	if chatID == "car" and not getPedOccupiedVehicle(plr) then
		outputToChat("Эту команду возможно использовать только в автомобиле", plr, 255, 100, 0)
		return false
	end
	return true
end
--[[
function reportPlayer (ThePlayer, cmd, ...)
    if not isPlayerMuted (ThePlayer) then
        if ... then
            local id = getElementData (ThePlayer, "ID")
            local message = table.concat({...}, " ")
			
			outputToChat ("#64B034"..getPlayerName(ThePlayer).."["..tonumber(id).."]:#FFD700 "..message, ThePlayer,255, 100, 200,true)
			
            for i,v in pairs (getElementsByType("player")) do
                local accName = getAccountName ( getPlayerAccount ( v ) )
                if isReportAllowed ( v ) == true then 
                    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_1_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
                        outputToChat ("#64B034"..getPlayerName(ThePlayer).."["..tonumber(id).."]:#FFD700 "..message, v,255, 100, 200,true)
                    end
				end
            end
        end
    end
end
addEventHandler("onPlayerLogin", getRootElement(), reportPlayer )
addCommandHandler ("report", reportPlayer)

function otvet (ThePlayer, cmd, target, ...)
    local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_1_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" ) ) then 
        local player = getPlayerFromID(tonumber(target))
        if player then
            if ... then
                local id = getElementData (ThePlayer, "ID")
                local ids = getElementData (player, "ID")
                local message = table.concat({...}, " ") 
				
				
                for i,v in pairs (getElementsByType("player")) do
                    if isReportAllowed ( v ) == true then 
                        local accNamev = getAccountName ( getPlayerAccount ( v ) )
                        if isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin_1_lvl" ) ) or isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin_3_lvl" ) ) or isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin_4_lvl" ) ) or isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin_5_lvl" ) ) or isObjectInACLGroup ("user."..accNamev, aclGetGroup ( "Admin_6_lvl" ) ) then 
                            outputToChat("#FE9A2EАдминистратор "..getPlayerName(ThePlayer).."["..tonumber(id).."] #FE9A2Eдля #FE9A2E"..getPlayerName(player).."["..tonumber(ids).."]: #FE9A2E"..message, v,255, 100, 200,true)
                        end 
					end
                end
				outputToChat ("#FE9A2EАдминистратор "..getPlayerName(ThePlayer).."["..tonumber(id).."] #FE9A2Eдля #FE9A2E"..getPlayerName(player).."["..tonumber(ids).."]: #FE9A2E"..message, player,255, 100, 200,true)
            end
        end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), otvet )
addCommandHandler ("ans", otvet)
]]

function global (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
      if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
         if ... then
		 local id = getElementData (ThePlayer, "ID")
		 local message = table.concat({...}, " ") 
           outputToChat ("#9F81F7[ADMIN] "..getPlayerName(ThePlayer).."["..tonumber(id).."]: #9F81F7"..message, root,159, 129, 247,true)
         end
      end
end
addEventHandler("CommmandHandler", getRootElement(), global )
addCommandHandler ("p", global)

function sChat (ThePlayer, cmd, ...) 
    if not isPlayerMuted (ThePlayer) then 
        if ... then 
            local id = getElementData (ThePlayer, "ID") 
            local message = table.concat({...}, " ") 
            for i,v in pairs (getElementsByType("player")) do 
                local x,y,z = getElementPosition(ThePlayer) 
                local xa,ya,za = getElementPosition(v) 
                local accName = getAccountName(getPlayerAccount(ThePlayer)) 
                if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 40 then 
                    if isObjectInACLGroup ("user."..accName,aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Admin_1_lvl")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Admin_2_lvl")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Admin_3_lvl")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Admin_4")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Admin_5_lvl")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Admin_6_lvl")) then
                        if isChatTegVisible ( ThePlayer ) then
						    outputChatBox("#FF8C00"..getPlayerName(ThePlayer).."["..tonumber(id).."] [Крикнул]: #FFFFFF"..message,v,255,255,255,true) 
						else
						    outputChatBox("#FFFFFF"..getPlayerName(ThePlayer).."["..tonumber(id).."] [Крикнул]: "..message,v,255,255,255,true)
						end
                    else 
                        outputChatBox("#FFFFFF"..getPlayerName(ThePlayer).."["..tonumber(id).."] [Крикнул]: "..message,v,255,255,255,true) 
                    end 
                end 
            end 
        end 
    end 
end 
addEventHandler("onPlayerLogin", getRootElement(), sChat ) 
--addCommandHandler ("s", sChat)

function admin (ThePlayer, cmd, ...)
   local accName = getAccountName ( getPlayerAccount ( ThePlayer ) )
      if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_1_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" ) ) then 
         if ... then
		   for i,v in pairs (getElementsByType("player")) do
		   local vName = getAccountName ( getPlayerAccount ( v ) )
	          if isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin_1_lvl" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin_3_lvl" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin_4_lvl" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin_5_lvl" ) ) or isObjectInACLGroup ("user."..vName, aclGetGroup ( "Admin_6_lvl" ) ) then
                       local id = getElementData (ThePlayer, "ID")
		       local message = table.concat({...}, " ") 
               outputToChat ("#FF8C00[ADMIN] "..getPlayerName(ThePlayer).."["..tonumber(id).."]: #FF8C00"..message, v, 255,140,0, true)
              end		   
		   end
         end
      end
end
addEventHandler("onPlayerLogin", getRootElement(), admin )
addCommandHandler ("a", admin)

local chatRadius = 30 -- От скольки метров будет видимость сообщения

function remakeChat (message,messageType)
    cancelEvent()
    if (messageType == 0) then
        local posX, posY, posZ = getElementPosition(source)
        local chatSphere = createColSphere(posX, posY, posZ, chatRadius)
        local nearbyPlayers = getElementsWithinColShape(chatSphere,"player")
        local accName = getAccountName(getPlayerAccount(source)) 
        destroyElement(chatSphere)
        for i,v in ipairs(nearbyPlayers) do
            if isObjectInACLGroup("user."..accName, aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_1_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" )) then 
                 if isChatTegVisible ( source ) then
				    outputChatBox("#FF8C00"..getPlayerName(source).."["..getElementData(source,"ID").."]: #D8D8D8"..message, v, 255, 255, 255, true)
				else
				    outputChatBox("#D8D8D8"..getPlayerName(source).."["..getElementData(source,"ID").."]: #D8D8D8"..message, v, 216, 216, 216, true)
				end
            else
                outputChatBox("#D8D8D8"..getPlayerName(source).."["..getElementData(source,"ID").."]: #D8D8D8"..message, v, 216, 216, 216, true)
            end 
        end
    end    
end
addEventHandler("onPlayerChat", getRootElement(), remakeChat)

function useGlobalChat(message, messageType)
	cancelEvent()
	if (messageType == 1) then
		if not validateChatInput(source, "main", message) then return end
		local occupation = ""
		local r,g,b = defR,defG,defB
		if getPlayerTeam(source) then
	    		r,g,b = getTeamColor(getPlayerTeam(source))
		end
		local px,py,pz = getElementPosition(source)
		local loc = getElementData(source, "Location") or getZoneName(px,py,pz)
		local outText = "#EEEED1"..getPlayerName ( source )..": #ffffff"
		local length = string.len(outText..firstToUpper(message))
		outputToChat(outText..firstToUpper(message), root,255, 100, 0, true)
		end
end
addEventHandler("onPlayerChat", root, useGlobalChat)

function displayChatBubble(message, messagetype, plr)
	if isPlayerMuted(plr) then return end
	if source then
		triggerClientEvent("GTWchat.makeChatBubble", source, message, messagetype, plr)
	else
		triggerClientEvent("GTWchat.makeChatBubble", plr, message, messagetype, plr)
	end
end

function RGBToHex(red, green, blue, alpha)
	if ((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or(alpha and(alpha < 0 or alpha > 255))) then
		return nil
	end
	if (alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function firstToUpper(str)
	if str and str:sub(1,4) ~= "http" and str:sub(1,4) ~= "www." then
    	return str:sub(1,1):upper()..str:sub(2)
    else
    	return str
    end
end


function receiveSettings()
	local settings =
	{
		showtime,
		characteraddition,
		maxbubbles,
		hideown
	}
	triggerClientEvent(source,"GTWchat.returnSettings", root, settings)
end
addEvent("GTWchat.askForSettings",true)
addEventHandler("GTWchat.askForSettings", root, receiveSettings)