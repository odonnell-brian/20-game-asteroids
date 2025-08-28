class_name Bullet
extends Node2D

@onready var movement_component: SimpleMovementComponent = $SimpleMovementComponent

func set_parent_velocity(velocity: Vector2) -> void:
	movement_component.velocity_offset = velocity
