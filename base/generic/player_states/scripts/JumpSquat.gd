extends Node

export (float) var full_hop = 750
export (float) var short_hop = 500

func exit(main, frame):
	main.grounded = false
	if (main.get_node("Controller").is_mainstick_pointing(2) || main.get_node("Controller").is_jump_pressed()):
		main.vel.y -= full_hop
	else:
		main.vel.y -= short_hop