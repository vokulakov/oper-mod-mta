---Script by Prinz
---Contact: http://www.mta-sa.org/index.php?page=User&userID=6437

function EchteZeit()
     local time = getRealTime()
	 local hours = time.hour
	 local minutes = time.minute
	 setTime ( hours, minutes )
	 setMinuteDuration(60000)
end
addEventHandler("onResourceStart", getRootElement(), EchteZeit )