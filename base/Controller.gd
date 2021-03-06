extends Node2D

export (int) var device = -2

var deadzone = 0.2
var edges = 0.7
var angle_leeway = PI/4

var last_neutral = 0
var mainstick = Vector2()
var lastMainstick = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	$MainStickZone/MainStick.position = mainstick * $MainStickZone.texture.get_width()/2
	if (self.is_mainstick_banged()):
		$MainStickZone.modulate = ColorN("RED");
	elif (last_neutral == 0):
		$MainStickZone.modulate = ColorN("BLUE");
	else:
		$MainStickZone.modulate = ColorN("WHITE");
	
	$Attack.rotate(int(self.is_attack_pressed()))
	$Special.rotate(int(self.is_special_pressed()))
	if (self.is_jump_pressed()):
		$Jump.position.x += randf() * 10 - 5

func _physics_process(delta):
	lastMainstick = mainstick
	
	if (device == -1):
		var temp = Vector2()

		temp.x += int(Input.is_action_pressed("kb_right"))
		temp.x -= int(Input.is_action_pressed("kb_left"))
		temp.y -= int(Input.is_action_pressed("kb_up"))
		temp.y += int(Input.is_action_pressed("kb_down"))
		temp = temp.normalized()
		mainstick = mainstick.linear_interpolate(temp, 1)
		
	elif (device >= 0):
		mainstick.x = Input.get_joy_axis(device, 0)
		mainstick.y = Input.get_joy_axis(device, 1)
		for dir in range(8):
			if (is_mainstick_pointing(dir, PI/16)):
				mainstick = DIRS[dir] * mainstick.length()
				break
		if (mainstick.length_squared() > edges * edges):
			mainstick = mainstick.normalized()
	
	if (mainstick.length_squared() < deadzone * deadzone):
		last_neutral = 0
	elif (mainstick.dot(lastMainstick) < 0 && 
			abs(sin(mainstick.angle_to_point(lastMainstick)) * mainstick.length()) < deadzone/2):
		last_neutral = 0
	else:
		last_neutral += 1

func is_mainstick_banged():
	if (device == -1):
		return Input.is_action_just_pressed("kb_bang");
	
	if (last_neutral < 6 && mainstick.length_squared() > edges * edges):
		return true;
	
	return false;

func is_mainstick_neutral():
	return last_neutral == 0

const DIRS = [
	Vector2(1, 0),
	Vector2(1, -1),
	Vector2(0, -1),
	Vector2(-1, -1),
	Vector2(-1, 0), 
	Vector2(-1, 1), 
	Vector2(0, 1), 
	Vector2(1, 1), 
]
func is_mainstick_pointing(angleEighths, within = PI/2 + angle_leeway):
	if (is_mainstick_neutral()): return false
	return abs(mainstick.angle_to(DIRS[angleEighths])) < within/2

func is_attack_pressed():
	if (device == -1):
		return Input.is_action_pressed("kb_attack")
	elif (device >= 0):
		return Input.is_joy_button_pressed(device, JOY_BUTTON_0)
	return false

func is_special_pressed():
	if (device == -1):
		return Input.is_action_pressed("kb_special")
	elif (device >= 0):
		return Input.is_joy_button_pressed(device, JOY_BUTTON_1)
	return false

func is_jump_pressed():
	if (device == -1):
		return Input.is_action_pressed("kb_jump")
	elif (device >= 0):
		return (Input.is_joy_button_pressed(device, JOY_BUTTON_3) ||
				Input.is_joy_button_pressed(device, JOY_BUTTON_9))
	return false

func is_shield_pressed():
	if (device == -1):
		return Input.is_action_pressed("kb_shield")
	elif (device >= 0):
		return (Input.get_joy_axis(device, JOY_AXIS_6) > 0.5 ||
				Input.get_joy_axis(device, JOY_AXIS_7) > 0.5)
	return false