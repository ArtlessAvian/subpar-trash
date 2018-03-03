extends "../GroundState.gd"

func _ready():
	pass

func on_timeout(entity, animation):
	return "Stand"
