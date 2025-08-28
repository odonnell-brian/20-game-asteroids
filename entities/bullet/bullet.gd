class_name Bullet
extends Node2D

@onready var movement_component: SimpleMovementComponent = $SimpleMovementComponent

func set_parent_velocity(velocity: Vector2) -> void:
	print(velocity)
	movement_component.parent_velocity = velocity
