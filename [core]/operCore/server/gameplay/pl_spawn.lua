local spawnPosition = {
	{x = 957.93640136719, y = 1733.2399902344, z = 9.7171878814697, rot = 270}, 
}

local skins = {67, 105, 113, 222, 223, 235, 28, 136, 37, 122, 127, 210, 262}

local function playerSpawn(player)
 	local num = math.random(1, #spawnPosition)
	local x, y, z, rot = spawnPosition[num].x, spawnPosition[num].y, spawnPosition[num].z, spawnPosition[num].rot
	spawnPlayer(player, x, y, z, rot, skins[math.random(1, #skins)], 0, 0)
	fadeCamera(player, true, 5)
	setCameraTarget(player, player)
end
addEvent("operCore.spawnPlayer", true)
addEventHandler("operCore.spawnPlayer", root, playerSpawn)

addEventHandler("onPlayerWasted", root, function()

	setTimer(
		function(player)
			local num = math.random(1, #spawnPosition)
			local x, y, z, rot = spawnPosition[num].x, spawnPosition[num].y, spawnPosition[num].z, spawnPosition[num].rot                                                                                
			
			spawnPlayer(player, x, y, z, rot, 
				getPedSkin(player), 
				getElementInterior(player), 
				getElementDimension(player)
			)

		end, 
	5000, 1, source)

end)