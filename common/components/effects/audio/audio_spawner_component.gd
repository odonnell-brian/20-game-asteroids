class_name AudioSpawnerComponent
extends FxComponent

@export_category("Settings")
@export var audio_stream: AudioStream

func do_fx() -> void:
	var player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	player.stream = audio_stream
	player.finished.connect(player.queue_free)
	player.finished.connect(effect_complete.emit)
	Globals.game_world.add_level_child(player)
	player.play()
