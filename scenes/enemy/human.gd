extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State

func _ready() -> void:
	state_machine.init(self)

# trying to avoid _unhandled_input
func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	_moviment()

func _moviment() -> void:
	if Input.is_action_pressed("rightMove"):
		anim.play("move-right")
		
	elif Input.is_action_pressed("leftMove"):
		anim.play("move-left")
		
	elif Input.is_action_pressed("downMove"):
		anim.play("move-down")
		
	elif Input.is_action_pressed("upMove"):
		anim.play("move-up")
		
		
		
