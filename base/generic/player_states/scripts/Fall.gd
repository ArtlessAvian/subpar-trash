extends Node


func run(main, frame):
	

	
	main.set_collision_mask_bit(0,
			main.get_node("Controller").mainstick.y < sqrt(2)/2)
