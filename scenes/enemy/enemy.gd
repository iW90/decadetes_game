extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "auto-move", "attack"]

@export var face: String = "down"
@export var auto_move_target: Vector2

var health = Constants.ENEMY_HEALTH

func _ready() -> void:
	state_machine.init(self, available_states)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

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
	if (body.is_in_group("player")):
		state_machine.change_state_by_name("attack")
