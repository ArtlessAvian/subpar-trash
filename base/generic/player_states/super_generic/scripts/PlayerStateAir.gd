extends Node

export (bool) var airdodgeable = false
export (String) var onLand = "Stand"
export (float, -1, 1e4) var gravity = -1

func enter(main, old_state):
	if (self.gravity == -1):
		self.gravity = main.default_gravity

func run(main, frame):
	main.accel.y += self.gravity
	pass

func try_transition(main, frame):
	if (airdodgeable && main.get_node("Controller").is_shield_pressed()):
		return "AirDodge"

func on_land(main, collision):
	return onLand