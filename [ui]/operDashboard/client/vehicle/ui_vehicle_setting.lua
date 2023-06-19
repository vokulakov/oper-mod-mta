Vehicle.Window_setting = {}

Vehicle.Window_setting.isVisible = false

Vehicle.Window_setting.wnd = guiCreateWindow(sWidth-257-15, sHeight/2-405/2-40, 257, 405, "Прочие настройки", false)
guiWindowSetSizable(Vehicle.Window_setting.wnd, false)
guiSetVisible(Vehicle.Window_setting.wnd, false)
guiWindowSetMovable(Vehicle.Window_setting.wnd, false)

Vehicle.Window_setting.lbl = GuiLabel(0, 35, 257, 25, "Настройка вида от первого лица", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(33, 177, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")

Vehicle.Window_setting.lbl = GuiLabel(0, 55, 257, 25, "Положение камеры по оси - Z", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(255, 255, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")
Vehicle.Window_setting.lbl:setVerticalAlign("center")
Vehicle.Window_setting.CAMERA_FPZ = GuiScrollBar(0, 80, 257, 15, true, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.CAMERA_FPZ:setScrollPosition(50)
Vehicle.Window_setting.CAMERA_FPZ:setData('operSounds.UI', 'ui_select')

Vehicle.Window_setting.lbl = GuiLabel(0, 95, 257, 25, "Положение камеры по оси - Y", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(255, 255, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")
Vehicle.Window_setting.lbl:setVerticalAlign("center")
Vehicle.Window_setting.CAMERA_FPY = GuiScrollBar(0, 120, 257, 15, true, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.CAMERA_FPY:setScrollPosition(50)
Vehicle.Window_setting.CAMERA_FPY:setData('operSounds.UI', 'ui_select')

Vehicle.Window_setting.lbl = GuiLabel(0, 135, 257, 25, "Положение камеры по оси - X", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(255, 255, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")
Vehicle.Window_setting.lbl:setVerticalAlign("center")
Vehicle.Window_setting.CAMERA_FPX = GuiScrollBar(0, 160, 257, 15, true, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.CAMERA_FPX:setScrollPosition(50)
Vehicle.Window_setting.CAMERA_FPX:setData('operSounds.UI', 'ui_select')

Vehicle.Window_setting.lbl = GuiLabel(0, 175, 257, 25, "Вращение камеры при повороте", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(255, 255, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")
Vehicle.Window_setting.lbl:setVerticalAlign("center")
Vehicle.Window_setting.CAMERA_FPR = GuiScrollBar(0, 200, 257, 15, true, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.CAMERA_FPR:setScrollPosition(50)
Vehicle.Window_setting.CAMERA_FPR:setData('operSounds.UI', 'ui_select')
-- --

Vehicle.Window_setting.lbl = GuiLabel(0, 230, 257, 25, "Настройка дрифт режима", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(33, 177, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")


Vehicle.Window_setting.lbl = GuiLabel(0, 255, 232, 25, "Подруливание:", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.lbl:setFont("default-bold-small")
Vehicle.Window_setting.lbl:setColor(255, 255, 255)
Vehicle.Window_setting.lbl:setHorizontalAlign("center")

Vehicle.Window_setting.STEERING_ASSIST_POSITION = GuiLabel(165, 255, 35, 25, "10%", false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.STEERING_ASSIST_POSITION:setFont("default-bold-small")
Vehicle.Window_setting.STEERING_ASSIST_POSITION:setColor(33, 177, 255)
Vehicle.Window_setting.STEERING_ASSIST_POSITION:setHorizontalAlign("center")

Vehicle.Window_setting.STEERING_ASSIST_SCROLL = GuiScrollBar(0, 275, 257, 15, true, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.STEERING_ASSIST_SCROLL:setScrollPosition(10)
Vehicle.Window_setting.STEERING_ASSIST_SCROLL:setData('operSounds.UI', 'ui_select')

Vehicle.Window_setting.DRIFT_POINTS = GuiCheckBox(0, 300, 200, 20, " Отображать счетчик", false, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.DRIFT_POINTS:setFont("default-bold-small")
Vehicle.Window_setting.DRIFT_POINTS:setData('operSounds.UI', 'ui_change')

Vehicle.Window_setting.DRIFT_VIEW = GuiCheckBox(0, 320, 200, 20, " Камера 'дрифт-режим'", false, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.DRIFT_VIEW:setFont("default-bold-small")
Vehicle.Window_setting.DRIFT_VIEW:setData('operSounds.UI', 'ui_change')

Vehicle.Window_setting.DRIFT_SMOKE = GuiCheckBox(0, 340, 200, 20, " Густой дым от покрышек", false, false, Vehicle.Window_setting.wnd)
Vehicle.Window_setting.DRIFT_SMOKE:setFont("default-bold-small")
Vehicle.Window_setting.DRIFT_SMOKE:setData('operSounds.UI', 'ui_change')

Vehicle.Window_setting.btn_exit = guiCreateButton(0, 370, 257, 25, "Закрыть", false, Vehicle.Window_setting.wnd)
guiSetFont(Vehicle.Window_setting.btn_exit, "default-bold-small")
guiSetProperty(Vehicle.Window_setting.btn_exit, "NormalTextColour", "fff01a21")
Vehicle.Window_setting.btn_exit:setData('operSounds.UI', 'ui_back')

addEventHandler("onClientGUIClick", root, function()
	if not Vehicle.Window_setting.wnd.visible then
		return
	end

	if source == Vehicle.Window_setting.DRIFT_VIEW then
		triggerEvent('operCameraViews.changeDriftCamera', localPlayer, guiCheckBoxGetSelected(source))
	elseif source == Vehicle.Window_setting.DRIFT_SMOKE then
		
		local VehiclesProperty = localPlayer.vehicle:getData('vehicle.isProperty')
		VehiclesProperty.driftsmoke = guiCheckBoxGetSelected(source)
		localPlayer.vehicle:setData('vehicle.isProperty', VehiclesProperty)

	elseif source == Vehicle.Window_setting.DRIFT_POINTS then
		triggerEvent('operDriftPoint.setVisible', localPlayer, guiCheckBoxGetSelected(source))
	end
end)

addEventHandler("onClientGUIScroll", root, function()
	if not localPlayer.vehicle then
		return
	end
	if source == Vehicle.Window_setting.STEERING_ASSIST_SCROLL then
		local position = source:getScrollPosition()
		Vehicle.Window_setting.STEERING_ASSIST_POSITION:setText(position..'%')
	elseif source == Vehicle.Window_setting.CAMERA_FPZ or source == Vehicle.Window_setting.CAMERA_FPY or source == Vehicle.Window_setting.CAMERA_FPX or source == Vehicle.Window_setting.CAMERA_FPR then
		triggerEvent(
			'operCameraViews.onClientGUIScroll', 
			localPlayer, 
			Vehicle.Window_setting.CAMERA_FPX:getScrollPosition(),
			Vehicle.Window_setting.CAMERA_FPY:getScrollPosition(),
			Vehicle.Window_setting.CAMERA_FPZ:getScrollPosition(),
			Vehicle.Window_setting.CAMERA_FPR:getScrollPosition()
		)
	end

end)

-- Подруливание
addEventHandler("onClientRender", root, function()
	if localPlayer.vehicle then
		local Angle, AngleDir = getDriftAngle(localPlayer.vehicle)
		local AngleMul = Vehicle.Window_setting.STEERING_ASSIST_SCROLL:getScrollPosition()
		if Angle >= 45 then
			Angle = 45
		end
		if Angle > 10 then
			setAnalogControlState('vehicle_left', Angle * AngleMul / 3200)
			toggleControl("vehicle_right", true)
			toggleControl("vehicle_left", true)
			if getKeyState("d") then
				setAnalogControlState('vehicle_left', 0)
			end
		end
		if Angle < 10 then
			setAnalogControlState('vehicle_right', - Angle * AngleMul / 3200)
			toggleControl("vehicle_right", true)
			toggleControl("vehicle_left", true)
			if getKeyState("a") then
				setAnalogControlState('vehicle_right', 0)
			end
		end
	end
end)

function getDriftAngle(vehicle)
	if vehicle.velocity.length < 0.12 then
		return 0
	end

	local direction = vehicle.matrix.forward
	local velocity = vehicle.velocity.normalized

	local dot = direction.x * velocity.x + direction.y * velocity.y
	local det = direction.x * velocity.y - direction.y * velocity.x

	local angle = math.deg(math.atan2(det, dot))
	if math.abs(angle) > 160 then
		return 0
	end
	if angle < 0 then
		dir = "left"
	elseif angle > 0 then
		dir = "right"
	end
	return angle, dir
end