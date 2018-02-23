extends Node

var dead_zoned = false

func enter(main, old_state):
	main.has_airdodged = true
	if (main.get_node("Controller").is_mainstick_neutral()):
		dead_zoned = true
		$PlayerStateAir.gravity = -1;
	else:
		main.vel = main.get_node("Controller").mainstick.normalized()
		main.vel *= 1000
		dead_zoned = false
		$PlayerStateAir.gravity = 0;
	_SUPER_TEMPORARY_GARBAGE = 0

# Change acceleration, velocity
var _SUPER_TEMPORARY_GARBAGE = 0

func run(main, frame):
	if (!dead_zoned):
		if (frame < 15):
			main.vel *= 0.95
		else:
			main.vel *= 0
	pass
	_SUPER_TEMPORARY_GARBAGE += 1

func on_land(main, collision):
	print(_SUPER_TEMPORARY_GARBAGE)