disallowedWeapons = {}

function loadSettings()
	settings = xmlLoadFile ( "settings.xml" )
	disWeaponsNode = xmlFindChild ( settings, "disallowed_weapons", 0 )
	ill_weaponNodes = xmlNodeGetChildren ( settings )
	for k, node in ipairs ( ill_weaponNodes ) do
		disallowedWeapons[k] = xmlNodeGetAttribute ( node, "id" )
	end
	adminOnly = xmlNodeGetValue ( xmlFindChild ( settings, "admin_only", 0 ) )
end

function checkWeapon ( prevSlot, curSlot )
local weapon = getPedWeapon ( getLocalPlayer(), curSlot )
local weaponName = getWeaponNameFromID ( weapon )
local pName = getPlayerName ( source )
	for index, weaponID in ipairs ( disallowedWeapons ) do
		if tonumber(weapon) == tonumber(weaponID) then
			if getTeamName ( getPlayerTeam ( getLocalPlayer() ) ) == "Admins" then
				if adminOnly == "true" then 
					--let it slide
					outputChatBox ( "Don't abuse it :)", 0, 255, 0 )
					break
				else
	    			illegalWeaponFound ( getLocalPlayer(), weapon )
	    			break
	    		end
	    	else
	    		illegalWeaponFound ( getLocalPlayer(), weapon )
	    		break
	    	end
		else
			toggleControl ( "fire", true )
	    	toggleControl ( "action", true )
	    end
	end
end

function illegalWeaponFound ( player, weapon )
	toggleControl ( "fire", false )
	toggleControl ( "action", false )
	triggerServerEvent ( "onIllegalWeapon", getLocalPlayer(), getWeaponNameFromID(getPedWeapon(getLocalPlayer(), curSlot ) ), getPlayerName(source) )
end

addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), checkWeapon )
addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource() ), loadSettings )