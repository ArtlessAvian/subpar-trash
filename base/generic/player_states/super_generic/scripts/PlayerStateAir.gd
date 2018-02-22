extends Node

export (bool) var attackable = false
export (bool) var double_jumpable = false
export (bool) var airdodgeable = false
export (String) var onLand = "Stand"
export (float, -1, 1e4) var gravity = -1

var _jump_buffered

func enter(main, old_state):
	if (self.gravity == -1):
		self.gravity = main.default_gravity
	_jump_buffered = main.get_node("Controller").is_jump_pressed()


func run(main, frame):
	main.accel.y += self.gravity
	if (_jump_buffered):
		_jump_buffered = main.get_node("Controller").is_jump_pressed()

func try_transition(main, frame):
	if (double_jumpable && !_jump_buffered && main.double_jumps > 0 &&
			main.get_node("Controller").is_jump_pressed()):
		return "DoubleJump"
	if (airdodgeable && main.get_node("Controller").is_shield_pressed()):
		return "AirDodge"

func on_land(main, collision):
	return onLand
	

#func run(main, frame):
#
#func try_transition(main, frame):