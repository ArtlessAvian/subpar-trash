extends "../AirState.gd"

var _dead_zoned = false

func enter(entity, old):
	entity.has_airdodged = true
	if (entity.get_node("Controller").is_mainstick_neutral()):
		_dead_zoned = true
	else:
		entity.vel = entity.get_node("Controller").mainstick.normalized()
		entity.vel *= 1000
		_dead_zoned = false
	.enter(entity, old)

func run(entity, delta):
	if (!_dead_zoned):
#		if (frame < 15):
		entity.vel *= 0.95
#		else:
#			entity.vel *= 0
	.run(entity, delta)

func on_timeout(entity, frame):
	return "Fall"