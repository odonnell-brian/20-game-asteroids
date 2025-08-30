class_name PlayerMovementComponent
extends Node2D

signal force_move_complete()

const DEFAULT_VELOCITY_LIMIT: float = 400.0
const FX_STEP_SCALAR: float = 4.0

@export_category("Dependencies")
@export var input_component: PlayerInputComponent

@export_category("Optional Dependencies")
@export var thruster_sprite: Node2D
@export var reverse_thruster_sprite: Node2D
@export var brake_sprite: Node2D

@export_category("Settings")
@export var rotation_degrees_per_second: float = 180.0
@export var acceleration: float = 500.0
@export var deceleration: float = 250.0
@export var max_velocity: Vector2 = Vector2(DEFAULT_VELOCITY_LIMIT, DEFAULT_VELOCITY_LIMIT)
@export var rotation_offset_degrees: float = 90.0

var enabled: bool = true
var move_vector: Vector2
var current_velocity: Vector2

func _ready() -> void:
	try_set_node_alpha(thruster_sprite, 0.0)
	try_set_node_alpha(reverse_thruster_sprite, 0.0)
	try_set_node_alpha(brake_sprite, 0.0)

func _physics_process(delta: float) -> void:
	if not enabled or not get_parent() is CharacterBody2D:
		return

	var parent: CharacterBody2D = get_parent() as CharacterBody2D
	var input_data: PlayerInputComponent.InputData = input_component.get_input_data()

	parent.rotate(deg_to_rad(input_data.rotation * rotation_degrees_per_second * delta))

	var new_velocity: Vector2 = calculate_new_velocity(input_data, delta, parent.global_rotation)
	current_velocity = new_velocity
	parent.velocity = current_velocity

	handle_vfx(input_data, delta)
	parent.move_and_slide()

func calculate_new_velocity(input_data: PlayerInputComponent.InputData, delta: float, node_rotation: float) -> Vector2:
	var new_velocity: Vector2 = current_velocity
	if input_data.brake:
		new_velocity = current_velocity.move_toward(Vector2.ZERO, delta * deceleration)
	elif input_data.thrust != 0.0:
		# Keeping this for records of what is going on behing the scenes of the rotated() call
		#var offset_rotation: float = parent.global_rotation - deg_to_rad(rotation_offset_degrees)
		#var move_vector: Vector2 = Vector2(cos(offset_rotation), sin(offset_rotation))
		move_vector = Vector2.UP.rotated(node_rotation)
		new_velocity = current_velocity + (move_vector * acceleration *  input_data.thrust * delta)
		new_velocity = new_velocity.clamp(-1 * max_velocity, max_velocity)

	return new_velocity

func handle_vfx(input_data: PlayerInputComponent.InputData, delta: float) -> void:
	modulate_node_alpha(thruster_sprite, max(0.0, input_data.thrust), delta)
	modulate_node_alpha(reverse_thruster_sprite, max(0.0, -1 * input_data.thrust), delta)
	modulate_node_alpha(brake_sprite, int(input_data.brake), delta)

func modulate_node_alpha(node: Node2D, target_value: float, delta: float) -> void:
	if node:
		node.modulate.a = move_toward(node.modulate.a, target_value, delta * FX_STEP_SCALAR)

func try_set_node_alpha(node: Node2D, alpha: float) -> void:
	if node:
		node.modulate.a = alpha

func get_velocity() -> Vector2:
	return current_velocity

func get_velocity_percent() -> Vector2:
	return Vector2(current_velocity.x / max_velocity.x, current_velocity.y / max_velocity.y)

func force_move_to(destination: Vector2, duration: float) -> void:
	enabled = false

	var thruster_tween_time: float = duration / 4
	var position_tween: Tween = create_tween()
	position_tween.tween_property(get_parent(), "global_position", destination, duration).from_current().set_ease(Tween.EASE_IN_OUT)
	position_tween.parallel().tween_property(thruster_sprite, "modulate:a", 1.0, thruster_tween_time).set_trans(Tween.TRANS_SINE)
	position_tween.parallel().tween_property(thruster_sprite, "modulate:a", 0.0, thruster_tween_time).set_delay(thruster_tween_time * 3)
	position_tween.tween_callback(on_force_move_complete).set_delay(0.5)

func on_force_move_complete() -> void:
	enabled = true
	force_move_complete.emit()
