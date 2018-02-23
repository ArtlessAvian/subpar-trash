extends Node

# Interface.

onready var forward_to = self.get_child(0) if self.get_child_count() > 0 else null

# Called on any type of enter
func enter(main, old_state):
	forward_to.enter(main, old_state)

# Called on any type of exit
func exit(main, new_state):
	forward_to.enter(main, new_state)

# Change velocity, alter things in the tree
func run(main, frame):
	forward_to.run(main, frame)

# Called every frame, before run
# Returns a State to change to
# Returns null if no change
# frame : integer
#	The amount of frames that ran before this.
#	EG: A 10 frame move should end if frame == 10
func try_transition(main, frame):
	forward_to.try_transition(main, frame)

# Called when landing on the ground
# Returns a State to change to
# Returns null if no change
func on_land(main, collision):
	forward_to.on_land(main, collision)

# Called when sliding off on the ground
# Returns a State to change to
# Returns null if no change
func on_slide_off(main, collision):
	forward_to.on_slide_off(main, collision)

# Called when hitting a ceiling
# Returns a State to change to
# Returns null if no change
func on_pineapple(main, collision):
	forward_to.on_pineapple(main, collision)

# Called when hitting a wall
# Returns a State to change to
# Returns null if no change
func on_bonk(main, collision):
	forward_to.on_pineapple(main. collision)