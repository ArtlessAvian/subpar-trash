extends Node

func run(main, frame):
	main.get_node("AnimationPlayer").advance(abs(main.lastVel.x) / main.defaultMaxVelX * 1/60)
	main.maxVelX = main.get_node("Controller").mainstick.length() * main.defaultMaxVelX

func try_transition(main, frame):
	if (!main.get_node("Controller").is_mainstick_pointing(0) && !main.facingLeft):
		return "Stand"
	if (!main.get_node("Controller").is_mainstick_pointing(4) && main.facingLeft):
		return "Stand"

func on_slide_off(main):
	print("ahhh")