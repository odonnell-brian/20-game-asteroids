extends Control

@export_category("Dependencies")
@export var score_label: Label
@export var lives_container: Container

@export_category("Settings")
@export_color_no_alpha var life_image_no_fade: Color = Color.WHITE
@export_color_no_alpha var life_image_fade: Color

func _ready() -> void:
	Globals.player_lives_changed.connect(on_player_lives_changed)

func _process(_delta: float) -> void:
	score_label.text = str(Globals.player_score)

func on_player_lives_changed(current_lives: int) -> void:
	var life_images: Array[Node] = lives_container.get_children()
	for i in range(0, life_images.size()):
		if life_images[i] is CanvasItem:
			life_images[i].modulate = life_image_fade if (i + 1) > current_lives else life_image_no_fade
