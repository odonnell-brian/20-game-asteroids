class_name SimpleMovementComponent
extends Node2D

@export_category("Settings")
@export var speed: float = 100.0
@export var initial_direction: Vector2 = Vector2.RIGHT

var velocity_offset: Vector2 = Vector2.ZERO
var current_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = initial_direction.rotated(global_rotation)
	current_velocity = (speed * delta * move_vector) + velocity_offset
	get_parent().position += current_velocity
