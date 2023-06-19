Dashboard.accountWindow.vehicles = {}

local VehiclesWnd = Dashboard.accountWindow.vehicles

VehiclesWnd.tab = guiCreateTab("Мой транспорт", Dashboard.accountWindow.tabPanel)

VehiclesWnd.grid_vehList = guiCreateGridList(10, 10, 300, 420, false, VehiclesWnd.tab)
guiGridListSetSortingEnabled(VehiclesWnd.grid_vehList, false)

guiGridListSetSelectionMode(VehiclesWnd.grid_vehList, 1)
guiGridListAddColumn(VehiclesWnd.grid_vehList, "Транспорт", 0.35)
guiGridListAddColumn(VehiclesWnd.grid_vehList, "Номер", 0.29)
guiGridListAddColumn(VehiclesWnd.grid_vehList, "Прочее", 0.3)

--[[
Players.Window.lbl = guiCreateLabel(220, 45, 200, 20, "Информация об игроке:", false, Players.Window.tab)
guiSetFont(Players.Window.lbl, "default-bold-small")
guiLabelSetColor(Players.Window.lbl, 255, 255, 255)

VehiclesWnd.btn_spawn = guiCreateButton(10, 450, 200, 25, "Обновить список", false, Players.Window.tab)
guiSetFont(VehiclesWnd.btn_spawn, "default-bold-small")
guiSetProperty(VehiclesWnd.btn_spawn, "NormalTextColour", "FF21b1ff")
]]