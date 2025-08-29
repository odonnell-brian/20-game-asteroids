class_name GameWorld
extends Node2D

var current_level_node: Node2D

func _ready() -> void:
	Globals.game_world = self
	Globals.player_destroyed.connect(on_player_destroyed)
	Globals.restart_game.connect(on_restart_game)

func start_game() -> void:
	instantiate_level()
	init_gui()
	get_tree().paused = false

func clear() -> void:
	if current_level_node:
		current_level_node.call_deferred("queue_free")

func instantiate_level() -> void:
	var level: PackedScene = load("res://levels/test_scene.tscn")
	var level_node: Node2D = level.instantiate() as Node2D
	add_child(level_node)
	current_level_node = level_node

func init_gui() -> void:
	var pause_menu: PackedScene = load("res://ui/pause_menu/pause_menu.tscn")
	Globals.gui_manager.call_deferred("add_child", pause_menu.instantiate())

	var game_over_scene: PackedScene = load("res://ui/game_over/game_over.tscn")
	Globals.gui_manager.call_deferred("add_child", game_over_scene.instantiate())

func add_level_child(node: Node) -> void:
	current_level_node.add_child(node)

func on_player_destroyed() -> void:
	get_tree().paused = true

func on_restart_game() -> void:
	clear()
	instantiate_level()
	get_tree().paused = false
