class_name DestroyOffScreenComponent
extends Node2D

@export_category("Dependencies")
@export var visibility_notifier: VisibleOnScreenNotifier2D

func _ready() -> void:
	visibility_notifier.screen_exited.connect(get_parent().queue_free)
