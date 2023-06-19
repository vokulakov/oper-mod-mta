--[[
    TODO:
        * панель с избранными звуками (в будущем будет доступ только по подписке)
        * звук 'По умолчанию' - тот что будет доступен на клавишу 'X'

        ✖

        - Функция "прослушать" - воспроизвести звук только для себя

        -- Если звук уже добавлен в избранное, то кнопку не нужно делать активной 
-- Первым делом сканируем весь список на наличие звуков, которые добавлены в избранное
-- Так же, избранным звукам нужно добавлять "сердечко"

-- нужно сделать отдельный список со звуками, которые бы помечались избранными и по умолчанию
]]

Voice.UI = {}

local sW, sH = guiGetScreenSize()
local W, H = 370, 450 -- размеры окна

local SoundsList = Config.sounds

local currentDefaultSoundRow

Voice.UI['wnd'] = guiCreateWindow(sW/2-W/2, sH/2-H/2, W, H, "Двойной клик для воспроизведения", false)
guiWindowSetSizable(Voice.UI['wnd'], false)
guiSetVisible(Voice.UI['wnd'], false)
guiWindowSetMovable(Voice.UI['wnd'], false)

Voice.UI['wnd_tab'] = guiCreateTabPanel(0, 0.05, 1, 0.85, true, Voice.UI['wnd'])

Voice.UI['sound_tab'] = guiCreateTab("Звуковые фрагменты ♪", Voice.UI['wnd_tab'])
Voice.UI['sound_list'] = guiCreateGridList(0.02, 0.02, 0.96, 0.96,  true, Voice.UI['sound_tab'])
guiGridListSetSortingEnabled(Voice.UI['sound_list'], false)
guiGridListAddColumn(Voice.UI['sound_list'], "Категории звуков", 0.9)

Voice.UI['btn_close'] = guiCreateButton(0, H-40, W/2-65, 30, "Закрыть", false, Voice.UI['wnd'])
guiSetFont(Voice.UI['btn_close'], "default-bold-small")

Voice.UI['btn_set'] = guiCreateButton(W/2-50, H-40, W/2+40, 30, "Установить по умолчанию", false, Voice.UI['wnd'])
guiSetFont(Voice.UI['btn_set'], "default-bold-small")
guiSetProperty(Voice.UI['btn_set'], "NormalTextColour", "FF21b1ff")
guiSetEnabled(Voice.UI['btn_set'], false)

function Voice.UI.initListSound()
    guiGridListClear(Voice.UI['sound_list'])
	guiGridListSetColumnTitle(Voice.UI['sound_list'], 1, 'Категории звуков')

    local row = guiGridListAddRow(Voice.UI['sound_list'])
    guiGridListSetItemText(Voice.UI['sound_list'], row, 1, '', true, false)

    for category, category_list in pairs(Config.sounds) do
		local row = guiGridListAddRow(Voice.UI['sound_list'])

		guiGridListSetItemText(Voice.UI['sound_list'], row, 1, '+ '..category, false, false)
		guiGridListSetItemData(Voice.UI['sound_list'], row, 1, {
            sound_category = category,
            sound_list = category_list
        })
	end

    guiSetEnabled(Voice.UI['btn_set'], false)
end

addEventHandler("onClientGUIClick", Voice.UI['wnd'], function()
    if not guiGetVisible(Voice.UI['wnd']) then
		return
	end 

    if source == Voice.UI['btn_close'] then 
        showCursor(false)
        guiSetVisible(Voice.UI['wnd'], false)
        return 
    end 

    local sel = guiGridListGetSelectedItem(Voice.UI['sound_list'])
    local item = guiGridListGetItemData(Voice.UI['sound_list'], sel, 1) or false

    guiSetEnabled(Voice.UI['btn_set'], false)

    if item and item.src then
        
        if source == Voice.UI['btn_set'] then 
            Config.default_sound = item.src

            if currentDefaultSoundRow then 
                guiGridListSetItemColor(Voice.UI['sound_list'], currentDefaultSoundRow, 1, 255, 255, 255)
            end

            guiGridListSetItemColor(Voice.UI['sound_list'], sel, 1, 33, 177, 255)

            currentDefaultSoundRow = sel

            return 
        end 

        if item.src ~= Config.default_sound then 
            guiSetEnabled(Voice.UI['btn_set'], true)
        end

    end

end)

addEventHandler("onClientGUIDoubleClick", Voice.UI['sound_list'], function()
    if not guiGetVisible(Voice.UI['wnd']) then
		return
	end 

    local sel = guiGridListGetSelectedItem(Voice.UI['sound_list'])
    local item = guiGridListGetItemData(Voice.UI['sound_list'], sel, 1) or false
    
    if not item then
        return
    end

    -- Воспроизвести звук
    if item.src then
        return Voice.playerPlaySound(item.src)
    end 
    
    -- Закрытие категории
    if type(item) == 'string' and item == 'back' then 
        return Voice.UI.initListSound()
    end 

    -- Открытие категории
    if type(item) == 'table' then
        guiGridListClear(Voice.UI['sound_list'])

        local row = guiGridListAddRow(Voice.UI['sound_list'])
    	guiGridListSetItemText(Voice.UI['sound_list'], row, 1, '..', false, false)
   		guiGridListSetItemData(Voice.UI['sound_list'], row, 1, 'back')

        local row = guiGridListAddRow(Voice.UI['sound_list'])
        guiGridListSetItemText(Voice.UI['sound_list'], row, 1, '', true, false)

        guiGridListSetColumnTitle(Voice.UI['sound_list'], 1, 'Список звуков')

        for num, sound in ipairs(item.sound_list) do
            local row = guiGridListAddRow(Voice.UI['sound_list'])

            local item_text = ' '..num..'.  '..sound.name

            if sound.src == Config.default_sound then
                guiGridListSetItemText(Voice.UI['sound_list'], row, 1, item_text, false, false)
                guiGridListSetItemColor(Voice.UI['sound_list'], row, 1, 33, 177, 255)
                currentDefaultSoundRow = row
            else
                guiGridListSetItemText(Voice.UI['sound_list'], row, 1, item_text, false, false)
            end
            

            guiGridListSetItemData(Voice.UI['sound_list'], row, 1, 
                {
                    category = item.sound_category,
                    field = num,
                    name = sound.name,
                    src = sound.src
                }
            )

        end
    end
  
end)

Voice.UI.initListSound()

function setWndVisible(state)
    local PLAYER_UI = localPlayer:getData("player.UI")
    if type(PLAYER_UI) == 'boolean' then return end

    if state == nil then
        return 
    end

    guiSetVisible(Voice.UI['wnd'], state)
    showCursor(state)
end

function isWndVisible()
    return guiGetVisible(Voice.UI['wnd'])
end

local function showUI()
    if getKeyState("LSHIFT") and getKeyState(Config.key) then
        local state = not guiGetVisible(Voice.UI['wnd'])
        setWndVisible(state)
    end
end 
bindKey('LSHIFT', "down", showUI)
bindKey(Config.key, "down", showUI)
