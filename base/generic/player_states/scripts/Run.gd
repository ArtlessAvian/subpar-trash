extends Node

func try_transition(main, frame):
	if (!main.get_node("Controller").is_mainstick_pointing(0) && !main.facing_left):
		return "Stand"
	if (!main.get_node("Controller").is_mainstick_pointing(4) && main.facing_left):
		return "Stand"