extends "../GroundState.gd"

export (Array, float) var angle = [45]
export (Array, float) var damage = [4]
export (Array, float) var knockback = [3]
export (Array, float) var knockback_growth = [6]

func on_timeout(entity, animation):
	return "Stand"