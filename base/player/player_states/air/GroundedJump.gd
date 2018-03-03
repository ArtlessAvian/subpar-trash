extends "../AirState.gd"

func try_transition(entity, frame):
	if (entity.vel.y >= 0):
		return "Fall"
	
	return .try_transition(entity, frame)