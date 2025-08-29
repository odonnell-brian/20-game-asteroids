class_name Player
extends CharacterBody2D

@export_category("Dependencies")
@export var health_component: HealthComponent
@export var movement_component: PlayerMovementComponent

func _ready() -> void:
	health_component.health_depleted.connect(Globals.player_destroyed.emit)
	health_component.health_changed.connect(Globals.player_lives_changed.emit)

	Globals.player_movement_data = PlayerData.new(Vector2.ZERO, Vector2.ZERO)

func _process(_delta: float) -> void:
	Globals.player_movement_data.velocity_percent = movement_component.get_velocity_percent()
	Globals.player_movement_data.velocity = movement_component.get_velocity()

class PlayerData:
	var velocity: Vector2 = Vector2.ZERO
	var velocity_percent: Vector2 = Vector2.ZERO

	func _init(vel: Vector2, percent: Vector2):
		self.velocity = vel
		self.velocity_percent = percent
