extends Node

func enter(entity, old):
	pass

func exit(entity, new):
	pass

func try_transition(entity, new):
	pass

func run(entity, delta):
	pass

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