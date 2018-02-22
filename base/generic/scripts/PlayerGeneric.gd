extends KinematicBody2D

const UP = Vector2(0, -1)

export (float) var default_friction = 1200
export (float) var default_max_vel_x = 400
export (float) var default_max_vel_y = 800
export (float) var default_gravity = 1600
export (int) var max_double_jumps = 2

var double_jumps = max_double_jumps
var facing_left = false
var grounded = false
var vel = Vector2(0, 0)
var accel = Vector2(0, 0)
var max_vel_y = default_max_vel_y setget set_max_vel_y

func _ready():
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
	
	vel.x += accel.x * delta
	vel.y += accel.y * delta
	
	if (abs(vel.x) < 5):
		vel.x = 0

	vel.y = min(vel.y, max_vel_y)
	
#	print(vel)
	self.move_and_slide(vel, UP)
	
	if (self.is_on_wall()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_bonk", [$".", self.get_slide_collision(0)])
	
	if (self.is_on_ceiling()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_pineapple", [$".", self.get_slide_collision(0)])
	
	
	if (self.is_on_floor()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$".", self.get_slide_collision(0)])
		grounded = true
		vel.y = 0
	elif (grounded):
		if (self.test_move(self.transform, UP * -10)):
			self.move_and_collide(UP * -10)
			grounded = true
			vel.y = 0
		else:
			$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_slide_off", [$"."])
			grounded = false
	

func done():
	if (self.position.y > 560): self.position.y -= 1120
	if (self.position.x > 680): self.position.x -= 680 * 2
	elif (self.position.x < -680): self.position.x += 680 * 2
	pass
	
#------------------------------

func set_max_vel_y(y):
	if (y == -1):
		max_vel_y = default_max_vel_y
	else:
		max_vel_y = y