extends "../GroundState.gd"

func _ready():
	_jumpable = true

func enter(entity, old):
	if (entity.facing_left):
		entity.vel.x = min(entity.vel.x, -300)
	else:
		entity.vel.x = max(entity.vel.x, 300)
	.enter(entity, old)

func try_transition(entity, frame):
	if (entity.facing_left):
		if (entity.get_node("Controller").is_mainstick_pointing(0) && entity.get_node("Controller").is_mainstick_banged()):
			entity.facing_left = false
			return "Dash"
	else:
		if (entity.get_node("Controller").is_mainstick_pointing(4) && entity.get_node("Controller").is_mainstick_banged()):
			entity.facing_left = true
			return "Dash"
	
	return .try_transition(entity, frame)

func on_timeout(entity, animation):
	if (entity.facing_left && entity.get_node("Controller").is_mainstick_pointing(4)):
		return "Run"
	elif (!entity.facing_left && entity.get_node("Controller").is_mainstick_pointing(0)):
		return "Run"
	return "Stand"