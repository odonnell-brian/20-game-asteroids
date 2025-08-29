class_name ScoreComponent
extends Node2D

@export_category("Dependencies")
@export var health_component: HealthComponent

@export_category("Settings")
@export var amount: int = 10

func _ready() -> void:
	health_component.health_depleted.connect(on_health_depleted)

func on_health_depleted() -> void:
	Globals.player_score += amount
