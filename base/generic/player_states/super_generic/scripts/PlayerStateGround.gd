extends Node

export (bool) var jumpable = false
export (bool) var walkable = false
export (bool) var dashable = false

export (float) var initialVelocity = 0

func enter(main, oldState):
	main.grounded = true;
	if (main.facingLeft):
		main.add_vel_x(-initialVelocity)
	else:
		main.add_vel_x(initialVelocity)

func run(main, frame):
	pass

func try_transition(main, frame):
	if (jumpable && Input.is_action_just_pressed("ui_up")):
		return "JumpSquat"
	if (walkable && Input.is_action_just_pressed("ui_right")):
		main.facingLeft = false
		return "Walk"
	if (walkable && Input.is_action_just_pressed("ui_left")):
		main.facingLeft = true
		return "Walk"
	pass