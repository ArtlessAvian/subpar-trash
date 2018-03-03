extends Node

func _ready():
	for child in get_children():
		child.find_node("PlayerGeneric").set_physics_process(false)

func _physics_process(delta):
	# The way this lines up is really nice, actually
	for child in get_children():
		child.find_node("PlayerGeneric").prepare()
	for child in get_children():
		child.find_node("PlayerGeneric").run(delta)
	for child in get_children():
		child.find_node("PlayerGeneric").move(delta)
	for child in get_children():
		child.find_node("PlayerGeneric").check_hit()
	for child in get_children():
		child.find_node("PlayerGeneric").get_hit()
	for child in get_children():
		child.find_node("PlayerGeneric").done()