Screen = {}
Screen.Widht, Screen.Height = guiGetScreenSize()

local font = "default-bold"

Edits = {}

SelectedEdit = false

function dxDrawEdit(key, startX, startY, width, height, text, isActive)
	dxDrawRectangle(startX - 1, startY, 1, height, tocolor(0, 0, 0, 180), true) --left
	dxDrawRectangle(startX + width, startY, 1, height, tocolor(0, 0, 0, 180), true) --right
	dxDrawRectangle(startX - 1, startY - 1, width + 2, 1, tocolor(0, 0, 0, 180), true) --top
	dxDrawRectangle(startX - 1, startY + height, width + 2, 1, tocolor(0, 0, 0, 180), true) --bottom
	dxDrawRectangle(startX, startY, width, height, tocolor(40, 40, 40, 200), true)
	if isActive and isCursorShowing() then

	end
	if text == "" and getTickCount() - countL < 500 and isCursorShowing() then
		text = text .. "|"
	end
	dxDrawText(text, startX + 18, startY, startX + width, startY + height, tocolor(255, 255, 255), 1, font, "left", "center", false, false, true)
end

setTimer(function()
	countL = getTickCount()
end, 1000, 0)

function createEdit(Name, posX, posY, sizeX, sizeY, text)
	if not Edits[Name] then
		Edits[Name] = {}
		Edits[Name].Name = Name

		Edits[Name].PosX, Edits[Name].PosY = posX, posY
		Edits[Name].SizeX, Edits[Name].SizeY = sizeX, sizeY

		Edits[Name].Visible = true
		Edits[Name].Text = text
	end
end

function removeEdit(Name)
	if Edits[Name] then
		Edits[Name] = {}
		Edits[Name] = nil
	end
end

function getEditText(Name)
	return Edits[Name].Text or ""
end

function setEditText(Name, text)
	if Edits[Name] then
		Edits[Name].Text = text
	end
end

function setEditVisible(Name, state)
	if Edits[Name] then
		Edits[Name].Visible = state
	end
end

function getEditVisible(Name)
	return Edits[Name].Visible or false
end

addEventHandler("onClientRender", root, function()
	for key, value in pairs(Edits) do
		if value.Visible then
			dxDrawEdit(key, value.PosX, value.PosY, value.SizeX, value.SizeY, value.Text, SelectedEdit == value)
		end
	end
end)

local availableKeys = "1234567890"

local transferKeys = {
	["num_1"] = {"1"},
	["num_2"] = {"2"},
	["num_3"] = {"3"},
	["num_4"] = {"4"},
	["num_5"] = {"5"},
	["num_6"] = {"6"},
	["num_7"] = {"7"},
	["num_8"] = {"8"},
	["num_9"] = {"9"},
	["num_0"] = {"0"}
}

addEventHandler("onClientKey", root, function(button, pressed)
	if pressed and button == "mouse1" then
		for key, value in pairs(Edits) do

			if cursorPosition(value.PosX, value.PosY, value.SizeX, value.SizeY) then
				SelectedEdit = value
				SelectedEdit.Text = ""
				return
			end
		end
		SelectedEdit = false
	elseif pressed then
		if SelectedEdit and SelectedEdit.Visible and isCursorShowing() then
			if button == "backspace" then
				if SelectedEdit.Name == "hours" or SelectedEdit.Name == "minutes" then
					SelectedEdit.Text = SelectedEdit.Text:sub(1, -2)
				end
			end
			if SelectedEdit.Name == "hours" or SelectedEdit.Name == "minutes" then
				if button:lower() == "t" or "е" then
					cancelEvent()
				end
				if button:lower() == "p" or "з" then
					cancelEvent()
				end
				if button:lower() == "u" or "г" then
					cancelEvent()
				end
				if button:lower() == "space" then
					SelectedEdit.Text = SelectedEdit.Text.." "
				end
			end
			if string.len(SelectedEdit.Text) >= 2 then return end
			if string.find(availableKeys, button:lower()) then
				SelectedEdit.Text = SelectedEdit.Text .. button
			end
			if transferKeys[button] == nil then return end
			SelectedEdit.Text = SelectedEdit.Text .. transferKeys[button][1]

			if button:lower() == "t" then
				cancelEvent()
			end
			if button:lower() == "p" then
				cancelEvent()
			end
			if button:lower() == "u" then
				cancelEvent()
			end
		end
	end
end)
