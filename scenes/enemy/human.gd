extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "move", "jump", "fall", "auto-move"]

@export var last_direction: String = "down"
@export var auto_move_target: Vector2

var is_auto_moving: bool = false

func _ready() -> void:
	state_machine.init(self, available_states)

func _input(event: InputEvent) -> void:
	if not is_auto_moving:
		state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func move_to_screen_center() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	auto_move_target = screen_size / 2
	is_auto_moving = true
	state_machine.change_state_by_name("auto-move")

func move_to_position(target: Vector2) -> void:
	auto_move_target = target
	is_auto_moving = true
	state_machine.change_state_by_name("auto-move")

func stop_auto_move() -> void:
	is_auto_moving = false
