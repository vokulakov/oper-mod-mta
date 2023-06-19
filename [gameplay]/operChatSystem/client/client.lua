bindKey("t", "down", "chatbox", "Сообщение")
bindKey("y", "down", "chatbox", "Сказать")

-- клиентские команды
function startCommandClient(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	if source ~= localPlayer then return end
	local state = executeCommandHandler(arg1, arg2, arg3, arg4, arg5, arg6, arg7)

	if not state then
		--outputChatBox('* Неизвестная команда!', 170, 0, 0)
		triggerEvent('operNotification.addNotification', localPlayer, 'Неизвестная команда', 2, true)
	end

end
addEvent("startCommandClient", true)
addEventHandler("startCommandClient", root, startCommandClient)


local gChatting = false
 
function chatCheckPulse()
    local chatState = isChatBoxInputActive()
 
    if chatState ~= gChatting then
        localPlayer:setData('player.isChatting', chatState)
        gChatting = chatState
    end
    setTimer(chatCheckPulse, 250, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, chatCheckPulse)
addEventHandler("onClientPlayerJoin", root, chatCheckPulse)


