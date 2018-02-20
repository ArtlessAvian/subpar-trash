extends Node

func run(main, frame):
	main.get_node("AnimationPlayer").advance(abs(main.lastVel.x) / main.maxVelX * 1/60)


func try_transition(main, frame):
	if (!Input.is_action_pressed("ui_right") && !main.facingLeft):
		return "Stand"
	if (!Input.is_action_pressed("ui_left") && main.facingLeft):
		return "Stand"
	