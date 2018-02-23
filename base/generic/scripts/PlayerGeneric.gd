extends KinematicBody2D

const UP = Vector2(0, -1)

export (float) var default_friction = 1200
export (float) var default_max_vel_x = 400
export (float) var default_max_vel_y = 800
export (float) var fast_fall = 1200
export (float) var default_gravity = 1600
export (float) var default_drift_accel = 1200
export (float) var default_drift_speed = 400
export (int) var max_double_jumps = 2

var double_jumps = max_double_jumps
var has_airdodged = false
var facing_left = false
var ground = null
var vel = Vector2(0, 0)
var accel = Vector2(0, 0)
var max_vel_y = default_max_vel_y

func _ready():
	self.move_and_slide(Vector2())
	$Hitboxes.set_collision_layer_bit(10, true)
	$Hurtboxes.set_collision_mask_bit(10, false)
	pass

func _physics_process(delta):
	prepare()
	run()
	move(delta)
	done()

#---------------------------------------

func prepare():
	accel.x = 0
	accel.y = 0

func run():
	$PlayerStateMachine.run()

func move(delta):
	
	vel.x += accel.x * delta
	vel.y += accel.y * delta
	
	if (vel.length() < 5):
		vel *= 0
	vel.y = min(vel.y, max_vel_y)
	
#	print(vel)
	if (ground != null):
		self.move_and_slide(vel + ground.collider_velocity, UP)
	else:
		self.move_and_slide(vel, UP)
	
	if (self.is_on_wall()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_bonk", [$".", self.get_slide_collision(0)])
	
	if (self.is_on_ceiling()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_pineapple", [$".", self.get_slide_collision(0)])
	
	
#	if (self.is_on_floor()):
#		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$".", self.get_slide_collision(0)])
#
#	if (self.test_move(self.transform, UP * -10)):
#		if (vel.y >= 0):
#			var collision = self.move_and_collide(UP * -10)
#			$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$".", collision])
#	else:
#		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_slide_off", [$"."])
#
	if (self.is_on_floor() && ground == null):
		# if vel.x == 0, then theres no collision????
		# hack solution
		var collision
		if (self.get_slide_count() > 0):
			collision = self.get_slide_collision(0)
		else:
			collision = self.move_and_collide(UP * -10)
		
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$".", collision])
	if (ground != null):
		if (self.test_move(self.transform, UP * -10)):
			ground = self.move_and_collide(UP * -10)
		else:
			$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_slide_off", [$"."])

func done():
	if (self.position.y > 560): self.position.y -= 1120
	if (self.position.x > 680): self.position.x -= 680 * 2
	elif (self.position.x < -680): self.position.x += 680 * 2
	pass