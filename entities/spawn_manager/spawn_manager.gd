class_name SpawnManager
extends Node2D

@export_category("Dependencies")
@export var spawn_timer: Timer
@export var possible_spawns: Array[SpawnInfo]
@export var spawn_path: PathFollow2D

@export_category("Settings")
@export var spawn_time_range: Vector2 = Vector2(2.0, 4.0)
@export var num_initial_spawns: int = 5

func _ready() -> void:
	Globals.start_game.connect(on_start_game)

func on_start_game() -> void:
	for i in num_initial_spawns:
		do_spawn()

	spawn_timer.timeout.connect(do_spawn)
	start_spawn_timer()

func do_spawn() -> void:
	var spawn_info: SpawnInfo = pick_random_spawn()
	var spawn: Node2D = spawn_info.scene.instantiate() as Node2D
	spawn.global_position = pick_random_location()
	add_child(spawn)
	start_spawn_timer()

func pick_random_spawn() -> SpawnInfo:
	var total_percent = possible_spawns.reduce(func(accum, info): return accum + info.percent_chance, 0.0)

	for spawn in possible_spawns:
		var rand_val: float = randf_range(0.0, total_percent)
		if rand_val <= spawn.percent_chance * total_percent:
			return spawn

	return possible_spawns[0]

func pick_random_location() -> Vector2:
	spawn_path.progress_ratio = randf()
	return spawn_path.global_position

func start_spawn_timer() -> void:
	spawn_timer.start(randf_range(spawn_time_range.x, spawn_time_range.y))
