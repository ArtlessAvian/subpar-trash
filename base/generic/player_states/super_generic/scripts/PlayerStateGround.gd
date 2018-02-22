extends Node

export (bool) var jumpable = false
export (bool) var walkable = false
export (bool) var dashable = false
export (bool) var crouchable = false

var jump_buffered = false

func enter(main, old_state):
	main.grounded = true;
	main.double_jumps = main.max_double_jumps
	jump_buffered = main.get_node("Controller").is_jump_pressed()

func run(main, frame):
	if (jump_buffered):
		jump_buffered = main.get_node("Controller").is_jump_pressed()

func try_transition(main, frame):
	if (jumpable && !jump_buffered && main.get_node("Controller").is_jump_pressed()):
		return "JumpSquat"
	
	if (dashable && main.get_node("Controller").is_mainstick_pointing(0) && main.get_node("Controller").is_mainstick_banged()):
		main.facing_left = false
		return "Dash"
	if (dashable && main.get_node("Controller").is_mainstick_pointing(4) && main.get_node("Controller").is_mainstick_banged()):
		main.facing_left = true
		return "Dash"
	
	if (walkable && main.get_node("Controller").is_mainstick_pointing(0)):
		main.facing_left = false
		return "Walk"
	if (walkable && main.get_node("Controller").is_mainstick_pointing(4)):
		main.facing_left = true
		return "Walk"
	
	if (crouchable && main.get_node("Controller").mainstick.y > sqrt(2)/2):
		return "Crouch"
	pass