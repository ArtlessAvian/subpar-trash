extends "../GroundState.gd"

func on_timeout(entity, animation):
	return "Stand"

func get_data(box):
	return {"angle" : self.angle[box],
			"damage" : self.damage[box],
			"knockback" : self.knockback[box],
			"knockback_growth" : self.knockback_growth[box]}