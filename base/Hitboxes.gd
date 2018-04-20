extends Area2D

func _ready():
	pass

func set_data(angle, damage, knockback, knockback_growth, offset = 0):
	set_angle(angle, offset)
	set_damage(damage, offset)
	set_knockback(knockback, offset)
	set_knockback_growth(knockback_growth, offset)

func set_angle(angle, offset = 0):
	for i in range(offset, angle.size + offset):
		self.get_child(i).set_angle(angle[i])

func set_damage(damage, offset = 0):
	for i in range(offset, damage.size + offset):
		self.get_child(i).set_damage(damage[i])

func set_knockback(knockback, offset = 0):
	for i in range(offset, knockback.size + offset):
		self.get_child(i).set_knockback(knockback[i])

func set_knockback_growth(knockback_growth, offset = 0):
	for i in range(offset, knockback_growth.size + offset):
		self.get_child(i).set_knockback_growth(knockback_growth[i])

func get_data(box):
	return self.get_child(box)