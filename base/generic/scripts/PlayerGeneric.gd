extends KinematicBody2D

const UP = Vector2(0, -1)

export (float) var default_friction = 600
export (float) var default_max_vel_x = 400
export (float) var default_max_vel_y = 600
export (float) var base_gravity = 1600

var facing_left = false
var grounded = false
var vel = Vector2(0, 0)
var accel = Vector2(0, 0)
var friction = default_friction setget set_friction
var max_vel_x = default_max_vel_x setget set_max_vel_x
var max_vel_y = default_max_vel_y setget set_max_vel_y

func _ready():
	$PlayerStateMachine.current = $PlayerStateMachine.get_child(0)
	self.move_and_slide(Vector2())
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
	
	if (grounded):
		accel.x -= friction * sign(vel.x)
	else:
		accel.y += base_gravity
	
	vel.x += accel.x * delta
	vel.y += accel.y * delta
	
	if (abs(vel.x) < friction * delta/2):
		vel.x = 0
	vel.x = clamp(vel.x, -max_vel_x, max_vel_x)
	vel.y = min(vel.y, max_vel_y)
	
	self.move_and_slide(vel, UP)
	
	if (!grounded && self.is_on_floor()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$"."])
		grounded = true
		vel.y = 0
	elif (grounded && !self.is_on_floor()):
		if (self.test_move(self.transform, UP * -10)):
			self.move_and_collide(UP * -10)
			grounded = true
			vel.y = 0
		else:
			$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_slide_off", [$"."])
			grounded = false
	

func done():
	if (self.position.y > 560): self.position.y -= 1120
	if (self.position.x > 880): self.position.x -= 2560
	if (self.position.x < -880): self.position.x += 2560
	pass
	
#------------------------------

func set_friction(x):
	if (friction == -1):
		friction = default_friction
	else:
		friction = x

func set_max_vel_x(x):
	if (x == -1):
		max_vel_x = default_max_vel_x
	else:
		max_vel_x = x

func set_max_vel_y(y):
	if (y == -1):
		max_vel_y = default_max_vel_y
	else:
		max_vel_y = y