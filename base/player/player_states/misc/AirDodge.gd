extends "../../../EntityState.gd"

var _dead_zoned = false
var queue_animation = false

func enter(entity, old):
	entity.has_airdodged = true
	if (entity.get_node("Controller").is_mainstick_neutral()):
		_dead_zoned = true
	else:
		entity.vel = entity.get_node("Controller").mainstick.normalized()
		entity.vel *= 1000
		_dead_zoned = false

func run(entity, frame, delta):
	if (!_dead_zoned):
		if (frame < 15):
			entity.vel *= 0.95
		else:
			entity.vel *= 0
	else:
		entity.vel.y += delta * entity.base_gravity

func hit_floor(entity, collision):
	entity.ground = collision
	return "Land"

func on_timeout(entity, frame):
	return "Fall"