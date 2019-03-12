/*
	These are simple defaults for your project.
 */

#define DEBUG

world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = "29x21"		// show up to 6 tiles outward from center (13x13 view)

	mob = /mob/Character/Player

proc/ceil(var/x)
	var/y = (-round(-(x)))
	return y

proc/Num2Text(n,precision=6)
	var/t=""
	n=round(n,0.1**precision)
	if(n<0)
		t="-"
		n=-n
	if(n>=1000)
		var/th=round(n/1000)
		t="[t][Num2Text(th,0)],[n/100%10][n/10%10][n%10]"
	else
		t="[t][n]"
	n-=round(n)
	if(!n || precision<1) return
 	//t="[t]."
	//while(precision--)
	//	n*=10
	//	t="[t][n%10]"
	return t

proc/diminishingMult(var/inp, var/inc=5000000, var/max=50, var/perc=0.99, var/min)
	if(!min) min=max/10
	var/rounded = round(inp/inc)
	var/mult = max*perc**(rounded)
	if(mult<min) mult=min
	return mult

// Make objects move 8 pixels per tick when walking

mob
	step_size = 8

obj
	step_size = 8


atom/var
	ID = 0
	ACTION_FLAG = null

var/MOVE_DELAY = 0.0000001