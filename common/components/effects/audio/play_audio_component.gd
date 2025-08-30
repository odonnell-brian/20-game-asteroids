extends FxComponent

@export_category("Dependencies")
@export var audio_player: AudioStreamPlayer2D

func do_fx() -> void:
	audio_player.finished.connect(on_audio_finished)
	audio_player.play()

func on_audio_finished() -> void:
	audio_player.finished.disconnect(on_audio_finished)
	effect_complete.emit()
