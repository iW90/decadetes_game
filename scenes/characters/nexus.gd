extends RigidBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "damage"]

@export var last_direction: String = "down"
@export var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	state_machine.init(self, available_states)

# trying to avoid _unhandled_input
func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
