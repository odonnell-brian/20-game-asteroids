class_name Player
extends CharacterBody2D

@export_category("Dependencies")
@export var health_component: HealthComponent

func _ready() -> void:
	health_component.health_depleted.connect(Globals.player_destroyed.emit)
