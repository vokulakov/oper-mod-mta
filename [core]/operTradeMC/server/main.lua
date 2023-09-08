Donate = {}

-- Выводить сообщение в чат о том, что такой то игрок поддержал проект
-- Так же проигрывать звук фанфар
function Donate.addAccountPrivilege(acc_username, privilege, time_action)
    if type(acc_username) ~= 'string' or acc_username == '' then
        return
    end

    if type(privilege) ~= 'string' or privilege == '' then 
        return
    end

    local account = getAccount(tostring(acc_username))
    if not account then
        exports.operLogger:log("trademc", 
            string.format(
                "Ошибка выдачи привелегии. Аккаунт с логином '%s' не найден! (%s)", 
                tostring(acc_username),
                tostring(privilege)
            )
        )
        return 
    end
    
    local result = aclGroupAddObject(aclGetGroup(tostring(privilege)), "user."..tostring(acc_username))
    if result then
        exports.operLogger:log(
            "trademc", 
            string.format(
                "Выдача привелегии. Аккаунт с логином '%s' добавлен в группу '%s'", 
                tostring(acc_username),
                tostring(privilege)
            )
        )
    else
        exports.operLogger:log(
            "trademc", 
            string.format(
                "Ошибка выдачи привелегии. Аккаунт с логином '%s' не добавился в группу '%s'", 
                tostring(acc_username),
                tostring(privilege)
            )
        )
    end
end

function Donate.removeAccountPrivilege(acc_username, privilege)
    if type(acc_username) ~= 'string' or acc_username == '' then
        return
    end

    if type(privilege) ~= 'string' or privilege == '' then 
        return
    end

    local account = getAccount(tostring(acc_username))
    if not account then
        exports.operLogger:log("trademc", 
            string.format(
                "Ошибка удаления привелегии. Аккаунт с логином '%s' не найден! (%s)", 
                tostring(acc_username),
                tostring(privilege)
            )
        )
        return 
    end

    local result = aclGroupRemoveObject(aclGetGroup(tostring(privilege)), "user."..tostring(acc_username))
    if result then
        exports.operLogger:log(
            "trademc", 
            string.format(
                "Удаление привелегии. Аккаунт с логином '%s' удален из группы '%s'", 
                tostring(acc_username),
                tostring(privilege)
            )
        )
    else
        exports.operLogger:log(
            "trademc", 
            string.format(
                "Ошибка удаления привелегии. Аккаунт с логином '%s' не найден в группе '%s'", 
                tostring(acc_username),
                tostring(privilege)
            )
        )
    end
end

-- Exports
addAccountPrivilege = Donate.addAccountPrivilege
removeAccountPrivilege = Donate.removeAccountPrivilege