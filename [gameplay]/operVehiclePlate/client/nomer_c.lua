Number = {}

Number.img = {
	{ path = "assets/texture/nomer/nomer_0.png", 	name = "Номерной знак отсутствует", 				example = "", 							isPicture = true, 	isFormat = false },
	{ path = "assets/texture/nomer/nomer_2.png", 	name = "Российский номерной знак", 					example = "Пример: А001АА77", 			isPicture = false, 	isFormat = true, editLength = 9, patterns = { number = "^([ABCEHKMOPTXY]%d%d%d[ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d+)$",	region = {"Russia", "%d%d+$"}, 	null = {"%d%d%d", "000"}  	} },
	{ path = "assets/texture/nomer/nomer_3.png", 	name = "Российский номерной знак (без флага)", 		example = "Пример: А001АА77", 			isPicture = false, 	isFormat = true, editLength = 9, patterns = { number = "^([ABCEHKMOPTXY]%d%d%d[ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d+)$", 	region = {"Russia", "%d%d+$"}, 	null = {"%d%d%d", "000"}  	} },
	{ path = "assets/texture/nomer/nomer_4.png", 	name = "Федеральный номерной знак", 				example = "Пример: А001АА", 			isPicture = false, 	isFormat = true, editLength = 6, patterns = { number = "^([ABCEHKMOPTXY]%d%d%d[ABCEHKMOPTXY][ABCEHKMOPTXY])$", 										 	null = {"%d%d%d", "000"}  	} },
	{ path = "assets/texture/nomer/nomer_5.png", 	name = "Номерной знак органов внутренних дел РФ",	example = "Пример: A0001-77" ,			isPicture = false, 	isFormat = true, editLength = 9, patterns = { number = "^([ABCEHKMOPTXY]%d%d%d%d)([-])(%d%d+)$",						region = {"Russia", "%d%d+$"}, 	null = {"%d%d%d%d", "0000"} } },
	{ path = "assets/texture/nomer/nomer_6.png", 	name = "Транзитный номерной знак", 					example = "Пример: AA001A77", 			isPicture = false, 	isFormat = true, editLength = 9, patterns = { number = "^([ABCEHKMOPTXY][ABCEHKMOPTXY]%d%d%d[ABCEHKMOPTXY])(%d%d+)$", 	region = {"Russia", "%d%d+$"}, 	null = {"%d%d%d", "000"}	} },
	--{ path = "assets/texture/nomer/nomer_7.png", 	name = "Дипломатичесикй номерной знак", 			example = "Пример: 002CD177", 			isPicture = false, 	isFormat = true  },
	--{ path = "assets/texture/nomer/nomer_8.png", 	name = "Номерной знак воинских служб РФ", 			example = "Пример: 3506EK99", 			isPicture = false, 	isFormat = true, editLength = 9, patterns = { number = "^(%d%d%d%d[ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d+)$", 				region = {"Russia", "%d%d+$"}, 	null = {"%d%d%d%d", "0000"}	} },
	--{ path = "assets/texture/nomer/nomer_9.png", 	name = "Номерной знак маршрутного ТС", 				example = "Пример: AO12350", 			isPicture = false, 	isFormat = true, editLength = 9, patterns = { number = "^([ABCEHKMOPTXY][ABCEHKMOPTXY]%d%d%d)(%d%d+)$", 				region = {"Russia", "%d%d+$"}, 	null = {"%d%d%d", "000"} 	} },
	--{ path = "assets/texture/nomer/nomer_10.png", 	name = "Украинский номерной знак", 					example = "Пример: AB1234CE", 			isPicture = false, 	isFormat = true, editLength = 8, patterns = { number = "^([ABCEHKMOPTXY][ABCEHKMOPTXY])(%d%d%d%d)([ABCEHKMOPTXY][ABCEHKMOPTXY])$" }	},
	--{ path = "assets/texture/nomer/nomer_11.png", 	name = "Азербайджанский номерной знак", 			example = "Пример: 10-AB-777", 			isPicture = false, 	isFormat = true,  editLength = 9, patterns = { number = "^(%d%d)([-])([ABEIKMHOPCTX][ABEIKMHOPCTX])([-])(%d%d%d)$" } },
	--{ path = "assets/texture/nomer/nomer_13.png", 	name = "Белорусский номерной знак", 				example = "Пример: 1234AB-5", 			isPicture = false, 	isFormat = true, editLength = 8, patterns = { number = "^(%d%d%d%d)([ABEIKMHOPCTX][ABEIKMHOPCTX][-])(%d)$" } },
	--{ path = "assets/texture/nomer/nomer_12.png", 	name = "Казахстанский номерной знак", 				example = "Пример: 111ААА01", 			isPicture = false, 	isFormat = true,  editLength = 8, patterns = { number = "^(%d%d%d)([ABCDEFGHIKLMNOPQRSTVXYZ][ABCDEFGHIKLMNOPQRSTVXYZ][ABCDEFGHIKLMNOPQRSTVXYZ])(%d%d)$" } },
	-- --
	--{ path = "assets/texture/nomer/nomer_2.png", 	name = "Именной номерной знак", 					example = "Пример: ОПЕРСКИЙ77", 		isPicture = false, 	isFormat = false },
	--{ path = "assets/texture/nomer/nomer_1.png", 	name = "Текстовый номерной знак", 					example = "Пример: ОПЕРСКИЙ ОТДЕЛ", 	isPicture = false, 	isFormat = false },
	-- --
	{ path = "assets/texture/nomer/nomer_14.png", 	name = "Накладка 'Пропускать везде'", 				example = "", 							isPicture = true,  	isFormat = false },
}

Number.region = {
	['Russia'] = { -- Регионы Российской Федерации
		[01] = 'Республика Адыгея',
		[02] = 'Республика Башкортостан', 																						[102] = 'Республика Башкортостан',
		[03] = 'Республика Бурятия', 																							[103] = 'Республика Бурятия',
		[04] = 'Республика Алтай (Горный Алтай)',
		[05] = 'Республика Дагестан',
		[06] = 'Республика Ингушетия',
		[07] = 'Кабардино-Балкарская Республика',
		[08] = 'Республика Калмыкия',
		[09] = 'Республика Карачаево-Черкессия',
		[10] = 'Республика Карелия',
		[11] = 'Республика Коми',
		[12] = 'Республика Марий Эл',
		[13] = 'Республика Мордовия', 																							[113] = 'Республика Мордовия',
		[14] = 'Республика Саха (Якутия)',
		[15] = 'Республика Северная Осетия — Алания',
		[16] = 'Республика Татарстан',																							[116] = 'Республика Татарстан',
		[17] = 'Республика Тыва',
		[18] = 'Удмуртская Республика',
		[19] = 'Республика Хакасия',
		[21] = 'Чувашская Республика',																							[121] = 'Чувашская Республика',
		[22] = 'Алтайский край',
		[23] = 'Краснодарский край',						[93] = 'Краснодарский край', 										[123] = 'Краснодарский край',
		[24] = 'Красноярский край',							[84] = 'Красноярский край', 		[88] = 'Красноярский край', 	[124] = 'Красноярский край',
		[25] = 'Приморский край',																								[125] = 'Приморский край',
		[26] = 'Ставропольский край',		 																					[126] = 'Ставропольский край',
		[27] = 'Хабаровский край',
		[28] = 'Амурская область',
		[29] = 'Архангельская область',
		[30] = 'Астраханская область',
		[31] = 'Белгородская область',
		[32] = 'Брянская область',
		[33] = 'Владимирская область',
		[34] = 'Волгоградская область', 																						[134] = 'Волгоградская область',
		[35] = 'Вологодская область', 
		[36] = 'Воронежская область', 																							[136] = 'Воронежская область',
		[37] = 'Ивановская область',
		[38] = 'Иркутская область', 						[85] = 'Иркутская область', 										[138] = 'Иркутская область',
		[39] = 'Калининградская область', 					[91] = 'Калининградская область',
		[40] = 'Калужская область',
		[41] = 'Камчатский край',
		[42] = 'Кемеровская область', 																							[142] = 'Кемеровская область',
		[43] = 'Кировская область',
		[44] = 'Костромская область',
		[45] = 'Курганская область',
		[46] = 'Курская область',
		[47] = 'Ленинградская область',
		[48] = 'Липецкая область',
		[49] = 'Магаданская область',
		[50] = 'Московская область', 						[90] = 'Московская область', 										[150] = 'Московская область', 							[190] = 'Московская область', 	[750] = 'Московская область',
		[51] = 'Мурманская область',
		[52] = 'Нижегородская область', 																						[152] = 'Нижегородская область',
		[53] = 'Новгородская область',
		[54] = 'Новосибирская область', 																						[154] = 'Новосибирская область',
		[55] = 'Омская область',
		[56] = 'Оренбургская область',
		[57] = 'Орловская область',
		[58] = 'Пензенская область',
		[59] = 'Пермский край', 							[81] = 'Пермский край', 											[159] = 'Пермский край',
		[60] = 'Псковская область',
		[61] = 'Ростовская область', 																							[161] = 'Ростовская область',
		[62] = 'Рязанская область',
		[63] = 'Самарская область', 																							[163] = 'Самарская область',
		[64] = 'Саратовская область', 																							[164] = 'Саратовская область',
		[65] = 'Сахалинская область',
		[66] = 'Свердловская область', 						[96] = 'Свердловская область', 										[196] = 'Свердловская область',
		[67] = 'Смоленская область',
		[68] = 'Тамбовская область',
		[69] = 'Тверская область',
		[70] = 'Томская область',
		[71] = 'Тульская область',
		[72] = 'Тюменская область',
		[73] = 'Ульяновская область', 																							[173] = 'Ульяновская область',
		[74] = 'Челябинская область', 																							[174] = 'Челябинская область',
		[75] = 'Забайкальский край', 						[80] = 'Забайкальский край',
		[76] = 'Ярославская область',
		[77] = 'г. Москва', 								[97] = 'г. Москва', 				[99] = 'г. Москва', 			[177] = 'г. Москва', 									[197] = 'г. Москва', 			[199] = 'г. Москва', 					[777] = 'г. Москва',	[799] = 'г. Москва',
		[78] = 'г. Санкт-Петербург', 						[98] = 'г. Санкт-Петербург', 										[178] = 'г. Санкт-Петербург',
		[79] = 'Еврейская автономная область',
		[82] = 'Республика Крым',
		[83] = 'Ненецкий автономный округ',
		[86] = 'Ханты-Мансийский автономный округ — Югра', 																		[186] = 'Ханты-Мансийский автономный округ — Югра',
		[87] = 'Чукотский автономный округ',
		[89] = 'Ямало-Ненецкий автономный округ',
		[92] = 'г. Севастополь',
		[94] = 'территории, находящиеся за пределами РФ (режимные объекты)',
		[95] = 'Чеченская республика'
	}
}

Number.plateShaders = { }
Number.isPlateOnVehicle = { }

-- ГЕНЕРАЦИЯ ТЕКСТУРЫ --
local numberFont = dxCreateFont("assets/RoadNumbers.ttf", 26.5)

function Number.getRussiaPlateTexture(path, plate_number) -- 2 | 3 | 4


	local renderTarget = dxCreateRenderTarget(256, 64, true)

	local w_1 = string.match(plate_number, "^%a")
	local num = string.match(plate_number, "%d%d%d")
	local w_2 = string.match(plate_number, "%a%a")

	local w = {}

	w[1] = dxGetTextWidth(w_1, 1, numberFont)
	w[2] = dxGetTextWidth(num, 1, numberFont)
	w[3] = dxGetTextWidth(w_2, 1, numberFont)

	local p = {}

	p[1] = w[1] + 8
	p[3] = 188-w[3]-4

	dxSetRenderTarget(renderTarget)
		dxDrawImage(0, -1, 256, 64, dxCreateTexture(path))
		dxDrawText(w_1, p[1]-w[1], 2, p[1], 64, tocolor(0, 0, 0), 1, numberFont, nil, "center")

		--dxDrawRectangle(p[1], 0, 1, 64, tocolor(255, 0, 0))
		dxDrawText(num, p[1], 2, p[3], 64, tocolor(0, 0, 0), 1, numberFont, "center", "center")

		--dxDrawRectangle(p[3], 0, 1, 64, tocolor(255, 0, 0))
		dxDrawText(w_2, p[3], 2, 188, 64, tocolor(0, 0, 0), 1, numberFont, nil, "center")
		if string.match(plate_number, "%d+$") then
			dxDrawText(string.match(plate_number, "%d+$"), 188, -20, 254, 64, tocolor(0, 0, 0), 0.7, numberFont, "center", "center")
		end
	dxSetRenderTarget()

	local texture = dxCreateTexture(dxGetTexturePixels(renderTarget))
	destroyElement(renderTarget)

	return texture
end

function Number.getPolicePlateTexture(path, plate_number) 
	local renderTarget = dxCreateRenderTarget(256, 64, true)

	local w_1 = string.match(plate_number, "^%a")
	local num = string.match(plate_number, "%d%d%d%d")

	local w = {}

	w[1] = dxGetTextWidth(w_1, 1, numberFont)

	local p = {}

	p[1] = w[1] + 18

	dxSetRenderTarget(renderTarget)
		dxDrawImage(0, -1, 256, 64, dxCreateTexture(path))
		dxDrawText(w_1, p[1]-w[1], 2, p[1], 64, tocolor(255, 255, 255), 1, numberFont, nil, "center")

		dxDrawText(num, p[1], 2, 188, 64, tocolor(255, 255, 255), 1, numberFont, "center", "center")
		
		dxDrawText(string.match(plate_number, "(%d%d+)$"), 188, -20, 254, 64, tocolor(255, 255, 255), 0.7, numberFont, "center", "center")
	dxSetRenderTarget()

	local texture = dxCreateTexture(dxGetTexturePixels(renderTarget))
	destroyElement(renderTarget)

	return texture
end

function Number.getTranzitPlateTexture(path, plate_number)
	local renderTarget = dxCreateRenderTarget(256, 64, true)

	local w_1 = string.match(plate_number, "^%a%a")
	local num = string.match(plate_number, "%d%d%d")
	local w_2 = string.sub(plate_number, 6, 6)

	local w = {}

	w[1] = dxGetTextWidth(w_1, 1, numberFont)
	w[2] = dxGetTextWidth(num, 1, numberFont)
	w[3] = dxGetTextWidth(w_2, 1, numberFont)

	local p = {}

	p[1] = w[1] + 8
	p[3] = 188-w[3]-4

	dxSetRenderTarget(renderTarget)
		dxDrawImage(0, -1, 256, 64, dxCreateTexture(path))
		dxDrawText(w_1, p[1]-w[1], 2, p[1], 64, tocolor(0, 0, 0), 1, numberFont, nil, "center")

		--dxDrawRectangle(p[1], 0, 1, 64, tocolor(255, 0, 0))
		dxDrawText(num, p[1], 2, p[3], 64, tocolor(0, 0, 0), 1, numberFont, "center", "center")

		--dxDrawRectangle(p[3], 0, 1, 64, tocolor(255, 0, 0))
		dxDrawText(w_2, p[3], 2, 188, 64, tocolor(0, 0, 0), 1, numberFont, nil, "center")
		
		dxDrawText(string.match(plate_number, "(%d%d+)$"), 188, -20, 254, 64, tocolor(0, 0, 0), 0.7, numberFont, "center", "center")
	dxSetRenderTarget()

	local texture = dxCreateTexture(dxGetTexturePixels(renderTarget))
	destroyElement(renderTarget)

	return texture
end

function Number.getPictureTexture(path) -- текстура накладки на номерной знак
	local renderTarget = dxCreateRenderTarget(256, 64, true)

	dxSetRenderTarget(renderTarget)
		dxDrawImage(0, 0, 256, 64, dxCreateTexture(path))
	dxSetRenderTarget()

	local texture = dxCreateTexture(dxGetTexturePixels(renderTarget))
	destroyElement(renderTarget)

	return texture
end

------------------------

function Number.setVehicleNumberPlate(vehicle)
	if not isElement(vehicle) then return end

	local isPlate = vehicle:getData('vehicle.isPlate')

	if not isPlate then
		return
	end

	--outputDebugString(isPlate.plate_id..' | '..isPlate.plate_text)

	local texture = false

	if Number.img[isPlate.plate_id].isPicture then -- накладка
		texture = Number.getPictureTexture(Number.img[isPlate.plate_id].path)
	elseif isPlate.plate_id == 2 or isPlate.plate_id == 3 or isPlate.plate_id == 4 then
		texture = Number.getRussiaPlateTexture(Number.img[isPlate.plate_id].path, isPlate.plate_text)
	elseif isPlate.plate_id == 5 then
		texture = Number.getPolicePlateTexture(Number.img[isPlate.plate_id].path, isPlate.plate_text) 
	elseif isPlate.plate_id == 6 then
		texture = Number.getTranzitPlateTexture(Number.img[isPlate.plate_id].path, isPlate.plate_text) 
	end

	if texture == false then
		return
	end

	if not Number.plateShaders[vehicle] then
		Number.plateShaders[vehicle] = dxCreateShader("assets/texreplace.fx")
	end

	engineApplyShaderToWorldTexture(Number.plateShaders[vehicle], "nomer", vehicle)
	dxSetShaderValue(Number.plateShaders[vehicle], "gTexture", texture)

	if Number.img[isPlate.plate_id].isPicture then
		Number.isPlateOnVehicle[vehicle] = nil

		return
	end
		
	Number.isPlateOnVehicle[vehicle] = {plate_id = isPlate.plate_id, plate_text = isPlate.plate_text}
end

function Number.destroyVehicleNumberPlate(vehicle)
	if not isElement(vehicle) then return end
	if not Number.plateShaders[vehicle] then return end

	engineRemoveShaderFromWorldTexture(Number.plateShaders[vehicle], "nomer", vehicle)
	destroyElement(Number.plateShaders[vehicle])

	Number.plateShaders[vehicle] = nil
end

function Number.getPlateFromVehicles(plate_id, plate_text)
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		local isPlate = Number.isPlateOnVehicle[vehicle]
		if isPlate then
			if isPlate.plate_id == plate_id and isPlate.plate_text == plate_text then
				return false
			end
		end
	end

	return true
end

function Number.applyVehicleNumberPlate(vehicle, plate_id, plate_text)
	if not isElement(vehicle) then 
		return false
	end

	local plateData = Number.img[plate_id]

	if plateData == nil	then 
		return false 
	end

	-- Проверка на синтаксис
	if plateData.patterns then
		if string.find(plate_text, plateData.patterns.number) then

			if plateData.patterns.region then
				local reg = tonumber(string.match(plate_text, plateData.patterns.region[2]))
				if not Number.region[plateData.patterns.region[1]][reg] then
					-- Такого региона не существует
					--outputDebugString(reg)
					triggerEvent('operNotification.addNotification', localPlayer, "Регион "..reg.." не существует!", 2, true)
					--outputDebugString('Такого региона не существует')
					return false
				end
				--outputDebugString(Number.region[plateData.patterns.region[1]][reg])
			end

			if plateData.patterns.null then
				if tonumber(string.match(plate_text, plateData.patterns.null[1])) == tonumber(plateData.patterns.null[2]) then
					-- Недопустимый формат номера
					triggerEvent('operNotification.addNotification', localPlayer, "Недопустимый формат\nрегистрационного номера", 2, true)
					--outputDebugString('Недопустимый формат номера')
					return false
				end
			end

		else
			-- Проверьте правильность ввода
			triggerEvent('operNotification.addNotification', localPlayer, "Проверьте правильность ввода\nрегистрационного номера", 2, true)
			--outputDebugString('Проверьте правильность ввода')
			return false
		end
	end

	if not Number.getPlateFromVehicles(plate_id, plate_text) then
		triggerEvent('operNotification.addNotification', localPlayer, "К сожалению номерной знак\nзарегистрирован на другое\nтранспортное средство", 2, true)
		--outputDebugString('К сожалению номерной знак уже используется')
		return false
	end

	local isPlate = {plate_id = plate_id, plate_text = plate_text}
	vehicle:setData('vehicle.isPlate', isPlate)

	return true
end

-- Exports
applyVehicleNumberPlate = Number.applyVehicleNumberPlate