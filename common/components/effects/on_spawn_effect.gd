class_name OnSpawnEffect
extends FxComponent

@export_category("Dependencies")
@export var effect: FxComponent

func _ready() -> void:
	effect.effect_complete.connect(effect_complete.emit)
	effect.do_fx()
