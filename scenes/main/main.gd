# Main.gd
extends Node

@export var enemy_scene: PackedScene
@export var spawn_margin := 200
@onready var hud: CanvasLayer = $Hud

var max_enemies := 5
var max_waves := 2
var current_wave := 1

var time_between_enemies := 1
var time_between_waves := 2

var active_enemies: Array = []
var is_spawning := false
var enemy_dead := 0

var player = null
var tower = null
var game_over := false

func _ready() -> void:
	player = Global.player
	tower = $Map/Tower
	hud.set_wave(current_wave)
	hud.set_score(enemy_dead)
	create_wave()

func create_wave():
	if is_spawning or game_over: return

	var count_enemies = max_enemies * current_wave
	for i in range(count_enemies):
		if game_over: return
		spawn_enemy()
		await get_tree().create_timer(time_between_enemies).timeout

func next_wave():
	if game_over: return
	await get_tree().create_timer(time_between_waves).timeout
	if game_over: return
	current_wave += 1
	hud.set_wave(current_wave)
	is_spawning = false
	create_wave()

func spawn_enemy():
	if game_over: return
	is_spawning = true
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position = calculate_spawn_pos()
	enemy.move_to_position(tower.global_position)

	active_enemies.append(enemy)
	enemy.tree_exited.connect(on_enemy_exite.bind(enemy))

func on_enemy_exite(enemy):
	if game_over: return
	if enemy in active_enemies:
		active_enemies.erase(enemy)
		enemy_dead += 1
		hud.set_score(enemy_dead)

	if active_enemies.is_empty():
		if current_wave >= max_waves:
			end_game_and_show_win()
		else:
			next_wave()

func calculate_spawn_pos() -> Vector2:
	if game_over: return Vector2.ZERO
	var screen_size = get_viewport().get_visible_rect().size
	var player_pos = player.global_position

	var spawn_distance = screen_size.length() / 2 + spawn_margin
	var angle = randf_range(0, TAU)
	return player_pos + Vector2.RIGHT.rotated(angle) * spawn_distance

func end_game():
	game_over = true

func end_game_and_show_win():
	end_game()
	get_tree().change_scene_to_file("res://scenes/Win.tscn")
	
func end_game_and_show_loss():
	end_game()
	get_tree().change_scene_to_file("res://scenes/EndGame.tscn")
