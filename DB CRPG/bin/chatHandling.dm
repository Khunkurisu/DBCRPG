mob/proc
	sendMessage(var/msg, var/target)
		msg = html_encode(msg)
		if(target=="local") view() << "<span class=\"localChat\">[usr.name]: [msg]</span>"
		if(target=="global")
			for(var/mob/M in world)
				if(M.viewOOC) world << "<span class=\"globalChat\">[usr.name]: [msg]</span>"