extends Node


#_ready():
#	pass
#
#func enter(main, oldState):
#	pass
#
#func exit(main, newState):
#	pass
#
#func run(main, frame):
#	pass
#
# Returns a State to change to
# frame : integer
#	The amount of frames that ran before this.
#	EG: A 10 frame move should end if frame == 10
#func try_transition(main, frame):
#	pass
#
# Called when landing on the ground
#func on_land(main):
#	pass
#
# Called when hitting a ceiling
#func on_pineapple(main):
#	pass
#
# Called when hitting a wall
#func on_bonk(main):
#	pass	


export (String) var animationName
export (String) var onTimeout
export (int) var frameLength = -1

func enter(main, oldState):
	if (animationName != null):
		main.get_node("AnimationPlayer").play(animationName)

func try_transition(main, frame):
	if (frame > frameLength && frameLength != -1):
		return onTimeout
	pass
