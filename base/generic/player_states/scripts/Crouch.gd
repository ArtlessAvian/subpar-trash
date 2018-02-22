extends Node

func try_transition(main, frame):
	if (!main.get_node("Controller").is_mainstick_pointing(6)):
		return "Stand"