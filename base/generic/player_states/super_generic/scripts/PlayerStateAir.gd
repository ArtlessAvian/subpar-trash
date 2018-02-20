extends Node

export (String) var onLand = "Stand"
export (float) var altGravity

func run(main, frame):
	main.accel.y += main.baseGravity
	pass

func on_land(main):
	return onLand