function tpToPlayerCommand (player,command,idPlayerOther)
	local accName = getAccountName(getPlayerAccount(player)) 
	if isObjectInACLGroup ("user."..accName,aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" )) then	
		local playerOther = getPlayerFromID(tonumber(idPlayerOther)) 
		if playerOther then
			triggerEvent("aPlayer", player, playerOther, "warp")
		end	
	end
end
addEventHandler("CommmandHandler", getRootElement(), tpToPlayerCommand) 
--addCommandHandler("tp", tpToPlayerCommand)

function tpToYouPlayerCommand (player, command, idPlayerOther) 
 local accName = getAccountName(getPlayerAccount(player)) 
 if isObjectInACLGroup ("user."..accName, aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_3_lvl")) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_4_lvl")) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_5_lvl")) or isObjectInACLGroup ("user."..accName, aclGetGroup("Admin_6_lvl")) then
  local playerOther = getPlayerFromID(tonumber(idPlayerOther)) 
  if playerOther then 
   triggerEvent("aPlayer", player, playerOther, "warpto", player, playerOther) 
  end  
 end 
end 
addEventHandler("CommmandHandler", getRootElement(), tpToYouPlayerCommand) 
--addCommandHandler("gethere", tpToYouPlayerCommand)