class_name SimpleMovementComponent
extends Node2D

@export_category("Settings")
@export var speed: float = 100.0

var velocity_offset: Vector2 = Vector2.ZERO
var current_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = Vector2.UP.rotated(global_rotation)
	current_velocity = (speed * delta * move_vector) + velocity_offset
	get_parent().position += current_velocity
