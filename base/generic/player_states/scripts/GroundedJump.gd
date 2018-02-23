extends Node

export (float) var full_hop = 900
export (float) var short_hop = 600

#func _ready():
#	var parent = self
#	var state_machine = null
#	while (state_machine == null):
#		parent = parent.get_parent()
#		state_machine = parent.find_node("PlayerStateMachine", false)
#
#	self.add_child(state_machine.get_node("GroundedJump").duplicate())

func enter(main, frame):
	main.ground = null
	if (main.get_node("Controller").is_mainstick_pointing(2) || main.get_node("Controller").is_jump_pressed()):
		main.vel.y = -full_hop
	else:
		main.vel.y = -short_hop
		
func run(main, frame):
	main.set_collision_mask_bit(0,
			main.get_node("Controller").mainstick.y < sqrt(2)/2)

func try_transition(main, frame):
	if (main.vel.y > 0):
		return "Fall"