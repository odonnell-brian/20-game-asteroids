class_name DamageComponent
extends Area2D

@export var damage_amount: int = 1

func _ready() -> void:
	area_entered.connect(try_damage)

func try_damage(node: Node2D) -> void:
	if not node is HealthComponent:
		return

	if node.get_parent() == get_parent():
		print("damaging self %s" % [get_parent().name])

	(node as HealthComponent).try_damage(damage_amount)
