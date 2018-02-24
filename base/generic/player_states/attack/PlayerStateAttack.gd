extends Node

# Adds behavior that attacks should share
# Use when Tilt, Smash, Aerial, or Special does not match
# To get this data from the StateMachine, use current.find_node("PlayerStateAttack"),
# then access the properties as normal
# @author ArtlessAvian
#
#export (Array, float) var damage
#export (Array, float) var knockback
#export (Array, float) var knockback_growth
#export (Array, float) var angle

func exit(main, new_state):
	yield()
	
	for child in main.get_node("Hitboxes").get_children():
		if (!child.disabled):
			printerr(String(main.get_path_to(self)) + " forgot to clear hitboxes!")
			child.disabled = true
