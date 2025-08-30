class_name PlayAnimationEffect
extends FxComponent

@export_category("Dependencies")
@export var animation_player: AnimationPlayer

@export_category("Settings")
@export var animation_name: String

func do_fx() -> void:
	animation_player.animation_finished.connect(on_animation_finished)
	animation_player.play(animation_name)

func on_animation_finished(anim_name: String) -> void:
	if animation_name == anim_name:
		effect_complete.emit()
		animation_player.animation_finished.disconnect(on_animation_finished)
