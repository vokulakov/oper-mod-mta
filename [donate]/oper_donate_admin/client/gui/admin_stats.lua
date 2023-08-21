--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_stats.lua
*
*	Original File by lil_Toady
*
**************************************]]

aStatsForm = nil
local aStatsGUI = {}
function aPlayerStats ( player )
	if ( aStatsForm == nil ) then
		local x, y = guiGetScreenSize()
		aStatsForm		= guiCreateWindow ( x / 2 - 230, y / 2 - 200, 460, 400, "Статистика игрока", false )
					   guiCreateHeader ( 0.05, 0.06, 0.20, 0.05, "Оружие:", true, aStatsForm )
		local weapons = { "Пистолет", "Сайлент", "Дигл", "Дробовик", "Савны", "Спаз12", "Узи", "MP5", "AK47", "M4",  "Снайпер" }
		local weapon = 1
		while weapon <= 11 do
			local stat = weapon + 68
			aStatsGUI[stat] = {}
			local label = guiCreateLabel ( 0.05, 0.06 + 0.07 * weapon, 0.20, 0.07, weapons[weapon]..":", true, aStatsForm )
			guiLabelSetHorizontalAlign ( label, "right", false )
			aStatsGUI[stat]["value"] = guiCreateEdit ( 0.26, 0.05 + 0.07 * weapon, 0.11, 0.06, "0", true, aStatsForm )
			guiEditSetMaxLength ( aStatsGUI[stat]["value"], 4 )
			aStatsGUI[stat]["button"] = guiCreateButton ( 0.37, 0.05 + 0.07 * weapon, 0.10, 0.06, "Пост.", true, aStatsForm, "setstat" )
			weapon = weapon + 1
		end
					   guiCreateStaticImage ( 0.50, 0.12, 0.0025, 0.75, "client\\images\\dot.png", true, aStatsForm )
					   guiCreateHeader ( 0.60, 0.06, 0.20, 0.05, "Тело:", true, aStatsForm )
		local bodys = { "Конституция", "Выносливость", "Мышцы", "Здоровье" }
		local body = 1
		while body <= 4 do
			local stat = body + 20
			aStatsGUI[stat] = {}
			local label = guiCreateLabel ( 0.50, 0.06 + 0.07 * body, 0.20, 0.07, bodys[body]..":", true, aStatsForm )
			guiLabelSetHorizontalAlign ( label, "right", false )
			aStatsGUI[stat]["value"] = guiCreateEdit ( 0.71, 0.05 + 0.07 * body, 0.11, 0.06, "0", true, aStatsForm )
			guiEditSetMaxLength ( aStatsGUI[stat]["value"], 4 )
			aStatsGUI[stat]["button"] = guiCreateButton ( 0.82, 0.05 + 0.07 * body, 0.10, 0.06, "Пост.", true, aStatsForm, "setstat" )
			body = body + 1
		end
		local label = guiCreateLabel ( 0.50, 0.61, 0.20, 0.07, "Боевой стиль:", true, aStatsForm )
		guiLabelSetHorizontalAlign ( label, "right", false )
		aStatsGUI[300] = {}
		aStatsGUI[300]["value"] = guiCreateEdit ( 0.71, 0.60, 0.11, 0.06, "4", true, aStatsForm )
		guiEditSetMaxLength ( aStatsGUI[300]["value"], 2 )
		aStatsGUI[300]["button"] = guiCreateButton ( 0.82, 0.60, 0.10, 0.06, "Пост.", true, aStatsForm )
		guiCreateLabel ( 0.51, 0.67, 0.45, 0.07, "Доступные значения: 4-7, 15, 16", true, aStatsForm )

					   guiCreateLabel ( 0.05, 0.93, 0.60, 0.05, "* Допускаются только значения от 0 до 1000", true, aStatsForm )
		aStatsClose		= guiCreateButton ( 0.80, 0.90, 0.14, 0.09, "Закрыть", true, aStatsForm )

		addEventHandler ( "onClientGUIClick", aStatsForm, aClientStatsClick )
		addEventHandler ( "onClientGUIChanged", aStatsForm, aClientStatsChanged )
		addEventHandler ( "onClientGUIAccepted", aStatsForm, aClientStatsAccepted )
		--Register With Admin Form
		aRegister ( "PlayerStats", aStatsForm, aPlayerStats, aPlayerStatsClose )
	end
	aStatsSelect = player
	guiSetVisible ( aStatsForm, true )
	guiBringToFront ( aStatsForm )
end

function aPlayerStatsClose ( destroy )
	if ( ( destroy ) --[[or ( guiCheckBoxGetSelected ( aPerformanceStats ) )]] ) then
		if ( aStatsForm ) then
			removeEventHandler ( "onClientGUIClick", aStatsForm, aClientStatsClick )
			removeEventHandler ( "onClientGUIChanged", aStatsForm, aClientStatsChanged )
			removeEventHandler ( "onClientGUIAccepted", aStatsForm, aClientStatsAccepted )
			destroyElement ( aStatsForm )
			aStatsForm = nil
		end
	else
		guiSetVisible ( aStatsForm, false )
	end
end

function aClientStatsClick ( button )
	if ( button == "left" ) then
		if ( source == aStatsClose ) then
			aPlayerStatsClose ( false )
		else
			for id, element in pairs ( aStatsGUI ) do
				if ( element["button"] == source ) then
					local value = tonumber ( guiGetText ( element["value"] ) )
					if ( ( value ) and ( value >= 0 ) and ( value <= 1000 ) ) then
						triggerServerEvent ( "aPlayer", getLocalPlayer(), aStatsSelect, "setstat", id, value )
					else
						aMessageBox ( "Ошибка", "Значение не из диапазона (0-1000)" )
					end				
				return
				end
			end
		end
	end
end

function aClientStatsChanged ()
	for id, element in pairs ( aStatsGUI ) do
		if ( element["value"] == source ) then
			if ( guiGetText ( source ) ~= "" ) then
				local input = tonumber ( guiGetText ( source ) )
				if ( not input ) then
					guiSetText ( source, string.gsub ( guiGetText ( source ), "[^%d]", "" ) )
				elseif ( input > 1000 ) then
					guiSetText ( source, "1000" )
				elseif ( input < 0 ) then
					guiSetText ( source, "0" )
				end
			end
			return
		end
	end
end

function aClientStatsAccepted ()
	for id, element in pairs ( aStatsGUI ) do
		if ( element["value"] == source ) then
			local value = tonumber ( guiGetText ( element["value"] ) )
			if ( ( value ) and ( value >= 0 ) and ( value <= 1000 ) ) then
				triggerServerEvent ( "aPlayer", getLocalPlayer(), aStatsSelect, "setstat", id, value )
			else
				aMessageBox ( "Ошибка", "Значение не из диапазона (0-1000)" )
			end
			return
		end
	end
end