extends Control

@export_category("Dependencies")
@export var restart_button: Button
@export var main_menu_button: Button
@export var exit_button: Button

func _ready() -> void:
	hide()

	restart_button.pressed.connect(on_restart_pressed)
	exit_button.pressed.connect(get_tree().quit)
	main_menu_button.pressed.connect(Globals.scene_manager.switch_to_main_menu)
	Globals.player_destroyed.connect(show)

func on_restart_pressed() -> void:
	Globals.restart_game.emit()
	hide()
