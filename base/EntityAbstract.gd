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
	collide()

#---------------------------------------
func prepare():
	pass

func run(delta):
	$StateMachine.run(self, 0, delta)

func move(delta):
	if (vel.length() < 5):
		vel *= 0
	
	if (ground != null):
		var temp = vel.rotated(UP.angle_to(ground.normal))
		if (ground.collider.has_method("get_vel")):
			temp += ground.collider.get_vel()
			
		self.move_and_slide(temp, UP)
#		self.move_and_slide(vel.rotated(UP.angle_to(ground.normal)) + self.get_floor_velocity(), UP)
	else:
		self.move_and_slide(vel, UP)

func collide():
	
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
			# Hack 2, prevents sliding down as much as possible
			for i in range(-9, 0):
				if (!self.test_move(self.transform, UP * i)):
					ground = self.move_and_collide(UP * (i-1))
					print(i)
		else:
			$StateMachine.on_slide_off(self)

func done():
	
#	Lazy
	if (self.position.length() > 1200):
		self.position *= 0
	
#	if (self.position.y > 560): self.position.y -= 1120
#	if (self.position.x > 680): self.position.x -= 680 * 2
#	elif (self.position.x < -680): self.position.x += 680 * 2
	pass