class_name BackgroundController
extends Node2D

@export_category("Dependencies")
@export var parallax: Parallax2D

@export_category("Settings")
@export var max_scroll_speed:Vector2 = Vector2(75, 75)

func _process(_delta: float) -> void:
	var x_velocity = max_scroll_speed.x * Globals.player_data.velocity_percent.x
	var y_velocity = max_scroll_speed.y * Globals.player_data.velocity_percent.y
	parallax.autoscroll = Vector2(x_velocity, y_velocity) * -1
