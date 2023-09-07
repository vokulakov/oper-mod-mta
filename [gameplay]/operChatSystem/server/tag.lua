local Tags = {
	['Console'] 		= '#00ff00Гениральный директор',
	['Admin']			= '#FF0000Главный администратор',
	['Administrator']	= '#FF0000Администратор',
	['Premium']			= '#ffff00PREMIUM',
	['VIP']				= '#ffff00VIP',
}

function getPlayerTag(player)
	if not isElement(player) then 
		return
	end

	local Account = getPlayerAccount(player)

	if not Account then
		return "[Гость]"
	end

	for group, tag in pairs(Tags) do
		if isObjectInACLGroup("user." .. getAccountName(Account), aclGetGroup(group)) then
			player:setData("player.prefix", { group = group, prefix = tag})
			return '#6495ED[ '..tag..' #6495ED]'
		end
	end

	return "[Игрок]"
end

addEventHandler("onPlayerLogin", root, function()
	getPlayerTag(source)
end)