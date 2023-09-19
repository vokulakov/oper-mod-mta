VehicleShop = {}

ShopMarkersTable = {}	

function VehicleShop.create()
    for i, current_shop in pairs(Config.carshop) do

        local marker = createMarker(
            current_shop.enter_pos.x, 
            current_shop.enter_pos.y, 
            current_shop.enter_pos.z, 
            "cylinder", 
            1.5, 
            38, 
            122, 
            20
        )

        ShopMarkersTable[marker] = true

    end
end

addEventHandler("onClientMarkerHit", resourceRoot, function(player)
	if getElementType(player) ~= "player" or player ~= localPlayer or isPedInVehicle(player) or not ShopMarkersTable[source] then 
        return 
    end

    local verticalDistance = localPlayer.position.z - source.position.z
    if verticalDistance > 5 or verticalDistance < -1 then
        return
    end

end)