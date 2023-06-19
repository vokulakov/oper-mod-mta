local lightAlpha = 125

function flashLightMode1(vehicle, dataFSO)
	if not isVehicleFSO[vehicle] then
		return
	end

	if dataFSO['Acces1'] and dataFSO['Acces1'].visible then
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
		setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
	
		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0)
			end, 50, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha)
			end, 100, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0)
			end, 150, 1)

		-- --
		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha)
			end, 200, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0)
			end, 250, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha)
			end, 300, 1)
		
		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0)
			end, 350, 1)

	end

	if dataFSO['Acces2'] and dataFSO['Acces2'].visible then
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)
		setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0)
			end, 50, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha)
			end, 100, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0)
			end, 150, 1)

		-- --
		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha)
			end, 200, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0)
			end, 250, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha)
			end, 300, 1)
		
		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0)
			end, 350, 1)
	end

	isVehicleFSO[vehicle].isTimer = setTimer(flashLightMode1, 650, 1, vehicle, dataFSO)
end

function flashLightMode2(vehicle, dataFSO)
	if not isVehicleFSO[vehicle] then
		return
	end

	if dataFSO['Acces1'].visible and dataFSO['Acces2'].visible then

		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

		setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 
		setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha) 

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0)
			end, 50, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha)
			end, 100, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0)
			end, 150, 1)
		-- -- 

		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)

		setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
		setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0)
			end, 50, 1)
	

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha)
			end, 100, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0)
			end, 150, 1)
	end

	isVehicleFSO[vehicle].isTimer = setTimer(flashLightMode2, 650, 1, vehicle, dataFSO)
end

function flashLightMode3(vehicle, dataFSO)
	if not isVehicleFSO[vehicle] then
		return
	end

	if dataFSO['Acces1'].visible and dataFSO['Acces2'].visible then

		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

		setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 
		setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha) 

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0) 
			end, 50, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha) 
			end, 100, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0) 
			end, 150, 1)
		-- -- 

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha) 
			end, 250, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0) 
			end, 300, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha) 
			end, 350, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0) 
			end, 400, 1)

	end

	isVehicleFSO[vehicle].isTimer = setTimer(flashLightMode3, 650, 1, vehicle, dataFSO)
end

function flashLightMode4(vehicle, dataFSO)
	if not isVehicleFSO[vehicle] then
		return
	end

	if dataFSO['Acces1'].visible and dataFSO['Acces2'].visible then
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
		engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

		setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha) 
		setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0) 
			end, 50, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, lightAlpha) 
			end, 100, 1)


		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[1], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[2], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightL, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightR, 255, 255, 255, 0) 
			end, 150, 1)

		-- --
		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)

				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha) 
			end, 250, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0) 
			end, 300, 1)

		setTimer(
			function()
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				engineApplyShaderToWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, lightAlpha) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, lightAlpha) 
			end, 350, 1)

		setTimer(
			function()
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces1'].texture[2], vehicle)
				engineRemoveShaderFromWorldTexture(dxShader, dataFSO['Acces2'].texture[1], vehicle)


				setMarkerColor(isVehicleFSO[vehicle]['Acces1'].lightR, 255, 255, 255, 0) 
				setMarkerColor(isVehicleFSO[vehicle]['Acces2'].lightL, 255, 255, 255, 0) 
			end, 400, 1)
	end

	isVehicleFSO[vehicle].isTimer = setTimer(flashLightMode4, 700, 1, vehicle, dataFSO)
end
