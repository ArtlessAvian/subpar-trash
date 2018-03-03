extends "../AirState.gd"

export (float) var jump_height = 600

func _ready():
	_airdodgeable = true

func enter(entity, old):
	entity.double_jumps -= 1
	entity.vel.y = -jump_height
	.enter(entity, old)

func on_timeout(entity, frame):
	return "Fall"