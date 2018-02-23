extends Node

# Adds behavior that attacks should share
# Use when Tilt, Smash, Aerial, or Special does not match
# To get this data from the StateMachine, use current.find_node("PlayerStateAttack"),
# then access the properties as normal
# @author ArtlessAvian

export (Array, float) var damage
export (Array, float) var knockback
export (Array, float) var knockback_growth
export (Array, float) var angle


