extends Area2D

var anim: AnimatedSprite2D = null
@onready var anims: Array[AnimatedSprite2D] = [$front, $back]
@onready var state_machine: Node = $State
@onready var available_states: Array = ["spell-attack", "spell-damage"]

var speed = 400
var velocity = Vector2.ZERO
var todirection = Vector2.ZERO

func initialize(start_position: Vector2, direction: Vector2):
	global_position = start_position
	self.todirection = direction
	rotation = direction.angle()

func _ready() -> void:
	state_machine.init(self, available_states)
	state_machine.change_state_by_name("spell-attack")

func _input(event: InputEvent) -> void:
	pass

func _process(delta: float) -> void:
	state_machine.process_physics(delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.state_machine.change_state_by_name("damage")
	state_machine.change_state_by_name("spell-damage")

func _on_timer_timeout() -> void:
	queue_free()
