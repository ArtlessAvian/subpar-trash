extends "../../EntityState.gd"

export (bool) var queue_animation = false

export (float) var stick_vel = 0
export (float) var accel = 0
var target_vel_x = 0

func enter(entity, old):
	pass

func exit(entity, new):
	pass

func try_transition(entity, frame):
	pass

func run(entity, delta):
	
	if (stick_vel > 0):
		if (entity.get_node("Controller").is_mainstick_neutral()):
			target_vel_x = 0
		else:
			target_vel_x = entity.get_node("Controller").mainstick.x * stick_vel
	
	var before = entity.vel.x > target_vel_x
	
	if (entity.vel.x != target_vel_x):
		if (abs(entity.vel.x) > abs(target_vel_x) && entity.vel.x * target_vel_x >= 0):
			if (true):
				entity.vel.x -= entity.default_friction * sign(entity.vel.x) * 1/60
		elif (!entity.get_node("Controller").is_mainstick_neutral()):
			entity.vel.x += sign(entity.get_node("Controller").mainstick.x) * accel * 1/60
	
	var after = entity.vel.x > target_vel_x
	if (before != after):
		entity.vel.x = target_vel_x

# Called when the animation finishes
# Returns a String of the State to change to
# Returns null if no change
func on_timeout(entity, animation):
	pass

# Called when landing on the ground
# Returns a String of the State to change to
# Returns null if no change
func hit_floor(entity, collision):
	pass

# Called when sliding off on the ground
# Returns a String of the State to change to
# Returns null if no change
func on_slide_off(entity):
	pass

# Called when hitting a ceiling
# Returns a String of the State to change to
# Returns null if no change
func hit_ceil(entity, collision):
	pass

# Called when hitting a wall
# Returns a String of the State to change to
# Returns null if no change
func hit_wall(entity, collision):
	pass