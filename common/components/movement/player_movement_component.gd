class_name PlayerMovementComponent
extends Node2D

const DEFAULT_VELOCITY_LIMIT: float = 400.0

@export_category("Dependencies")
@export var input_component: PlayerInputComponent

@export_category("Settings")
@export var rotation_degrees_per_second: float = 180.0
@export var acceleration: float = 500.0
@export var deceleration: float = 250.0
@export var max_velocity: Vector2 = Vector2(DEFAULT_VELOCITY_LIMIT, DEFAULT_VELOCITY_LIMIT)
@export var min_velocity: Vector2 = Vector2(-DEFAULT_VELOCITY_LIMIT, -DEFAULT_VELOCITY_LIMIT)
@export var rotation_offset_degrees: float = 90.0

var move_vector: Vector2

func _physics_process(delta: float) -> void:
	if not get_parent() is CharacterBody2D:
		return

	var parent: CharacterBody2D = get_parent() as CharacterBody2D
	var input_data: PlayerInputComponent.InputData = input_component.get_input_data()

	parent.rotate(deg_to_rad(input_data.rotation * rotation_degrees_per_second * delta))

	if input_data.brake:
		parent.velocity = parent.velocity.move_toward(Vector2.ZERO, delta * deceleration)
	elif input_data.thrust != 0.0:
		# Keeping this for records of what is going on behing the scenes of the rotated() call
		#var offset_rotation: float = parent.global_rotation - deg_to_rad(rotation_offset_degrees)
		#var move_vector: Vector2 = Vector2(cos(offset_rotation), sin(offset_rotation))
		move_vector = Vector2.UP.rotated(parent.global_rotation)
		parent.velocity += (move_vector * acceleration *  input_data.thrust * delta)
		parent.velocity = parent.velocity.clamp(min_velocity, max_velocity)

	parent.move_and_slide()

func get_velocity() -> Vector2:
	return (get_parent() as CharacterBody2D).velocity
