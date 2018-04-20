extends "BaseState.gd"

func enter(entity, old):
	entity.vel.y = 0
	entity.double_jumps = entity.max_double_jumps
	entity.has_airdodged = false
	entity.max_vel_y = entity.base_max_vel_y

func on_slide_off(entity):
	return "Fall"