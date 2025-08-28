class_name Asteroid
extends Node2D

func _ready() -> void:
	global_rotation = deg_to_rad(randi_range(0, 360))
	print(global_rotation)
