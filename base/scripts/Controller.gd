extends Node2D

export (int) var device = -2

var deadzone = 0.2
var edges = 0.7
var angleLeeway = 0

var lastNeutral = 0
var mainstick = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

var bangAnimation = 0

func _process(delta):
	$MainStickZone/MainStick.position = mainstick * $MainStickZone.texture.get_width()/2
	if (self.is_mainstick_banged()):
		$MainStickZone.modulate = ColorN("RED");
	elif (lastNeutral == 0):
		$MainStickZone.modulate = ColorN("BLUE");
	else:
		$MainStickZone.modulate = ColorN("WHITE");
	
	$Attack.rotate(int(self.is_attack_pressed()))
	$Special.rotate(int(self.is_special_pressed()))
	if (self.is_jump_pressed()):
		$Jump.position.x += randf() * 10 - 5

func _physics_process(delta):
	
	if (device == -1):
		mainstick.x = 0
		mainstick.y = 0
		
		mainstick.x += int(Input.is_action_pressed("kb_right"))
		mainstick.x -= int(Input.is_action_pressed("kb_left"))
		mainstick.y -= int(Input.is_action_pressed("kb_up"))
		mainstick.y += int(Input.is_action_pressed("kb_down"))
		
		
	elif (device >= 0):
		mainstick.x = Input.get_joy_axis(device, 0)
		mainstick.y = Input.get_joy_axis(device, 1)
	
	if (mainstick.length_squared() <  deadzone * deadzone):
		lastNeutral = 0
	else:
		lastNeutral += 1

func is_mainstick_banged():
	if (device == -1 && Input.is_action_pressed("kb_bang")):
		return true;
	
	if (lastNeutral < 6 && mainstick.length_squared() > edges * edges):
		return true;
	
	return false;

func is_mainstick_neutral():
	return lastNeutral == 0

const dirs = [
	Vector2(1, 0),
	Vector2(1, -1),
	Vector2(0, -1),
	Vector2(-1, -1),
	Vector2(-1, 0), 
	Vector2(-1, 1), 
	Vector2(0, 1), 
	Vector2(1, 1), 
]
func is_mainstick_pointing(angleEighths):
	if (is_mainstick_neutral()): return false
	return abs(mainstick.angle_to(dirs[angleEighths])) < PI/4 + angleLeeway

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
		return Input.is_joy_button_pressed(device, JOY_BUTTON_3) || Input.is_joy_button_pressed(device, JOY_BUTTON_9)
	return false