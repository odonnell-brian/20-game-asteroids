class_name PlayerInputComponent
extends Node2D

func get_input_data() -> InputData:
	var rotation_input: float = Input.get_axis("rotate_left", "rotate_right")
	var thrust_input: float = Input.get_axis("move_backward", "move_forward")
	var brake: bool = Input.is_action_pressed("brake")
	return InputData.new(rotation_input, thrust_input, brake)

class InputData:
	var rotation: float
	var thrust: float
	var brake: bool

	@warning_ignore_start("shadowed_variable")
	func _init(rotation: float, thrust: float, brake: bool) -> void:
		self.rotation = rotation
		self.thrust = thrust
		self.brake = brake
	@warning_ignore_restore("shadowed_variable")
