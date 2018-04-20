extends Node2D

var angle
var damage
var knockback
var knockback_growth

func get_data():
	return {"angle" : self.angle,
			"damage" : self.damage,
			"knockback" : self.knockback,
			"knockback_growth" : self.knockback_growth}