extends Node

@warning_ignore("unused_signal")
signal player_destroyed()

@warning_ignore("unused_signal")
signal restart_game()

var scene_manager: SceneManager
var game_world: GameWorld
var gui_manager: GuiManager
