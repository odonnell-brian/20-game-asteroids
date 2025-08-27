class_name PlayerMovementComponent
extends Node2D

const DEFAULT_VELOCITY_LIMIT: float = 400.0

@export var rotation_degrees_per_second: float = 180.0
@export var acceleration: float = 500.0
@export var max_velocity: Vector2 = Vector2(DEFAULT_VELOCITY_LIMIT, DEFAULT_VELOCITY_LIMIT)
@export var min_velocity: Vector2 = Vector2(-DEFAULT_VELOCITY_LIMIT, -DEFAULT_VELOCITY_LIMIT)
@export var rotation_offset_degrees: float = 90.0

func _physics_process(delta: float) -> void:
	if not get_parent() is CharacterBody2D:
		return

	var parent: CharacterBody2D = get_parent() as CharacterBody2D

	var rotation_input: float = Input.get_axis("rotate_left", "rotate_right")
	var thrust_input: float = Input.get_axis("move_backward", "move_forward")

	parent.global_rotation += deg_to_rad(rotation_input * rotation_degrees_per_second * delta)

	if Input.is_action_pressed("brake"):
		parent.velocity = parent.velocity.move_toward(Vector2.ZERO, delta * acceleration)
	elif thrust_input != 0.0:
		var offset_rotation: float = parent.global_rotation - deg_to_rad(rotation_offset_degrees)
		var move_vector: Vector2 = Vector2(cos(offset_rotation), sin(offset_rotation))
		parent.velocity += (move_vector * acceleration * thrust_input * delta)
		parent.velocity = parent.velocity.clamp(min_velocity, max_velocity)

	parent.move_and_slide()
