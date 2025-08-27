class_name ScreenWrapComponent
extends Node2D

func _physics_process(_delta: float) -> void:
	if not get_parent() is Node2D:
		return

	var parent: Node2D = get_parent() as Node2D
	parent.global_position.x = wrap_value(parent.global_position.x, 0, get_viewport().size.x)
	parent.global_position.y = wrap_value(parent.global_position.y, 0, get_viewport().size.y)

func wrap_value(value: float, min_val: float, max_val: float):
	if value < min_val:
		value += max_val
	elif value > max_val:
		value = min_val

	return value
