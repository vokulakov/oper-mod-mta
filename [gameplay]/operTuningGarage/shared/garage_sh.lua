Config = {}

-- Координаты объекта гаража
Config.tonerGaragePosition = Vector3(1107, 1874, 10.66 + 2.59)
Config.tonerGarageModel = 1871

-- Положение машины в покрасочной
Config.garageVehiclePosition = Config.tonerGaragePosition + Vector3(0, 1.3, -2.8)
Config.garageVehicleRotation = Vector3(0, 0, 270)
Config.garageInterior = 0

-- Виды транспорта, которые можно красить
Config.allowedVehicleTypes = {
    Automobile = true
}
