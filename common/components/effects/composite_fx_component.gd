class_name CompositeFxComponent
extends FxComponent

@export_category("Dependencies")
@export var effects: Array[FxComponent]

var fx_complete: int = 0

func _ready() -> void:
	for fx in effects:
		fx.effect_complete.connect(on_effect_complete)

func do_fx() -> void:
	for fx in effects:
		fx.do_fx()

func on_effect_complete() -> void:
	fx_complete += 1

	if fx_complete >= effects.size():
		fx_complete = 0
		effect_complete.emit()
