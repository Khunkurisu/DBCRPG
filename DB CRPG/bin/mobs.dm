mob
	var
		//	List containing all player Attributes, with default values.
		list/attributes = list( "Skill Level" = 1, "Battle Power" = 1, "Max Health" = 100, "Health" = 100,
								"Max Stamina" = 100, "Stamina" = 100, "Max Energy" = 100, "Energy" = 100,
								"Strength" = 10, "Spirit" = 10, "Constitution" = 10, "Agility" = 10)

		//	List containing all Combat Traits, with default values.
		list/cTraits = list("Spiritualist" = 0, "Brawler" = 0, "Ranger" = 0, "Blademaster" = 0, "Renegade" = 0)

		//	List containing all Support Traits, with default values.
		list/sTraits = list("Engineer" = 0, "Carpenter" = 0, "Pilot" = 0, "Thief" = 0)

		/*
			Attributes should scale with Battle Power as follows:
				Attribute = baseAttribute * (Battle Power**0.1)
			This would mean that if a player had 10 Strength, BP would scale it in the following manner:
				100 BP, Str = 16
				1,000 BP, Str = 20
				1,000,000 BP, Str = 40
				1,000,000,000,000 BP, Str = 158
			This shall allow attributes to scale upwards with Battle Power while still allowing for Skill Level to remain the primary means of boosting stats.
			Due to this, fights between players with small BP gaps (less than 200% difference) will come down to Skill Level in the long run.
		*/

		//	List that will eventually contain abilities that the player knows how to use.
		list/abilities = new/list()

		mDamage = 0			//Melee Damage to be modified by Strength and Brawler.
		kDamage = 0			//Ki Damage to be modified by Spirit and Spiritualist.
		bDamage = 0			//Blade Damage to be modified by Strength, Weapon Damage, and Blademaster.
		rDamage = 0			//Ranged Damage to be modified by Weapon Damage and Ranger.
		weaponDamage = 0	//Weapon Damage that is set by the currently equipped weapon (if there is one).
		bladeEquip = 0		//Boolean indicating whether currently equipped weapon (if there is one) is a blade or not.
		gunEquip = 0		//Boolean indicating whether currently equipped weapon (if there is one) is a gun or not.
		viewOOC = 1			//Boolean indicating whether or not the player will view messages from the OOC channel.

	Stat()	//	Loop through all player Attributes and list them in the stat window along with their respective values.
		for(var/i=1, i<=usr:attributes.len, i++)
			var/tmp/cAttA = usr:attributes[i]
			var/tmp/cAttB = usr:attributes[cAttA]
			//	Do not display the "Max" variable attributes.
			if(cAttA == "Max Health" || cAttA == "Max Stamina" || cAttA == "Max Energy") continue
			//	Display Health, Stamina, and Energy as percentages rounded to the nearest whole number.
			if(cAttA == "Health" || cAttA == "Stamina" || cAttA == "Energy")
				var/cAttC = "Max [cAttA]"
				cAttB = "[round((usr.attributes[cAttA] / usr.attributes[cAttC]) * 100)]%"
			//stat("<font size=1>[cAttA]: ", "<font size=1>[cAttB]")
			stat("[cAttA]: ", cAttB)
		//	Display all current damage values in the stat window.
		stat("Melee Damage: ", round(usr.mDamage,0.5))
		stat("Ki Damage: ", round(usr.kDamage,0.5))
		stat("Blade Damage: ", round(usr.bDamage,0.5))
		stat("Ranged Damage: ", round(usr.rDamage,0.5))

	Character
		Player
			icon = 'BaseHumanTan(Fem).dmi'
			Login()
				usr.Move(locate(25,25,1))
				spawn(1) usr.keyTick()
				updateDamage()
				..()
			proc
				updateDamage()	//	Goes through each damage type and updates its value based on the player's current Attributes and Traits
					var/tmp/str = usr.attributes["Strength"]
					var/tmp/brawler = usr.cTraits["Brawler"]
					var/tmp/DMG = str**1.1
					mDamage = DMG + (DMG * (brawler * 0.10))
					var/tmp/blademaster = usr.cTraits["Blademaster"]
					DMG = str**1.05 + weaponDamage
					bDamage = DMG + (DMG * (blademaster * 0.10))
					var/tmp/spi = usr.attributes["Spirit"]
					var/tmp/spiritualist = usr.cTraits["Spiritualist"]
					DMG = spi**1.1
					kDamage = DMG + (DMG * (spiritualist * 0.10))
					var/tmp/ranger = usr.cTraits["Ranger"]
					DMG = weaponDamage
					rDamage = DMG + (DMG * (ranger * 0.10))
					if(!gunEquip) rDamage = 0
					if(!bladeEquip) bDamage = 0


		NPC


