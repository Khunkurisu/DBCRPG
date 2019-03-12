mob/proc
	UpdateGame(var/F as file)
		set category="Admin"
		fcopy(F,"[F]")
		world << "[usr.key] used update."