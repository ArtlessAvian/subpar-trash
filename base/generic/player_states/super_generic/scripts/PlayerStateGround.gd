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
	if (jumpable && main.get_node("Controller").is_mainstick_pointing(2) && main.get_node("Controller").is_mainstick_banged()):
		return "JumpSquat"
	
	if (jumpable && main.get_node("Controller").is_jump_pressed()):
		return "JumpSquat"
	
	if (dashable && main.get_node("Controller").is_mainstick_pointing(0) && main.get_node("Controller").is_mainstick_banged()):
		main.facingLeft = false
		return "Dash"
	if (dashable && main.get_node("Controller").is_mainstick_pointing(4) && main.get_node("Controller").is_mainstick_banged()):
		main.facingLeft = true
		return "Dash"
	
	if (walkable && main.get_node("Controller").is_mainstick_pointing(0)):
		main.facingLeft = false
		return "Walk"
	if (walkable && main.get_node("Controller").is_mainstick_pointing(4)):
		main.facingLeft = true
		return "Walk"
	pass