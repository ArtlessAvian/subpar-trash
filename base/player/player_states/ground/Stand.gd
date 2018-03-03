extends "../GroundState.gd"

var _standable = false
var _walkable = true

func try_transition(entity, frame):
	if (entity.get_node("Controller").is_jump_pressed()):
		return "JumpSquat"

	if (_standable && !entity.get_node("Controller").is_mainstick_pointing(0) && !entity.facing_left):
		return "Stand"
	if (_standable && !entity.get_node("Controller").is_mainstick_pointing(4) && entity.facing_left):
		return "Stand"
	if (_walkable && entity.get_node("Controller").is_mainstick_pointing(0)):
		entity.facing_left = false
		return "Walk"
	if (_walkable && entity.get_node("Controller").is_mainstick_pointing(4)):
		entity.facing_left = true
		return "Walk"
	
	.try_transition(entity, frame)