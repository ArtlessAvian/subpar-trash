extends Node

## Called on any type of enter
#func enter(main, old_state):
#	pass
#
## Called on any type of exit
#func exit(main, new_state):
#	pass
#
## Change acceleration, velocity
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

export (String) var animation_name
export (bool) var custom_animation_handling = false
export (String) var on_timeout
export (int, -1, 600) var frame_length = -1
export (float, 0, 1e4) var accel = 0
#export (float, -1, 1e4) var friction = -1
var friction = -1

export (float, 0, 1e4) var stick_max_vel = 0
var lastRunMaxed
var target_vel_x = 0 

func enter(main, oldState):
	if (animation_name != null):
		main.get_node("AnimationPlayer").set_current_animation(animation_name)
		main.get_node("AnimationPlayer").set_active(!custom_animation_handling)
	
	if (friction == -1):
		self.friction = main.default_friction

func run(main, frame):
	if (stick_max_vel > 0):
		target_vel_x = main.get_node("Controller").mainstick.x * stick_max_vel
	
	if (abs(main.vel.x - target_vel_x) < 10):
		main.vel.x = target_vel_x
	else:		
		if (target_vel_x < main.vel.x && main.get_node("Controller").is_mainstick_pointing(4)):
			main.accel.x -= accel
		elif (main.vel.x < target_vel_x && main.get_node("Controller").is_mainstick_pointing(0)):
			main.accel.x += accel
		
		if (abs(main.vel.x) > abs(target_vel_x) && main.vel.x * target_vel_x >= 0):
			main.accel.x -= self.friction * sign(main.vel.x)

func try_transition(main, frame):
	if (frame > frame_length && frame_length != -1):
		return on_timeout
	pass

func on_slide_off(main):
	print("slid_off")
	return "GroundedJump"