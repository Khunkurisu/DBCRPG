turf
	/*Click()
		if(usr.hasZanzoken)
			var/mob/Skills/U = new
			U.Zanzoken(usr,src)*/

	ground
		icon = 'ground.dmi'
		icon_state = "grass1"
		ID = "r"
		fertile
			grass
				ID = "g"
				icon_state = "grass1"
		sand
			icon = 'sand.dmi'
			icon_state = "sand1"
			name = "sand"
			ID = "s"
			New()
				..()
				var/istate = rand(0,2)
				switch(istate)
					if(0) icon_state = "[name]1"
					if(1) icon_state = "[name]2"
					if(2) icon_state = "[name]3"
			redSand
				ID = "rs"
				name = "sandRed"
	liquid
		density = 1
		water
			ID = "w"
			icon = 'water.dmi'
			name = "Water"
			New()
				..()
				var/istate = rand(0,1)
				switch(istate)
					if(0) icon_state = "[name]1"
					if(1) icon_state = "[name]2"
					if(2) icon_state = "[name]3"
					if(3) icon_state = "[name]4"

	wall
		icon = 'wall.dmi'
		ID = "wa"
		density = 1
		opacity = 1

		decWall
			ID = "dw"
			icon_state = "Shale"
			opacity = 0

	door
		icon='assets\\turfs\\redbrickdoor.dmi'
		density=1
		luminosity=0
		opacity=1
		Enter(mob/O, atom/OL)
			O << "Yar"
			..()
