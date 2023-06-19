addEvent("operLoginPanel.onRequestLogin", true)
addEventHandler("operLoginPanel.onRequestLogin", root, function(username, password, checksave)
	if not (username == "") and not (password == "") then
		local account = getAccount(tostring(username), tostring(password))
		if (account) then
			local res = logIn(source, account, tostring(password))
			if not res then
				return triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "login", 'Ошибка авторизации! Обратитесь к администратору.')
			end
			triggerClientEvent(source, "operLoginPanel.hideLoginWindow", source)
			
			if checksave then
				triggerClientEvent(source, "operLoginPanel.saveLoginToXML", source, username, password)
			else
				triggerClientEvent(source, "operLoginPanel.resetSaveXML", source, username, password)
			end

		else
			triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "login", "Неправильное имя пользователя и/или пароль!")
		end
	else
		triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "login", "Пожалуйста, укажите имя пользователя и/или пароль!")
	end
end)

addEvent("operLoginPanel.onRequestRegister", true)
addEventHandler("operLoginPanel.onRequestRegister", root, function(username, password, passwordConfirm)
	if not (username == "") then
		if not (password == "") then
			if not (passwordConfirm == "") then
				if password == passwordConfirm then
					local account = getAccount (username,password)
					if (account == false) then
						local accountID = #getAccounts() + 1
						local accountAdded = addAccount(tostring(username),tostring(password))
						if (accountAdded) then
							local res = logIn(source, accountAdded, tostring(password))
							if not res then
								return triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "login", 'Ошибка авторизации! Обратитесь к администратору.')
							end
							triggerClientEvent(source, "operLoginPanel.hideLoginWindow", source)
							--triggerClientEvent(source, 'exv_save.createNewAccount', source, accountAdded, accountID)
							outputChatBox("#FF0000* #00FF00Вы успешно зарегистрировались!", source, 255, 255, 255, true)
							-- нужно сделать вывод в систему уведомлений
						else
							triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "register", "Произошла неизвестная ошибка!\nВыберите другое имя пользователя / пароль и повторите попытку.")
						end

					else
						triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "register", "Учетная запись с таким именем пользователя уже существует!")
					end
				else
					triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "register", "Пароли не совпадают!")
				end

			else
				triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "register", "Пожалуйста, подтвердите Ваш пароль!")
			end
		else
			triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "register", "Пожалуйста, введите пароль!")
		end
	else
		triggerClientEvent(source, "operLoginPanel.set_warning_text", source, "register", "Пожалуйста, введите имя пользователя,\nпод которым вы хотите зарегистрироваться!")
	end
end)