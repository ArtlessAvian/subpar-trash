extends Node

var current

# The 'frame'th time something has run
var frame = -1

func _ready():
	current = self.get_child(0)
	current.enter($"..", null)

func run():
	frame += 1
	
	var result = current.try_transition($"..", frame)
	if (result != null):
		self.set_state(self.get_node(result))
	
	current.run($"..", frame)

func set_state(new_state):
	var old_state = current
	current.exit($"..", old_state)
	current = new_state
	current.enter($"..", new_state)
	frame = 0