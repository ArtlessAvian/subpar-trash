extends Node

export (float) var jump_height = 600

#func _ready():
#	var parent = self
#	var state_machine = null
#	while (state_machine == null):
#		parent = parent.get_parent()
#		state_machine = parent.find_node("PlayerStateMachine", false)
#
#	self.add_child(state_machine.get_node("GroundedJump").duplicate())

func enter(main, oldState):
	main.vel.y = -jump_height
	main.double_jumps -= 1