class_name GunComponent
extends Node2D

@export_category("Dependencies")
@export var bullet_scene: PackedScene
@export var movement_component: PlayerMovementComponent
@export var shoot_point: Marker2D

@export_category("Settings")
@export var cooldown_time: float = 0.5

@onready var cooldown_timer: Timer = $Timer

func _ready() -> void:
	cooldown_timer.stop()
	cooldown_timer.timeout.connect(on_cooldown_timeout)

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		try_shoot(delta)

func try_shoot(delta: float) -> void:
	if cooldown_timer.time_left > 0:
		return

	var bullet: Bullet = bullet_scene.instantiate() as Bullet
	bullet.global_position = shoot_point.global_position
	bullet.global_rotation = shoot_point.global_rotation
	add_child(bullet)
	bullet.set_parent_velocity(movement_component.get_velocity() * delta)

	cooldown_timer.start(cooldown_time)

func on_cooldown_timeout() -> void:
	print("timeout")
