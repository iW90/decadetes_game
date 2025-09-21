extends CharacterBody2D

signal map_position(pos: Vector2)

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "jump", "fall", "auto-move", "attack", "damage"]

@export var face: String = "down"
@export var auto_move_target: Vector2

var health = Constants.ENEMY_HEALTH
var player = null

func _ready() -> void:
	state_machine.init(self, available_states)
	player = Global.player
	var minimap = get_tree().get_first_node_in_group("minimap")
	if minimap:
		var tracker = minimap.get_child(0)
		if tracker:
			tracker.register_unit(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	map_position.emit(global_position)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func move_to_screen_center() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	auto_move_target = screen_size / 2
	state_machine.change_state_by_name("auto-move")

func move_to_position(target: Vector2) -> void:
	auto_move_target = target
	state_machine.change_state_by_name("auto-move")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AttackSound.play_random_sword_sound()
		state_machine.change_state_by_name("attack")

func _on_area_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		state_machine.change_state_by_name("auto-move")

func _on_animated_sprite_2d_animation_looped() -> void:
	if state_machine.get_state_name() == "attack":
		#$AttackSound.play_random_sword_sound()
		player.take_damage(10)
