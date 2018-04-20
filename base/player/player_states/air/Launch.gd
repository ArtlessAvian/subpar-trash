extends "../AirState.gd"

var length = 20

func _ready():
	friction_multiplier = 0
	pass

func enter(entity, old):
#	if (!entity.get_node("Controller").is_mainstick_neutral()):
#		var d_theta = entity.knockback_vel.angle_to(entity.get_node("Controller").mainstick)
#		if (abs(d_theta) > PI/2):
#			d_theta = PI - d_theta
#		print(d_theta)
#		entity.knockback_vel = entity.knockback_vel.rotated(d_theta)
#	print(entity.knockback_vel.angle() * 180/PI)
	
	.enter(entity, old)

func try_transition(entity, frame):
#	if (entity.knockback_vel.length() < 5):
	print(frame)
	if (frame > length):
		return "Fall"
	return .try_transition(entity, frame)

func run(entity, frame, delta):
	.run(entity, frame, delta)
