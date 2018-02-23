extends Node

# This node is the endpoint for a chain of decorators.
# A lot of this class could be implemented with even more decorators,
# but that would probably be a bad idea.
# @author ArtlessAvian

# Treat and refer to an entire chain of decorators as a state
# When creating more decorators, it is better for some properties of the decorator
# to be able to be disabled, rather than writing seperate decorators.
# For example, it is better to have the Ground state be in charge of
# if one can attack or not, rather than add a GroundAttackable decorator
# to a state.
# That said, try to avoid "God Classes" that do everything
# This class is a borderline god class.


### Interface. Maybe I should write an actual class to extend.
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

export (int, -1, 120) var frame_length = -1
export (String) var timeout_state
export (int, "Nothing", "Deflect", "Stop") var on_bonk
export (String) var bonk_state
export (int, "Nothing", "Deflect", "Stop") var on_pineapple = 2
export (String) var pineapple_state

export (float, -1, 1e4) var accel = 0
#export (float, -1, 1e4) var friction = -1
var friction = -1

export (float, -1, 1e4) var stick_max_vel = 0
var target_vel_x = 0 

func enter(main, oldState):
	if (animation_name != null && main.get_node("AnimationPlayer").has_animation(animation_name)):
		main.get_node("AnimationPlayer").set_current_animation(animation_name)
		main.get_node("AnimationPlayer").set_active(!custom_animation_handling)
	
	if (friction == -1):
		self.friction = main.default_friction
	
	if (accel == -1):
		printerr(main.get_path_to(self) + " did not handle acceleration!")
	
	if (stick_max_vel == -1):
		printerr(main.get_path_to(self) + " did not handle stick_max_velocity!")


func exit(main, newState):
	if (animation_name != null):
		if (main.get_node("AnimationPlayer").get_animation(
				main.get_node("AnimationPlayer").assigned_animation
				).loop):
			main.get_node("AnimationPlayer").seek(0)
		else:
			main.get_node("AnimationPlayer").advance(1e5)
		
		
		for child in main.get_node("Hitboxes").get_children():
			if (!child.disabled):
				printerr(String(main.get_path_to(self)) + " forgot to clear hitboxes!")
	pass

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
	if (frame_length != -1 && frame > frame_length):
		if (timeout_state == null):
			printerr("No Timeout State in " + main.get_node("PlayerStateMachine").current.name)
		return timeout_state
	pass

func on_pineapple(main, collision):
	match(on_pineapple):
		1:
			var sub = main.vel.length() * cos(main.vel.angle_to(collision.normal))
			main.vel -= sub * collision.normal
			print (sub * collision.normal)
			print (main.vel)
		2:
			main.vel *= 0
	if (pineapple_state != null):
		return pineapple_state

func on_bonk(main, collision):
	match(on_bonk):
		1:
			var sub = main.vel.length() * cos(main.vel.angle_to(collision.normal))
			main.vel -= sub * collision.normal
			print (sub * collision.normal)
			print (main.vel)
		2:
			main.vel *= 0
	if (bonk_state != null):
		return bonk_state