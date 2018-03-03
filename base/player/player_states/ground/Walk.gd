extends "Stand.gd"

func _ready():
	_standable = true
	_walkable = false

func run(entity, delta):
	entity.get_node("StateMachine/AnimationPlayer").advance(-delta + abs(entity.vel.x) / stick_vel * delta)
	.run(entity, delta)