class_name HealthComponent
extends Area2D

signal health_changed(current_health: int)
signal health_depleted()

@export var max_health: int = 1
@export var destroy_on_deplete: bool = true
@export var destroy_fx: PackedScene

@export var invuln_timer: Timer

var current_health: int
var is_invulnerable: bool = false

func _ready() -> void:
	current_health = max_health

	if invuln_timer:
		invuln_timer.timeout.connect(on_invulnerability_timeout)

func try_damage(amount: int) -> void:
	if is_invulnerable:
		return

	take_damage(amount)

func take_damage(amount: int) -> void:
	handle_invulnerability()

	current_health = maxi(current_health - amount, 0)
	health_changed.emit(current_health)

	if current_health == 0:
		health_depleted.emit()
		try_destroy()

func handle_invulnerability() -> void:
	if not invuln_timer:
		return

	is_invulnerable = true
	invuln_timer.start()

func try_destroy() -> void:
	if not destroy_on_deplete:
		return

	if destroy_fx:
		var fx: Node2D = destroy_fx.instantiate() as Node2D
		fx.global_position = global_position
		Globals.game_world.add_child(fx)

	get_parent().queue_free()

func on_invulnerability_timeout() -> void:
	is_invulnerable = false
