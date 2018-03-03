extends Node

export (float) var full_hop = 900
export (float) var short_hop = 600
export (float) var initial_velocity = -1

#func _ready():
#	if (initial_velocity == -1):
#		initial_velocity = $PlayerStateAir/PlayerStateBase.stick_max_vel

func enter(main, frame):
	if (main.get_node("Controller").is_mainstick_pointing(2) || main.get_node("Controller").is_jump_pressed()):
		main.vel.y = -full_hop
	else:
		main.vel.y = -short_hop
	
	if (initial_velocity == -1):
		yield()
		initial_velocity = $PlayerStateAir/PlayerStateBase.stick_max_vel
	
	main.vel.x += main.get_node("Controller").mainstick.x * initial_velocity
	main.vel.x = clamp(main.vel.x, -$PlayerStateAir/PlayerStateBase.stick_max_vel, $PlayerStateAir/PlayerStateBase.stick_max_vel)

func run(main, frame):
	main.set_collision_mask_bit(0,
			main.get_node("Controller").mainstick.y < sqrt(2)/2)

func try_transition(main, frame):
	if (main.vel.y > 0):
		return "Fall"