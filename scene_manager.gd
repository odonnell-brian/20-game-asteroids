class_name SceneManager
extends Node

const MAIN_MENU: PackedScene = preload("res://ui/main_menu/main_menu.tscn")

@onready var world_node: GameWorld = $World
@onready var gui_node: GuiManager = $GUI

func _ready() -> void:
	Globals.scene_manager = self
	switch_to_main_menu()

func switch_to_main_menu() -> void:
	world_node.clear()
	gui_node.clear()
	gui_node.add_child(MAIN_MENU.instantiate())
