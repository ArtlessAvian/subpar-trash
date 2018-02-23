extends Node

# Adds behavior that Air states should share
# USUALLY only decorates the Base state
# @author ArtlessAvian

export (bool) var attackable = false
export (bool) var double_jumpable = false
export (bool) var airdodgeable = false
export (String) var onLand = "Stand"
export (float, -1, 1e4) var gravity = -1

var _jump_buffered
var _fast_fall_buffered

func enter(main, old_state):
	main.ground = null;
	
	if (self.gravity == -1):
		self.gravity = main.default_gravity
	_jump_buffered = main.get_node("Controller").is_jump_pressed()
	_fast_fall_buffered = main.get_node("Controller").mainstick.y == 1
	
	if ($PlayerStateBase.accel == -1):
		$PlayerStateBase.accel = main.default_drift_accel
	
	if ($PlayerStateBase.stick_max_vel == -1):
		$PlayerStateBase.stick_max_vel = main.default_drift_speed


func run(main, frame):
	main.vel.y += self.gravity * 1/60
	if (_jump_buffered):
		_jump_buffered = main.get_node("Controller").is_jump_pressed()
	
	if (main.get_node("Controller").mainstick.y == 1):
		if (!_fast_fall_buffered):
			main.max_vel_y = main.fast_fall
			main.vel.y = main.fast_fall
	else:
		_fast_fall_buffered = false

func try_transition(main, frame):
	if (attackable && main.get_node("Controller").is_attack_pressed()):
		if (main.get_node("Controller").is_mainstick_neutral()):
			return "Nair"
#		if (main.get_node("Controller").is_mainstick_pointing(0)):
#			main.facing_left = false
#			return "FTilt"
#		if (main.get_node("Controller").is_mainstick_pointing(4)):
#			main.facing_left = true
#			return "FTilt"
	
	if (double_jumpable && !_jump_buffered && main.double_jumps > 0 &&
			main.get_node("Controller").is_jump_pressed()):
		return "DoubleJump"
	if (airdodgeable && !main.has_airdodged && main.get_node("Controller").is_shield_pressed()):
		return "AirDodge"

func on_land(main, collision):
	if (collision != null):
		main.ground = collision
	
	# Keep X
	main.vel.y = -1 / tan(collision.normal.angle()) * main.vel.x
	
	main.max_vel_y = main.default_max_vel_y
	main.set_collision_mask_bit(0, true)
	
	return onLand

#func run(main, frame):
#
#func try_transition(main, frame):