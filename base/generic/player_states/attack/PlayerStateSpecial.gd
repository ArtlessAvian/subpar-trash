extends Node

# Adds behavior that Special Attack states should share
# Handles the state's persistence even when landing/sliding_off
# @author ArtlessAvian

onready var _ground_state = $PlayerStateAttack/PlayerStateGround
onready var _air_state = $PlayerStateAttack/PlayerStateAir

func enter(main, old_state):
	if (old_state.find_node("PlayerStateAir")):
		self.move_child(_air_state, 0)
	else:
		self.move_child(_ground_state, 0)

func on_land(main, collision):
	_air_state.exit(main, _ground_state)
	self.move_child(_ground_state, 0)
	_ground_state.enter(main, _air_state)	

func on_slide_off(main, collision):
	_ground_state.exit(main, _air_state)
	self.move_child(_air_state, 0)
	_air_state.enter(main, _ground_state)