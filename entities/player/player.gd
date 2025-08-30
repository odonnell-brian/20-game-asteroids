class_name Player
extends CharacterBody2D

@export_category("Dependencies")
@export var health_component: HealthComponent
@export var movement_component: PlayerMovementComponent

func _ready() -> void:
	health_component.health_changed.connect(Globals.player_lives_changed.emit)
	health_component.health_depleted.connect(on_health_depleted)
	health_component.destroy_fx_complete.connect(Globals.player_destroyed.emit)

	Globals.player_data = PlayerData.new(Vector2.ZERO, Vector2.ZERO, health_component.current_health)

	movement_component.force_move_complete.connect(Globals.player_ready.emit)
	Globals.level_loaded.connect(on_level_loaded)

func _process(_delta: float) -> void:
	Globals.player_data.velocity_percent = movement_component.get_velocity_percent()
	Globals.player_data.velocity = movement_component.get_velocity()

func on_level_loaded() -> void:
	Globals.player_lives_changed.emit(health_component.current_health)
	movement_component.force_move_to(Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2), 2.0)

func on_health_changed(current_health: int) -> void:
	Globals.player_data.current_lives = current_health
	Globals.player_lives_changed.emit(current_health)

func on_health_depleted() -> void:
	movement_component.enabled = false

class PlayerData:
	var current_lives: int
	var velocity: Vector2 = Vector2.ZERO
	var velocity_percent: Vector2 = Vector2.ZERO

	func _init(vel: Vector2, percent: Vector2, lives: int):
		self.velocity = vel
		self.velocity_percent = percent
		self.current_lives = lives
