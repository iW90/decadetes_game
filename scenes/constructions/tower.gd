extends StaticBody2D

@onready var crystal: Area2D = $Crystal
@onready var anim: AnimatedSprite2D = $Bounce
@onready var state_machine: Node = $State
@onready var time_for_next_attack: Timer = $TimeForNextAttack
@onready var game_over_song: AudioStreamPlayer2D = $GameOverSong
@onready var health_bar: ProgressBar = $HealthBar
@onready var available_states: Array = ["await", "dying", "damage"]

var ThunderboltScene = preload("res://scenes/spells/thunderbolt/thunderbolt.tscn")
var targets: Array[Node2D] = []

var health := 500
var alive := true

func _ready() -> void:
	state_machine.init(self, available_states)
	health_bar.init(health)

# trying to avoid _unhandled_input
func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	if time_for_next_attack.is_stopped():
		time_for_next_attack.start()
	if health <= 0:
		game_over_song.play()
		state_machine.change_state_by_name("dying")

func _on_tower_spell_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		targets.append(body)

func _on_tower_spell_range_body_exited(body: Node2D) -> void:
	remove_target(body)
	
func _on_time_for_next_attack_timeout() -> void:
	send_attack()
	health -= 50
	health_bar.set_health(health)
	
func _on_animation_dying_finished() -> void:
	game_over_song.stop()
	time_for_next_attack.stop()
	anim.stop()

func send_attack() -> void:
	var target = targets.front()
	if target:
		var direction = (target.global_position - global_position).normalized()

		var start_position = global_position + Vector2(35, -100)
		var thunderbolt = ThunderboltScene.instantiate()
		thunderbolt.initialize(start_position, direction)
		get_parent().add_child(thunderbolt)

func remove_target(body: Node2D) -> void:
	var pos = targets.find(body, 0)
	targets.pop_at(pos)
