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

# Called when sliding off on the ground
#func on_slide_off(main):
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
export (bool) var customAnimationHandling
export (String) var onTimeout
export (int) var frameLength = -1
export (float) var accel = 0
export (float) var friction = -1
export (float) var maxVelX = -1

func enter(main, oldState):
	if (animationName != null):
		main.get_node("AnimationPlayer").set_current_animation(animationName)
		main.get_node("AnimationPlayer").set_active(!customAnimationHandling)
	
	main.friction = self.friction
	main.maxVelX = self.maxVelX

func run(main, frame):
	if (main.get_node("Controller").is_mainstick_pointing(4)):
		main.accel.x -= accel
	elif (main.get_node("Controller").is_mainstick_pointing(0)):
		main.accel.x += accel

func try_transition(main, frame):
	if (frame > frameLength && frameLength != -1):
		return onTimeout
	pass

func on_slide_off(main):
	print("slid_off")
	return "GroundedJump"