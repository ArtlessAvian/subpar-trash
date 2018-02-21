extends Node

export (float) var initial_velocity

func enter(main, old_state):	
	if (main.facing_left):
		main.vel.x -= initial_velocity
	else:
		main.vel.x += initial_velocity
	if (abs(main.vel.x) > abs($PlayerStateGround/PlayerStateBase.stick_max_vel)):
		main.vel.x = $PlayerStateGround/PlayerStateBase.stick_max_vel * sign(main.vel.x)