function bChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
   local id = getElementData (ThePlayer, "ID")
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 10 then
        outputToChat( "#D8D8D8(( "..getPlayerName(ThePlayer).."["..tonumber(id).."]: #D8D8D8" ..message.. " #D8D8D8))", v,216, 216, 216,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), bChat )
--addCommandHandler ("b", bChat)

function wChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
   local id = getElementData (ThePlayer, "ID")
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 5 then
        outputToChat( "#A4A4A4"..getPlayerName(ThePlayer).."["..tonumber(id).."] шепчет: "..message, v,164, 164, 164,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), wChat )
--addCommandHandler ("w", wChat)


function doChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 10 then
        outputToChat( "#F781F3"..message.." ("..getPlayerName(ThePlayer)..")", v,247, 129, 243,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), doChat )
--addCommandHandler ("do", doChat)

function tryChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
	local fix = math.random(1,2)
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 10 then
		 if fix == 1 then 
           outputToChat( "#F781F3"..getPlayerName(ThePlayer).." #F781F3"..message.." | #FE2E2EНеудачно", v,255, 100, 200,true)
		  elseif fix == 2 then
           outputToChat("#F781F3"..getPlayerName(ThePlayer).." #F781F3"..message.." | #01DF3AУдачно ", v,255, 100, 200,true)
		 end
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), tryChat )
--addCommandHandler ("try", tryChat)

function mChat (ThePlayer, cmd, ...)
if not isPlayerMuted (ThePlayer) then
   if ... then
    local message = table.concat({...}, " ")
     for i,v in pairs (getElementsByType("player")) do
      local x,y,z = getElementPosition(ThePlayer)
      local xa,ya,za = getElementPosition(v)
       if getDistanceBetweenPoints3D(x,y,z,xa,ya,za) < 10 then
        outputToChat( "#F781F3* "..getPlayerName(ThePlayer).." "..message.."", v,247, 129, 243,true)
       end
     end
   end
end
end
addEventHandler("CommmandHandler", getRootElement(), mChat )
--addCommandHandler ("m", mChat)
