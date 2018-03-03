extends "EntityState.gd"

var current

var frame = 0

func _ready():
	for child in self.get_children():
		print(child.name)
	pass

func try_transition(entity, frame):
	var result = current.try_transition(entity, frame)
	self.set_state(result)
	return result
	
func run(entity, delta):
	if (!$AnimationPlayer.is_playing()):
		self.on_timeout(entity, $AnimationPlayer.assigned_animation)
	else:
		$AnimationPlayer.advance(delta)
		pass
	
	self.try_transition(entity, 0)
	current.run(entity, delta)
	frame += 1;

func set_state(string):
	if (string != null):
		var state = self.find_node("*" + string)
		if (state != null):
			if (current != null):
				print(current.name + " --> " + state.name)
				current.exit($"..", state)
			state.enter($"..", current)
			current = state
			frame = 0
			
			if (state.queue_animation):
				$AnimationPlayer.queue(string)
			elif ($AnimationPlayer.is_playing()):
				# Skip to the end, when the animation should reset
				$AnimationPlayer.seek($AnimationPlayer.current_animation_length, true)
			$AnimationPlayer.play(string)
			$AnimationPlayer.playback_active = false
		
		else:
			printerr(string + " not found!!")

func on_timeout(entity, animation):
	var result = current.on_timeout(entity, animation)
	self.set_state(result)
	return result

func hit_floor(entity, collision):
	print("ay")
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