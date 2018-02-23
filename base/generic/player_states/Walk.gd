extends Node

func run(main, frame):
	main.get_node("AnimationPlayer").advance(abs(main.vel.x) / $PlayerStateGround/PlayerStateBase.stick_max_vel * 1/60)

func try_transition(main, frame):
	if (!main.get_node("Controller").is_mainstick_pointing(0) && !main.facing_left):
		return "Stand"
	if (!main.get_node("Controller").is_mainstick_pointing(4) && main.facing_left):
		return "Stand"