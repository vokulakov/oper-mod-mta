GUI = {}

function GUI.createStaticImagePlate(x, y, w, h, path, window)
	if not isElement(window) then
		return
	end

	return guiCreateStaticImage(x, y, w, h, path, false, window)
end

function GUI.loadStaticImagePlate(staticImage, path)
	if not isElement(staticImage) then
		return
	end
	
	return guiStaticImageLoadImage(staticImage, path)
end

function GUI.getPlateTable()
	return Number.img
end

createStaticImagePlate = GUI.createStaticImagePlate
loadStaticImagePlate = GUI.loadStaticImagePlate
getPlateTable = GUI.getPlateTable