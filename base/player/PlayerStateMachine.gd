extends Node

var current

# The 'frame'th time something has run
var frame = -1

func _ready():
	current = self.get_child(0)
	self.fancy_propagate_call("enter", [$"..", null])

func run():
	frame += 1
	
	self.propagate_set_state("try_transition", [$"..", frame])
	self.fancy_propagate_call("run", [$"..", frame])

func set_state(new_state):
	var old_state = current
	self.fancy_propagate_call("exit", [$"..", old_state])
	current = new_state
	self.fancy_propagate_call("enter", [$"..", new_state])
	frame = 0
	pass

func fancy_propagate_call(name, args):
	var stack = []
	var trying = current
	
	while (true):
		var res = trying.callv(name, args)
		if (typeof(res) == TYPE_OBJECT && res is GDScriptFunctionState):
			stack.push_back(res)
		elif (res != null):
			return res
			
		if (trying.get_child_count() > 0):
			trying = trying.get_child(0)
		else:
			break
	
	while (stack.size() > 0):
		var thingy = stack.pop_front()
		var res = thingy.resume()
		if (res != null):
			return res

func propagate_set_state(name, args):
	var res = fancy_propagate_call(name, args)
	if (res != null):
		self.set_state(self.get_node(res))