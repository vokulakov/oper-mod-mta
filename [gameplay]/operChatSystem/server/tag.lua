local Tags = {
	['Everyone'] = '#6495ED[ #FF0000ОПЕР #6495ED]',
	['Console'] = '#6495ED[ #FF0000Главный администратор #6495ED]',
	['Admin']	= '#6495ED[ #FF0000Администратор #6495ED]'
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
			local r, g, b = getPlayerNametagColor(player)
			return tag
		end
	end

	return "[Игрок]"
end