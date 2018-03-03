extends "BaseState.gd"

func enter(entity, collision):
	entity.vel.y = 0

func on_slide_off(entity):
	return "GroundedJump"