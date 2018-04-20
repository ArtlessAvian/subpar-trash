extends "../EntityAbstract.gd"

export (float) var base_friction = 1200
export (float) var base_max_vel_y = 1200
export (float) var fast_fall = 1200
export (float) var base_gravity = 1200
export (float) var base_drift_accel = 1200
export (float) var base_drift_speed = 400
export (int) var max_double_jumps = 2

export (int, 0, 9) var team = 0

var percent = 0
var double_jumps = max_double_jumps
var has_airdodged = false
var facing_left = false
var max_vel_y = base_max_vel_y

func _ready():
	$StateMachine.set_state("GroundedJump")

	self.move_and_slide(Vector2())
	$Hitboxes.set_collision_layer_bit(10 + team, true)
	$Hurtboxes.set_collision_mask_bit(10 + team, false)
	for hitbox in $Hitboxes.get_children():
		hitbox.shape = hitbox.shape.duplicate()
		hitbox.disabled = true
	for hurtbox in $Hurtboxes.get_children():
		hurtbox.shape = hurtbox.shape.duplicate()
	pass

#---------------------------------------

var _hit_response = null
var _inside_hitboxes = {}

func check_hit():
#	print(_inside_hitboxes)
	for element in _inside_hitboxes:
		
		var results = element.get_parent().get_hit_data(_inside_hitboxes[element])
		
		_hit_response = "Launch"
		percent += results.damage
		vel *= 0
		vel.x = results.knockback + results.knockback_growth * percent
		vel = vel.rotated(-results.angle * PI/180)
		if (element.get_parent().global_position.x > self.global_position.x):
			vel.x *= -1
			print("reversed")
		
		_inside_hitboxes.erase(element)
		# Modify the launch, i guess

func get_hit():
	if (_hit_response != null):
		$StateMachine.set_state(_hit_response)
	_hit_response = null
	pass

func get_hit_data(box):
	return $StateMachine.current.get_data(box)

# higher numbers get priority
func _on_Hurtboxes_area_shape_entered(area_id, area, area_shape, self_shape):
	print("oof")
	_inside_hitboxes[area] = area_shape

func _on_Hurtboxes_area_shape_exited(area_id, area, area_shape, self_shape):
	_inside_hitboxes.erase(area)
