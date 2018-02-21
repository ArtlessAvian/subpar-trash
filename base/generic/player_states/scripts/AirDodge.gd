extends Node

var dead_zoned = false

func enter(main, old_state):
	if (main.get_node("Controller").is_mainstick_neutral()):
		dead_zoned = true
		$PlayerStateAir.gravity = -1;
	else:
		main.vel = main.get_node("Controller").mainstick.normalized()
		main.vel *= 1000
		dead_zoned = false
		$PlayerStateAir.gravity = 0;

# Change acceleration, velocity
func run(main, frame):
	if (!dead_zoned):
		main.vel *= 0.9
	pass