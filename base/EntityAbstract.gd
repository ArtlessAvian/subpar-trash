extends KinematicBody2D

# Assumes that States in the StateMachine are EntityStates

const UP = Vector2(0, -1)
var ground = null
var vel = Vector2(0, 0)

func _ready():
	pass

# Gets disabled by a list, to prevent ordering issues.
func _physics_process(delta):
	run(delta)
	move(delta)

#---------------------------------------
func run(delta):
	$StateMachine.run(self, delta)

func move(delta):
	
	if (vel.length() < 5):
		vel *= 0
	
	if (ground != null):
		self.move_and_slide(vel.rotated(UP.angle_to(ground.normal)) + ground.collider_velocity, UP)
	else:
		self.move_and_slide(vel, UP)
	
	if (self.is_on_wall()):
		$StateMachine.hit_wall(self, self.get_slide_collision(0))
	
	if (self.is_on_ceiling()):
		$StateMachine.hit_ceiling(self, self.get_slide_collision(0))
	
	if (ground == null && self.is_on_floor()):
		# if vel.x == 0, then theres no collision????
		# hack solution
		var collision
		if (self.get_slide_count() > 0):
			collision = self.get_slide_collision(0)
		else:
			collision = self.move_and_collide(UP * -10)
		
		$StateMachine.hit_floor(self, collision)
	if (ground != null):
		if (self.test_move(self.transform, UP * -10)):
			ground = self.move_and_collide(UP * -10)
			pass
		else:
			$StateMachine.on_slide_off(self)