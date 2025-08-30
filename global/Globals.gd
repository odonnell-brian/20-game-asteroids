extends Node

@warning_ignore("unused_signal")
signal level_loaded()

@warning_ignore("unused_signal")
signal start_game()

@warning_ignore("unused_signal")
signal player_ready()

@warning_ignore("unused_signal")
signal player_lives_changed(current_lives: int)

@warning_ignore("unused_signal")
signal player_destroyed()

@warning_ignore("unused_signal")
signal restart_game()

var scene_manager: SceneManager
var game_world: GameWorld
var gui_manager: GuiManager

var player_data: Player.PlayerData
var player_score: int = 0

@onready var viewport_size: Vector2 = get_viewport().size
