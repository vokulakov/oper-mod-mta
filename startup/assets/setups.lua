MAP_NAME = "San-Andreas" -- карта
GAME_TYPE = "OPER STYLE ORIGINAL" -- игровой режим
MOD_INFO = "OPERSKIY × OTDEL 1.1.0" -- информация о моде
SERVER_PASSWORD = "" -- пароль

SHOW_MESSAGE = true -- показывать сообщение в чате перед выключением
KICK_PLAYERS = true -- кикакть игроков перед выключением

startupResources = { -- загружаемые ресурсы
	-- Загрузочный экран запускаем в первую очередь!
	"operLoadingScreen", 

	-- [ADMIN] --
	"admin",
	"ipb",
	
	-- [ASSETS] --
	"operSounds",
	"dpParticles",

	-- [CORE] --
	"operCore",
	"operLogger",
	"operBoneAttach",
	"operVehicleSystem",
	"operVehicleHandling",

	-- [GAMEPLAY] --
	"defaultstats",
	"parachute",
	"reload",
	"realdriveby",

	"operHeadMoving",
	"operChatSystem",
	"operCamHack",
	"operCameraViews",

	"operPlayerCaseMoney",
	"operPlayerVoice",
	--"lmxCustomAnimation",

	"operWeaponSounds",

	"operDriftPoint",
	"operDriftSound",
	"operTuningGarage",

	"operVehicleFSO",
	"operVehicleComponents",
	"operVehiclePlate",
	"operVehicleStrob",
	"operVehicleSGU",
	"operVehicleVinyl",
	"operVehicleObject",
	"operVehicleWheel",
	"operVehicleWheelRotation",
	"operVehicleSmoke",
	"operVehicleNeon",
	
	"operScreenFilter",
	"operVehicleMusic",
	
	"lmxVehicleToner",
	
	"hedit",
	
	-- [MAP] --
	"operMapEdit",
	"operMapGates",

	-- [MODELS] --
	"operVehicleModels",
	"operObjectModels",
	"operWheelModels",
	"operPedModels",
	"operWeaponModels",

	-- [SHADERS] --
	"operShaderContrast",
	"operShaderDof",
	"operShaderDynamicSky",
	"operShaderFXAA",
	"operShaderPuddles",
	"operShaderRadialblur",
	"operShaderRoads",
	"operShaderSkidmarks",
	"operShaderVegetation",
	"operShaderVignette",
	"operShaderWater",

	"operShaderVehicleLights",
	
	--"winter_mod",
	--"winter_snow",

	-- [UI] --
	"operShowUI",
	"operSpeed",
	"operHud",
	"operRadar",
	"operNameTag",
	"operScoreBoard",
	"operDashboard",
	"operShaderPanel",
	"operNotify",
	"operVehicleOnlineRadio",

	-- [OTHER] --
	"anti",
	"ferriswheel",
	"lights",
	"mouse_camera_view",
	"nohud",
	"otrheni",
	"realtime",
	"timecycscript",
	"vehicle_color_nitro",
	
	-- Панель авторизации запускаем самой последней!
	"operLoginPanel",
}
