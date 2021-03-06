extends Node

# Adds behavior that Grounded states should share
# USUALLY only decorates the Base state
# @author ArtlessAvian

export (bool) var attackable = false
export (bool) var jumpable = false
export (bool) var dashable = false
export (bool) var walkable = false
export (bool) var fall_throughable = false
export (bool) var crouchable = false

var jump_buffered = false

func enter(main, old_state):
	main.double_jumps = main.max_double_jumps
	main.has_airdodged = false
	jump_buffered = main.get_node("Controller").is_jump_pressed()

func run(main, frame):
	if (jump_buffered):
		jump_buffered = main.get_node("Controller").is_jump_pressed()

func try_transition(main, frame):
	if (attackable && main.get_node("Controller").is_attack_pressed()):
#		if (main.get_node("Controller").is_mainstick_neutral()):
#			return "Jab"
		if (main.get_node("Controller").is_mainstick_pointing(0)):
			main.facing_left = false
			return "FTilt"
		if (main.get_node("Controller").is_mainstick_pointing(4)):
			main.facing_left = true
			return "FTilt"
		return "FTilt"
	
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
	
	if (fall_throughable && !main.ground.collider.get_collision_layer_bit(1) &&
			main.get_node("Controller").mainstick.y == 1):
		return "FallThrough"
	pass
	
	if (crouchable && main.get_node("Controller").mainstick.y > sqrt(2)/2):
		return "Crouch"
	pass

func on_slide_off(main):
	return "Fall"