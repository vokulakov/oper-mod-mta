function kickPlayerCommand (player,command,idPlayerOther,...) 
local accName = getAccountName(getPlayerAccount(player)) 
if isObjectInACLGroup("user."..accName,aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_3_lvl")) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_4_lvl")) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_5_lvl")) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_6_lvl")) then
local playerOther = getPlayerFromID(tonumber(idPlayerOther)) 
if playerOther then 
outputToChat("#FF0000"..getPlayerName(playerOther).." кикнут администратором "..getPlayerName(player)..".",getRootElement(),255,255,255,true) 
kickPlayer(playerOther,player,...) 
end 
end 
end 
addEventHandler("CommmandHandler",getRootElement(),kickPlayerCommand) 
--addCommandHandler("kicked",kickPlayerCommand)