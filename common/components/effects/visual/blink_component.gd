class_name BlinkComponent
extends FxComponent

@export_category("Dependencies")
@export var target: Node2D

@export_category("Settings")
@export var duration: float = 2.0
@export var interval: float = 0.1

var run: bool = false
var time_elapsed: float = 0.0
var blink_count: int = 0

func _process(delta: float) -> void:
	if not run:
		return

	time_elapsed += delta

	if time_elapsed >= duration:
		reset()
	elif time_elapsed >= (interval * blink_count):
		blink_count += 1
		target.visible = !target.visible

func reset() -> void:
	target.visible = true
	run = false
	time_elapsed = 0.0
	blink_count = 0
	effect_complete.emit()

func do_fx() -> void:
	run = true
