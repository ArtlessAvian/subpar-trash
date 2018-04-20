extends "EntityState.gd"

var current

var frame = 0

func _ready():
	for child in self.get_children():
		print(child.name)
	pass

func try_transition(entity, ignore_me):
	var result = current.try_transition(entity, frame)
	self.set_state(result)
	return result
	
func run(entity, ignore_me, delta):
	if (!$AnimationPlayer.is_playing()):
		self.on_timeout(entity, $AnimationPlayer.assigned_animation)
	else:
		$AnimationPlayer.advance(delta)
		pass
	
	self.try_transition(entity, frame)
	current.run(entity, frame, delta)
	frame += 1;

func set_state(string):
	if (string != null):
		var state = self.find_node("*" + string)
		if (state != null):
			if (current != null):
#				print(current.name + " --> " + state.name)
				current.exit($"..", state)
			state.enter($"..", current)
			current = state
			frame = 0
			
			if (state.queue_animation):
				$AnimationPlayer.queue(string)
			elif ($AnimationPlayer.is_playing()):
				# Skip to the end, when the animation should reset
				$AnimationPlayer.seek($AnimationPlayer.current_animation_length, true)
			if ($AnimationPlayer.has_animation(string)):
				$AnimationPlayer.play(string)
			else:
				$AnimationPlayer.play("Stand")
			$AnimationPlayer.playback_active = false
		
		else:
			printerr(string + " not found!!")

func on_timeout(entity, animation):
	var result = current.on_timeout(entity, animation)
	self.set_state(result)
	return result

func hit_floor(entity, collision):
	var result = current.hit_floor(entity, collision)
	self.set_state(result)
	return result

func on_slide_off(entity):
	var result = current.on_slide_off(entity)
	self.set_state(result)
	return result

func hit_ceiling(entity, collision):
	var result = current.hit_ceiling(entity, collision)
	self.set_state(result)
	return result
	
func hit_wall(entity, collision):
	var result = current.hit_wall(entity, collision)
	self.set_state(result)
	return result