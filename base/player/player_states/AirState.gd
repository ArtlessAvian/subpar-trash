extends "BaseState.gd"

var _airdodgeable = false

var _jump_buffered

func enter(entity, delta):
	
	if (accel == -1):
		accel = entity.default_drift_accel
	
	if (stick_vel == -1):
		stick_vel = entity.default_drift_speed
	
	entity.ground = null
	entity.get_node("StateMachine/AnimationPlayer").queue("Fall")
	_jump_buffered = entity.get_node("Controller").is_jump_pressed()
	
	.enter(entity, delta)

func try_transition(entity, frame):
	if (!_jump_buffered && entity.double_jumps > 0 && entity.get_node("Controller").is_jump_pressed()):
		return "DoubleJump"
	if (_airdodgeable && !entity.has_airdodged && entity.get_node("Controller").is_shield_pressed()):
		return "AirDodge"
	return .try_transition(entity, frame)

func run(entity, delta):
	entity.vel.y += entity.default_gravity * 1/60
	
	if (_jump_buffered):
		_jump_buffered = entity.get_node("Controller").is_jump_pressed()
	
	entity.set_collision_mask_bit(0,
			entity.get_node("Controller").mainstick.y < sqrt(2)/2)
	
	.run(entity, delta)

func hit_floor(entity, collision):
	entity.ground = collision
	return "Land"