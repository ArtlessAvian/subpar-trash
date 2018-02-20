extends Node

export (float) var fullHop = 600
export (float) var shortHop = 400

func exit(main, frame):
	main.grounded = false
	if (Input.is_action_pressed("ui_up")):
		main.vel.y -= fullHop
	else:
		main.vel.y -= shortHop