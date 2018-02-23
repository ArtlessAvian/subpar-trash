extends Node

export (float) var initial_velocity
export (float) var target_velocity = 600

var fastest_l = 0
var fastest_r = 0

func enter(main, old_state):
	
	$PlayerStateGround/PlayerStateBase.target_vel_x = target_velocity * sign(main.get_node("Controller").mainstick.x)
	main.vel.x += sign(main.get_node("Controller").mainstick.x) * initial_velocity
	main.vel.x = clamp(main.vel.x, -$PlayerStateGround/PlayerStateBase.stick_max_vel, $PlayerStateGround/PlayerStateBase.stick_max_vel)
	
	fastest_l = 0
	fastest_r = 0

func exit(main, frame):
	print(fastest_l)
	print(fastest_r)

func run(main, frame):
	if (fastest_r < main.vel.x):
		fastest_r = main.vel.x
	if (fastest_l > main.vel.x):
		fastest_l = main.vel.x

func try_transition(main, frame):
	if (main.facing_left && main.get_node("Controller").is_mainstick_pointing(0) && main.get_node("Controller").is_mainstick_banged()):
		main.facing_left = false
		return "Dash"
	if (!main.facing_left && main.get_node("Controller").is_mainstick_pointing(4) && main.get_node("Controller").is_mainstick_banged()):
		main.facing_left = true
		return "Dash"
	
	if (frame > $PlayerStateGround/PlayerStateBase.frame_length):
		if (main.get_node("Controller").is_mainstick_neutral()):
			$PlayerStateGround/PlayerStateBase.timeout_state = "Stand"
		else:
			$PlayerStateGround/PlayerStateBase.timeout_state = "Run"
		pass