extends "BaseState.gd"

func enter(entity, collision):
	entity.vel.y = 0
	entity.double_jumps = entity.max_double_jumps
	entity.has_airdodged = false

func on_slide_off(entity):
	return "Fall"