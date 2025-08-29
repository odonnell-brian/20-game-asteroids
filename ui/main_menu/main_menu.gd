extends Control

@export_category("Dependencies")
@export var play_button: Button
@export var exit_button: Button

func _ready() -> void:
	play_button.pressed.connect(on_play_button)
	exit_button.pressed.connect(get_tree().quit)

func on_play_button() -> void:
	Globals.game_world.start_game()
	call_deferred("queue_free")
