extends Node

var _ignore = null

func enter(main, old_state):
	_ignore = main.ground
	main.ground = null

func run(main, frame):
	main.set_collision_mask_bit(0,
			main.get_node("Controller").mainstick.y < sqrt(2)/2)

func on_land(main, collision):
	if (collision.collider == _ignore.collider):
		return null