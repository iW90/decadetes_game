extends Node

@export var enemy_scene: PackedScene
@export var spawn_margin := 200

var max_enemies := 10
var enemy_count := 0

var player = null

func _ready() -> void:
	player = Global.player

func spawn_enemy():
	if enemy_count >= max_enemies:
		return
	enemy_count += 1
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position = calculate_spawn_pos()
	enemy.move_to_position(player.global_position)

func calculate_spawn_pos() -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var player_pos = player.global_position

	var spawn_distance = screen_size.length() / 2 + spawn_margin
	var angle = randf_range(0, TAU)

	var spawn_pos = player_pos + Vector2.RIGHT.rotated(angle) * spawn_distance

	return spawn_pos

func _on_spaw_timer_timeout() -> void:
	spawn_enemy()
