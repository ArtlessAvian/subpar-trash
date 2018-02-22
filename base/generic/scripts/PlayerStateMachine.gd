extends Node

var current

# The 'frame'th time something has run
var frame = -1

func _ready():
	current = self.get_child(0)
	current.propagate_call("enter", [$"..", null], true)
	pass

func run():
	
	frame += 1
	
	self.propagate_set_state(current, "try_transition", [$"..", frame])
	current.propagate_call("run", [$"..", frame], true)
	pass

func set_state(new_state):
	var old_state = current
	current.propagate_call("exit", [$"..", old_state], true)
	current = new_state
	current.propagate_call("enter", [$"..", new_state], true)
	
	frame = 0
	pass

func propagate_set_state(start, name, args = []):
	
	var result = null
	var trying = start
	
	result = trying.callv(name, args)
	while (trying.get_child_count() > 0 && result == null):
		trying = trying.get_child(0)
		if (trying.has_method(name)):
			result = trying.callv(name, args)
	
	if (result != null):
		self.set_state(self.get_node(result))
	
	## TODO: REMOVE THIS GARBAGE
	if (self.find_node(name, false)):
		printerr(name + " not found!!!!")
		