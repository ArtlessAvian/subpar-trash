extends "../AirState.gd"

func _ready():
	_airdodgeable = true

func enter(entity, new):
	if (entity.get_node("Controller").is_jump_pressed()):
		entity.vel.y = -1000;
	else:
		entity.vel.y = -600;
	
	.enter(entity, new)

func on_timeout(entity, frame):
	return "Fall"