mob/verb

	//	Dumps a list of all variables and their current values into the chat.
	dump()
		var/V
		for(V in vars)
			usr << "[V] = [vars[V]]"
	//	Send a message to those within the local area.
	say()
		view() << "[usr.name] begins typing..."
		var/msg = input("What will your character say?", "Local Say") as text
		sendMessage(msg, "local")
		view() << "[usr.name] has finished typing!"
	//	Send a message to the global
	ooc()
		var/msg = input("What do you have to say?", "Global Say") as text
		sendMessage(msg, "global")

	toggleOOC()
		usr.viewOOC = !usr.viewOOC
		if(usr.viewOOC) usr << "You will now see global messages from other players."
		else usr << "You will no longer see global messages from other players."

	//	Provides the ability to edit player Attributes.
	editAtt()
		var/inp = input("Pick an attribute to edit.", "Edit Attribute", "Cancel") in list("Cancel") + usr.attributes
		if(inp == "Cancel") return
		var/inp2 = input("Input a value for this attribute.", "Edit [inp]", usr.attributes[inp]) as num
		usr.attributes[inp] = inp2
		usr << "[inp] changed to [inp2]!"
		usr:updateDamage()

	//	Provides the ability to edit player Combat Traits.
	editCTraits()
		var/inp = input("Pick a trait to edit.", "Edit Trait", "Cancel") in list("Cancel") + usr.cTraits
		if(inp == "Cancel") return
		var/inp2 = input("Input a value for this attribute.", "Edit [inp]", usr.cTraits[inp]) as num
		usr.cTraits[inp] = inp2
		usr << "[inp] changed to [inp2]!"
		usr:updateDamage()

	//	Provides the ability to edit player Support Traits.
	editSTraits()
		var/inp = input("Pick a trait to edit.", "Edit Trait", "Cancel") in list("Cancel") + usr.sTraits
		if(inp == "Cancel") return
		var/inp2 = input("Input a value for this attribute.", "Edit [inp]", usr.sTraits[inp]) as num
		usr.sTraits[inp] = inp2
		usr << "[inp] changed to [inp2]!"
		usr:updateDamage()

	//	Provides the ability to add an ability to a player's list of abilities.
	addAbility()
		var/inp = input("Choose an ability to add.", "Add Ability", "Cancel") in list("Cancel") + (typesof(/obj/Abilities) - /obj/Abilities)
		if(inp == "Cancel") return
		var/obj/Abilities/A = new inp
		usr.abilities.Add(A)
	testMult()
		var/inp = input("Input a base powerlevel value to test the diminishing multiplier effect.", "Input Powerlevel") as num
		if(inp <= 0) return
		var/mult = diminishingMult(inp)
		usr << "You input: [num2text(inp,24)]"
		usr << "Final multiplier is: [mult]"
		usr << "Multiplied BP is: [num2text(mult * inp,24)]"
	/*findMultDropoff()
		var/y
		var/increment = 5000000
		var/maximum = 50
		var/minimum = maximum / 10
		var/perc = 0.99
		var/mult = maximum
		spawn(-1)
			for(y=5000000, mult>minimum)
				var/x = y/increment
				var/rounded = round(x)
				mult = maximum*perc**(rounded)
				usr << "Current loop bp is [num2text(y,24)]"
				usr << "Multiplier is: [mult]"
				usr << "Multiplied BP is: [num2text(mult * y, 24)]"
				y+=5000000
				sleep(0.01)
			usr << "BP Threshold: [num2text(y,24)]"*/