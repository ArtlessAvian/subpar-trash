extends Node

export (bool) var jumpable = false
export (bool) var walkable = false
export (bool) var dashable = false
export (bool) var crouchable = false

export (float) var initial_velocity = 0

func enter(main, oldState):
	main.grounded = true;
	if (main.facing_left):
		main.vel.x -= initial_velocity
	else:
		main.vel.x += initial_velocity

func run(main, frame):
	pass

func try_transition(main, frame):
	if (jumpable && main.get_node("Controller").is_jump_pressed()):
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
	pass