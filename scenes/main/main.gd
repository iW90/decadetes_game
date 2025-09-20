extends Node

@onready var mob_timer: Timer = $MobTimer

@export var mob_scene: PackedScene
@export var human_scene: PackedScene
var score

func _ready() -> void:
	mob_timer.wait_time = randf_range(0.5, 1)
	mob_timer.start()

func _on_mob_timer_timeout():
	# Chance de spawnar human vs mob normal (50/50)
	var spawn_human = randf() > 0.5

	if spawn_human and human_scene:
		spawn_human_mob()
	elif mob_scene:
		spawn_regular_mob()

func spawn_human_mob():
	# Criar nova instância do human
	var human = human_scene.instantiate()

	# Escolher localização aleatória no Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Definir posição do human
	human.position = mob_spawn_location.position

	# Adicionar o human à cena
	add_child(human)

	# O human automaticamente se moverá para o centro da tela
	print("Human spawnado em: ", human.position)

func spawn_regular_mob():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
