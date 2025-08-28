class_name Asteroid
extends Node2D

@export_category("Dependencies")
@export var health_component: HealthComponent
@export var movement_component: SimpleMovementComponent

@export_category("Settings")
@export var spawn_on_destroy: PackedScene
@export var num_to_spawn: int = 0

func _ready() -> void:
	global_rotation = randf_range(0.0, 2 * PI)
	health_component.health_depleted.connect(on_health_depleted)

func impart_parent_velocity(parent_velocity: Vector2) -> void:
	movement_component.velocity_offset = parent_velocity

func on_health_depleted() -> void:
	if not spawn_on_destroy:
		return

	for i in num_to_spawn:
		var spawn = spawn_on_destroy.instantiate() as Node2D
		spawn.global_position = global_position
		Globals.game_world.call_deferred("add_child", spawn)

		if spawn is Asteroid:
			(spawn as Asteroid).impart_parent_velocity(movement_component.current_velocity)
