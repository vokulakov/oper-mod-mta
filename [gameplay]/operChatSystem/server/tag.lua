local Tags = {
	['Console'] = '#FF0000Главный администратор',
	['Admin']	= '#FF0000Администратор'
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
			local prefix = tag:gsub("#%x%x%x%x%x%x", "")
			player:setData("player.prefix", { group = group, prefix = tostring(prefix)})
			return '#6495ED[ '..tag..' #6495ED]'
		end
	end

	return "[Игрок]"
end

addEventHandler("onPlayerLogin", root, function()
	getPlayerTag(source)
end)