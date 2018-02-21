extends Node

func run(main, frame):
	main.get_node("AnimationPlayer").advance(abs(main.vel.x) / main.default_max_vel_x * 1/60)
	main.max_vel_x = main.get_node("Controller").mainstick.length() * main.default_max_vel_x

func try_transition(main, frame):
	if (!main.get_node("Controller").is_mainstick_pointing(0) && !main.facing_left):
		return "Stand"
	if (!main.get_node("Controller").is_mainstick_pointing(4) && main.facing_left):
		return "Stand"

func on_slide_off(main):
	print("ahhh")