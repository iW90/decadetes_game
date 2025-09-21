extends Node

@export var enemy_scene: PackedScene
@export var spawn_margin := 200
@onready var hud: CanvasLayer = $Hud

var max_enemies := 5
var current_wave := 1

var time_between_enemies := 1
var time_between_waves := 2

var active_enemies: Array = []
var enemy_dead := 0

var player: Node2D = null
var tower: Node2D = null

func _ready() -> void:
	player = Global.player
	tower = $Map/Tower
	start_wave()
	hud.set_wave(current_wave)
	hud.set_score(enemy_dead)
	
func start_wave() -> void:
	var enemy_count = max_enemies * current_wave
	spawn_wave(enemy_count)

func spawn_wave(enemy_count: int) -> void:
	for i in range(enemy_count):
		spawn_enemy()
		await get_tree().create_timer(time_between_enemies).timeout

func next_wave() -> void:
	await get_tree().create_timer(time_between_waves).timeout
	current_wave += 1
	hud.set_wave(current_wave)
	start_wave()
	
func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position = calculate_spawn_pos()
	enemy.move_to_position(tower.global_position)
	
	active_enemies.append(enemy)

	enemy.defeated.connect(on_enemy_exit.bind(enemy))
#	enemy.defeated.connect(tower._on_enemy_defeated) <- POE A FUNCAO AQUI

func on_enemy_exit(enemy: Node2D):
	if enemy in active_enemies:
		active_enemies.erase(enemy)
		enemy_dead += 1
		hud.set_score(enemy_dead)
	
	if active_enemies.is_empty():
		call_deferred("next_wave")

func calculate_spawn_pos() -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var player_pos = player.global_position

	var spawn_distance = screen_size.length() / 2 + spawn_margin
	var angle = randf_range(0, TAU)

	return player_pos + Vector2.RIGHT.rotated(angle) * spawn_distance
