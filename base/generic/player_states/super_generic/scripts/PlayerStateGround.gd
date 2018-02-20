extends Node

export (bool) var jumpable = true

func enter(main, oldState):
	main.grounded = true;

func try_transition(main, frame):
	
	if (jumpable && Input.is_action_just_pressed("ui_accept")):
		return "JumpSquat"
	pass