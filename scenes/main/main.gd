extends Node

@onready var goblin_female: CharacterBody2D = $GoblinFemale
@onready var mob_timer: Timer = $MobTimer

@export var enemy_scene: PackedScene
@export var spawn_margin := 200


func _ready() -> void:
	pass

func spawn_enemy():
	# Criar nova instância do human
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.position = calculate_spawn_pos()
	enemy.move_to_position(goblin_female.global_position)


func calculate_spawn_pos() -> Vector2:
	var screen_size = get_viewport().get_visible_rect().size
	var player_pos = goblin_female.global_position

	var spawn_distance = screen_size.length() / 2 + spawn_margin
	var angle = randf_range(0, TAU)

	var spawn_pos = player_pos + Vector2.RIGHT.rotated(angle) * spawn_distance

	return spawn_pos


func _on_spaw_timer_timeout() -> void:
	spawn_enemy()
