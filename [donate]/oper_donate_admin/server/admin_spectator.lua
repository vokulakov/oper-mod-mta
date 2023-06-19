function spectatePlayerCommand (player,command,idPlayerOther)
	local accName = getAccountName(getPlayerAccount(player)) 
	if isObjectInACLGroup ("user."..accName,aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Console" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_1_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_2_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_3_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_4_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_5_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_6_lvl" )) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin_7_lvl" )) then	
		local playerOther = getPlayerFromID(tonumber(idPlayerOther)) 
		if playerOther then
			triggerClientEvent(player, "aSpectate", player, playerOther)
		end	
	end
end
addEventHandler("CommmandHandler", getRootElement(), spectatePlayerCommand) 
--addCommandHandler("sp", spectatePlayerCommand)