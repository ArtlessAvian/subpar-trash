extends "../GroundState.gd"

func _ready():
	pass

func enter(entity, old):
	entity.facing_left = !entity.facing_left
	.enter(entity, old)

func on_timeout(entity, animation):
	if (entity.facing_left && entity.get_node("Controller").is_mainstick_pointing(4)):
		return "Run"
	elif (!entity.facing_left && entity.get_node("Controller").is_mainstick_pointing(0)):
		return "Run"
	return "Stand"