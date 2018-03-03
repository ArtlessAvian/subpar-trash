extends "../GroundState.gd"

func _ready():
	_jumpable = true
	pass

func try_transition(entity, frame):
	if (entity.get_node("Controller").is_mainstick_neutral() ||
			entity.facing_left != (entity.get_node("Controller").mainstick.x < 0)):
		if (entity.facing_left && entity.get_node("Controller").is_mainstick_pointing(0)):
			return "RunTurnaround"
		if (!entity.facing_left && entity.get_node("Controller").is_mainstick_pointing(4)):
			return "RunTurnaround"
	
		return "RunBrake"
	
	return .try_transition(entity, frame)