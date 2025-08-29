extends Control

@export_category("Dependencies")
@export var score_label: Label
@export var restart_button: Button
@export var main_menu_button: Button
@export var exit_button: Button

func _ready() -> void:
	hide()

	restart_button.pressed.connect(on_restart_pressed)
	exit_button.pressed.connect(get_tree().quit)
	main_menu_button.pressed.connect(Globals.scene_manager.switch_to_main_menu)
	Globals.player_destroyed.connect(on_player_destroyed)

func _process(_delta: float) -> void:
	score_label.text = str(Globals.player_score)

func on_player_destroyed() -> void:
	show()

func on_restart_pressed() -> void:
	Globals.restart_game.emit()
	hide()
