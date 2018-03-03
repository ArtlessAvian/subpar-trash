extends "../GroundState.gd"

func exit(entity, new):
	if (entity.get_node("Controller").is_jump_pressed()):
		entity.vel.y = -800;
	else:
		entity.vel.y = -600;
	
	.exit(entity, new)

func on_timeout(entity, animation):
	return "GroundedJump"