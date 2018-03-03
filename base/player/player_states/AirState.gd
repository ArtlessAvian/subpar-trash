extends "BaseState.gd"

func enter(entity, delta):
	entity.ground = null
	entity.get_node("StateMachine/AnimationPlayer").queue("Fall")
	.enter(entity, delta)

func run(entity, delta):
	entity.vel.y += entity.default_gravity * 1/60
	.run(entity, delta)

func hit_floor(entity, collision):
	entity.ground = collision
	return "Land"