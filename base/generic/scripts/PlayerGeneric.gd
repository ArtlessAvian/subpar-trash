extends KinematicBody2D

const UP = Vector2(0, -1)

var facingLeft = false
var grounded = false

var lastVel;
var vel = Vector2(0, 0)
var accel = Vector2(0, 0)
var friction = 0;
var maxVelX = 0;

export (float) var defaultFriction = 600;
export (float) var defaultMaxVelX = 400
export (float) var maxVelY = 600
export (float) var baseGravity = 1600

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
	lastVel = vel;
	accel.x = 0
	accel.y = 0

func run():
	$PlayerStateMachine.run()
	
	if (friction == -1):
		friction = defaultFriction
		
	if (maxVelX == -1):
		maxVelX = defaultMaxVelX

func move(delta):
	
	accel.y += baseGravity
	if (grounded):
		accel.x -= friction * sign(vel.x)
	
	self.add_vel_x(accel.x * delta)
	self.add_vel_y(accel.y * delta)
	
	if (abs(vel.x) < friction * delta/2):
		vel.x = 0
	
	self.move_and_slide(vel, UP)
	
	if (!grounded && self.is_on_floor()):
		$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$"."])
		grounded = true
	elif (grounded && !self.is_on_floor()):
		if (self.test_move(self.transform, UP * -10)):
			self.move_and_collide(UP * -10)
			grounded = true
		else:
			$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_slide_off", [$"."])
			grounded = false
	
	if (grounded):
		vel.y = 0;
	
	if (self.position.y > 560): self.position.y -= 1120
	if (self.position.x > 880): self.position.x -= 2560
	if (self.position.x < -880): self.position.x += 2560

func done():
	pass

#--------------------------------

# not using this allows for exceeding the limits here

func set_vel_x(x):
	if (vel.x > maxVelX):
		if (x < vel.x):
			vel.x = x
	elif (vel.x < -maxVelX):
		if (x > vel.x):
			vel.x = x
	else:
		vel.x = clamp(x, -maxVelX, maxVelX)
	pass


func set_vel_y(y):
	if (vel.y > maxVelY):
		if (y < vel.y):
			vel.y = y
	else:
		vel.y = min(y, maxVelY)

func add_vel_x(dx):
	self.set_vel_x(vel.x + dx)
	
func add_vel_y(dy):
	self.set_vel_y(vel.y + dy)