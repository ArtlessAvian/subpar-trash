extends Node

export (float) var jump_height = 600
export (float) var initial_velocity = -1

#func _ready():
#	if (initial_velocity == -1):
#		initial_velocity = $PlayerStateAir/PlayerStateBase.stick_max_vel
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
	
	if (initial_velocity == -1):
		yield()
		initial_velocity = $PlayerStateAir/PlayerStateBase.stick_max_vel
	
	main.vel.x += main.get_node("Controller").mainstick.x * initial_velocity
	main.vel.x = clamp(main.vel.x, -$PlayerStateAir/PlayerStateBase.stick_max_vel, $PlayerStateAir/PlayerStateBase.stick_max_vel)

func run(main, frame):
	main.set_collision_mask_bit(0,
			main.get_node("Controller").mainstick.y < sqrt(2)/2)

func try_transition(main, frame):
	if (main.vel.y > 0):
		return "Fall"