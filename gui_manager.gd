class_name GuiManager
extends Control

func _ready() -> void:
	Globals.gui_manager = self

func clear() -> void:
	for child in get_children():
		child.call_deferred("queue_free")
