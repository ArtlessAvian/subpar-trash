extends "BaseState.gd"

var _airdodgeable = false

var _jump_buffered
var gravity_multiplier = 1

func enter(entity, delta):
	
	accel = entity.base_drift_accel
	stick_vel = entity.base_drift_speed
	
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

func run(entity, frame, delta):
	entity.vel.y += entity.base_gravity * delta * gravity_multiplier
	
	if (_jump_buffered):
		_jump_buffered = entity.get_node("Controller").is_jump_pressed()
	
	if (entity.vel.y >= 0 && entity.get_node("Controller").mainstick.y == 1):
		entity.max_vel_y = entity.fast_fall
		entity.vel.y = entity.fast_fall
	
	entity.set_collision_mask_bit(0,
			entity.get_node("Controller").mainstick.y < sqrt(2)/2)
	
	.run(entity, frame, delta)

func hit_floor(entity, collision):
	entity.ground = collision
	return "Land"