ACCOUNTS_TABLE_NAME = "accounts"

local ACCOUNTS_TABLE = {
	
	-- Номер поля
	{name = "ID", type = "INTEGER", option = "PRIMARY KEY"},

	-- Идентификатор пользователя
	{name = "user_id", type = "TEXT", option = "NOT NULL UNIQUE"},
	-- Имя пользователя
	{name = "username", type = "TEXT"},

	-- Онлайн
	{name = "online", type = "INTEGER"},

	-- Количество минут, проведённых в игре
	{name = "playtime", type = "INTEGER"},

	-- Дата регистрации
	{name = "register_time", type = "INTEGER"},
	-- IP при регистрации
	{name = "register_ip", type = "TEXT"},
	-- Serial при регистрации
	{name = "register_serial", type = "TEXT"},

	-- Дата последней активности
	{name = "lastseen_time", type = "INTEGER"},
	-- IP последней авторизации
	{name = "lastseen_ip", type = "TEXT"},
	-- Serial последней авторизации
	{name = "lastseen_serial", type = "TEXT"}

}

Accounts = {}

function Accounts.setup()
	local db = Database.getConnection()
	dbExec(db, "CREATE TABLE IF NOT EXISTS "..ACCOUNTS_TABLE_NAME.." ("..Database.createTable(ACCOUNTS_TABLE)..") ")
end

local function getRealDate() -- определение текущей даты
	local TIME = getRealTime()
	local DATE_MONTHDAY, DATE_MONTH, DATE_YEAR = string.format("%02d", TIME.monthday), string.format("%02d", TIME.month + 1), TIME.year + 1900
	
	return DATE_YEAR.."-"..DATE_MONTH.."-"..DATE_MONTHDAY.." "..string.format("%02d", TIME.hour)..":"..string.format("%02d", TIME.minute)..":"..string.format("%02d", TIME.second)
end

function Accounts.addAccount(player, username)
	local db = Database.getConnection()

	local serial = getPlayerSerial(player)
	local ip = getPlayerIP(player)
	local time = getRealDate()

	local user_id = "id"..tonumber(#getAccounts() + 1)

	dbExec(db, "INSERT INTO `"..ACCOUNTS_TABLE_NAME.."` (`user_id`, `username`, `register_time`, `register_ip`, `register_serial` ) VALUES ('"..user_id.."', '"..username.."', '"..time.."', '"..ip.."', '"..serial.."');")
end

-- Получение данных аккаунта
function Accounts.getData(account)
	local db = Database.getConnection()

	if not account then
		return outputDebugString("Accounts.getData: Не удалось получить account.", 1)
	end

	local result = dbPoll(dbQuery(db, "SELECT * FROM "..ACCOUNTS_TABLE_NAME.." WHERE username = ?", getAccountName(account)), -1)

	return result[1]
end

function Accounts.saveAccount(player) -- сохранение данных аккаунта
	if not isElement(player) then
        return false
    end

    local accountData = player:getData("player.accountData")

    if not accountData then
        return
    end

    local db = Database.getConnection()

    dbExec(db, "UPDATE "..ACCOUNTS_TABLE_NAME.." SET playtime = ? WHERE username = ?", 
    	tonumber(player:getData("player.playtime")), 
    	accountData.username
    ) 
end

function Accounts.updateLastseen(player, username, isOnline)
	local db = Database.getConnection()

	local serial = getPlayerSerial(player)
	local ip = getPlayerIP(player)
	local time = getRealDate()

	local account = getPlayerAccount(player)
	if not account then
		return outputDebugString("Accounts.getData: Не удалось получить account.", 1)
	end

	dbExec(db, "UPDATE "..ACCOUNTS_TABLE_NAME.." SET online = ?, lastseen_time = ?, lastseen_ip = ?, lastseen_serial = ? WHERE username = ?",
		isOnline,
		time,
		ip,
		serial,
		tostring(username)
	)

end