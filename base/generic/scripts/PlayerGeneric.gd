extends KinematicBody2D

var grounded = false
var vel = Vector2(0, 0)
var accel = Vector2(0, 0)
export (float) var baseGravity = 600
const UP = Vector2(0, -1)

func _ready():
	$PlayerStateMachine.current = $PlayerStateMachine/GroundedJump
	self.move_and_slide(Vector2())
	pass

func _physics_process(delta):
	
	accel.x = 0
	accel.y = 0
	
	# process input
	$PlayerStateMachine.run()
	
	# Move
	if (self.is_on_floor() || grounded):
		vel.y = 0
		if (!grounded):
			$PlayerStateMachine.propagate_set_state($PlayerStateMachine.current, "on_land", [$"."])
			grounded = true
	
	vel += accel * delta
	self.move_and_slide(vel, UP)
	