extends Node

export (float) var fullHop = 750
export (float) var shortHop = 500

func exit(main, frame):
	main.grounded = false
	if (main.get_node("Controller").is_mainstick_pointing(2) || main.get_node("Controller").is_jump_pressed()):
		main.vel.y -= fullHop
	else:
		main.vel.y -= shortHop