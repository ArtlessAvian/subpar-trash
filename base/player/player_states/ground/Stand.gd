extends "../GroundState.gd"

var _standable = false
var _walkable = true
var _fall_throughable = true

var _jump_buffered

func enter(entity, delta):
	_jump_buffered = entity.get_node("Controller").is_jump_pressed()
	
	.enter(entity, delta)

func run(entity, delta):
	if (_jump_buffered):
		_jump_buffered = entity.get_node("Controller").is_jump_pressed()
	
	.run(entity, delta)

func try_transition(entity, frame):
	if (!_jump_buffered && entity.get_node("Controller").is_jump_pressed()):
		return "JumpSquat"
	
	if (entity.get_node("Controller").is_attack_pressed()):
		if (entity.get_node("Controller").is_mainstick_pointing(0) ||
				entity.get_node("Controller").is_mainstick_pointing(4) ):
			return "FTilt"
		return "Jab"
	
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
		
	if (_fall_throughable && !entity.ground.collider.get_collision_layer_bit(1) &&
			entity.get_node("Controller").mainstick.y == 1):
		return "FallThrough"
	
	.try_transition(entity, frame)