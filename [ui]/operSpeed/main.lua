local screenW, screenH = guiGetScreenSize()

local px = 0.8
local sW, sH = 350*px, 350*px
local posX, posY = screenW-sW, screenH-sH

local GEAR_FONT = dxCreateFont("assets/AEROMATICS_BOLD.ttf", 12)
local SPEED_FONT = dxCreateFont("assets/AEROMATICS_ITALIC.ttf", 30)
local SPEED_CRUISE_FONT = dxCreateFont("assets/AEROMATICS_ITALIC.ttf", 7.5)
local SPEED_UNIT_FONT = dxCreateFont("assets/AEROMATICS_ITALIC.ttf", 12)

local FUEL_FONT = dxCreateFont("assets/AEROMATICS_ITALIC.ttf", 15)
local FUEL_TEXT_FONT = dxCreateFont("assets/AEROMATICS_ITALIC.ttf", 8)

local alpha = 255
local side = true
local pulsing = true

local activeEvent 

local function drawSpeedometr()
	local PLAYER_UI = getElementData(localPlayer, "player.UI")

	if type(PLAYER_UI) == 'boolean' then
		return
	end
	
	if not PLAYER_UI['speed'] then return end

	--if localPlayer:getData('operCamHack:isVisible') then
		--return
	--end

	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end

	local speedx, speedy, speedz = getElementVelocity(veh)
	local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	local kmh = math.floor(actualspeed * 1.61 * 100)
	local rotation = math.lerp(-152,90,kmh/300)
	if rotation >= 90 then rotation = math.random(88,92) end
	
	dxDrawImage(screenW-(700), screenH-(633), 769, 633, "assets/bg_shadow.png", 90, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(posX, posY, sW, sH, "assets/speedo.png")
	dxDrawImage(posX, posY, sW, sH, "assets/strelkaspedo.png", rotation)

	-- FUEL --
	--[[
	local cfuel = math.ceil(getElementData(veh, 'exv_fuelSystem.fuel') or 0)
	local mfuel = getElementData(veh, 'exv_fuelSystem.fuelMax') or 50
	local fuellevel = cfuel/mfuel*15
	if fuellevel >= 100 then fuellevel = 100 end

	local rotation_f = math.lerp(-150, 90, cfuel/mfuel)
	if rotation_f <= -125 then pulsing = true else pulsing = false end

	if pulsing then
		if side then alpha = alpha + 5 else alpha = alpha -5 end
		if alpha <= 0 then side = true elseif alpha >= 255 then side = false end
		dxDrawImage(posX-200*px, posY+100*px, sW, sH, "assets/fuel2.png", 0, 0, 0, tocolor(200, 0, 0, alpha))
	end

	dxDrawImage(posX-200*px, posY+100*px, sW, sH, "assets/fuel.png")
	dxDrawImage(posX-200*px, posY+100*px, sW, sH, "assets/strelkabenz.png", rotation_f)

	dxDrawText(cfuel, posX, posY+310*px, posX-50*px, posY+245*px, tocolor(255, 255, 255, 240), 1, FUEL_FONT, "center", "center")
	dxDrawText('из '..mfuel, posX, posY+310*px, posX+10*px, posY+290*px, tocolor(255, 255, 255, 150), 1, FUEL_TEXT_FONT, "center", "center")
	]]
	----------

	-- INDICATORS --
	if getVehicleEngineState(veh) then
		dxDrawImage(posX-100*px, posY-140*px, 512*px, 512*px, "assets/engine.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(posX-100*px, posY-140*px, 512*px, 512*px, "assets/engine.png", 0, 0, 0, tocolor(255, 255, 255, 100))
	end

	if getVehicleOverrideLights(veh) == 2 then
			dxDrawImage(posX-60*px, posY-140*px, 512*px, 512*px, "assets/light.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	elseif getVehicleOverrideLights(veh) == 1 then
			dxDrawImage(posX-60*px, posY-140*px, 512*px, 512*px,"assets/light.png", 0, 0, 0, tocolor(255, 255, 255, 100))
	else
		local h, m = getTime()
		if h >= 7 and h <= 21 then
			dxDrawImage(posX-60*px, posY-140*px, 512*px, 512*px, "assets/light.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		else
			dxDrawImage(posX-60*px, posY-140*px, 512*px, 512*px, "assets/light.png", 0, 0, 0, tocolor(255, 255, 255, 100))
		end
	end

	if isVehicleLocked(veh) then
		dxDrawImage(posX-20*px, posY-120*px, 512*px, 512*px, "assets/lock.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	else
		dxDrawImage(posX-20*px, posY-120*px, 512*px, 512*px, "assets/lock.png", 0, 0, 0, tocolor(255, 255, 255, 100))
	end

	if getElementData(veh, 'vehicle.cruiseSpeedEnabled') then
		dxDrawImage(posX-140*px, posY-120*px, 512*px, 512*px, "assets/cruise.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawText(kmh, posX-118*px, posY-45*px, posX+sW, posY+sH, tocolor(255, 255, 255, 240), 1, SPEED_CRUISE_FONT, "center", "center")
	else
		dxDrawImage(posX-140*px, posY-120*px, 512*px, 512*px, "assets/cruise.png", 0, 0, 0, tocolor(255, 255, 255, 100))
	end
	----------------

	dxDrawText(getVehicleGear(veh, kmh), posX, posY+3, posX+sW, posY+sH, tocolor(255, 255, 255, 200), 1, GEAR_FONT, "center", "center")
	dxDrawText(kmh, posX+60*px, posY+250*px, posX+sW, posY+250*px, tocolor(255, 255, 255, 240), 1, SPEED_FONT, "center", "center")
	dxDrawText('км/ч', posX+60*px, posY+330*px, posX+sW, posY+250*px, tocolor(255, 255, 255, 150), 1, SPEED_UNIT_FONT, "center", "center")

end

local vehicles = { 
	[462] = true
}

addEventHandler("onClientVehicleEnter", root, function (thePlayer, seat)
	if thePlayer == localPlayer and seat == 0 and not vehicles[getElementModel(source)] then
		if activeEvent then
			removeEventHandler("onClientRender", root, drawSpeedometr)
			activeEvent = nil
		end
		activeEvent = addEventHandler("onClientRender", root, drawSpeedometr)
	end
end)

addEventHandler("onClientVehicleStartExit", root, function(thePlayer, seat)
    if thePlayer == localPlayer and seat == 0 and activeEvent then
        removeEventHandler("onClientRender", root, drawSpeedometr)
    end
end)

addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if getElementType(source) == "vehicle" and getPedOccupiedVehicle(localPlayer) == source and activeEvent then
		removeEventHandler("onClientRender", root, drawSpeedometr)
	end
end)

addEventHandler("onClientPlayerWasted", getLocalPlayer(), function()
	if not getPedOccupiedVehicle(source) or not activeEvent then return end
	removeEventHandler("onClientRender", root, drawSpeedometr)
end)

-- UTILS --
function getVehicleGear(veh, kmh)
	local gear = getVehicleCurrentGear(veh)
	if gear == 0 then
		if kmh <= 1 then
			gear = "N"
		else
			gear = "R"
		end 
	elseif gear == 1 then
		if kmh <= 2 then
			gear = "N"
		end
	end

	return gear
end

function math.lerp(a, b, k)
	local result = a * (1-k) + b * k
	if result >= b then
		result = b
	elseif result <= a then
		result = a
	end
	return result
end
