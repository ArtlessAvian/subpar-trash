extends Node

var trajectory = Vector2(0, -800)

func enter(main, old_state):
	var angle = trajectory.angle_to(main.get_node("Controller").mainstick)
	angle = clamp(angle, -PI/90, PI/90)
	main.vel = trajectory.rotated(angle)
	pass
#
## Called on any type of exit
#func exit(main, new_state):
#	pass
#
## Change velocity, alter things in the tree
#func run(main, frame):
#	pass
#
## Called every frame, before run
## Returns a State to change to
## Returns null if no change
## frame : integer
##	The amount of frames that ran before this.
##	EG: A 10 frame move should end if frame == 10
#func try_transition(main, frame):
#	pass
#
## Called when landing on the ground
## Returns a State to change to
## Returns null if no change
#func on_land(main, collision):
#	pass
#
## Called when sliding off on the ground
## Returns a State to change to
## Returns null if no change
#func on_slide_off(main, collision):
#	pass
#
## Called when hitting a ceiling
## Returns a State to change to
## Returns null if no change
#func on_pineapple(main, collision):
#	pass
#
## Called when hitting a wall
## Returns a State to change to
## Returns null if no change
#func on_bonk(main, collision):
#	pass