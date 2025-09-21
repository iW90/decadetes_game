extends Node

@export var enemy_scene: PackedScene
@export var spawn_margin := 200
@onready var hud: CanvasLayer = $Hud

var max_enemies := 5
var current_wave := 1

var time_between_enemies := 1
var time_between_waves := 2

var active_enemies: Array = []
var is_spawning := false
var enemy_dead := 0

var player = null
var tower = null

func _ready() -> void:
	player = Global.player
	tower = $Map/Tower
	create_wave()
	hud.set_wave(current_wave)
	hud.set_score(enemy_dead)
	
func create_wave():
	if is_spawning: return

	var count_enemies = max_enemies * current_wave
	for i in range(count_enemies):
		spawn_enemy()
		await get_tree().create_timer(time_between_enemies).timeout

func next_wave():
	await get_tree().create_timer(time_between_waves).timeout
	current_wave += 1
	hud.set_wave(current_wave)
	is_spawning = false
	create_wave()
	
func spawn_enemy():
	is_spawning = true
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position = calculate_spawn_pos()
	enemy.move_to_position(tower.global_position)
	
	active_enemies.append(enemy)
	enemy.tree_exited.connect(on_enemy_exite.bind(enemy))

func on_enemy_exite(enemy):
	if enemy in active_enemies:
		active_enemies.erase(enemy)
		enemy_dead += 1
		hud.set_score(enemy_dead)
	
	if active_enemies.is_empty():
		next_wave()

func calculate_spawn_pos() -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var player_pos = player.global_position

	var spawn_distance = screen_size.length() / 2 + spawn_margin
	var angle = randf_range(0, TAU)

	var spawn_pos = player_pos + Vector2.RIGHT.rotated(angle) * spawn_distance

	return spawn_pos
