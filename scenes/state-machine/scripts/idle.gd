extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

@onready var gravity: float = Constants.GRAVITY

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed(Constants.KEY_JUMP) and parent.is_on_floor():
		return jump_state
	if Constants.move_action_just_pressed():
		return move_state
	return null

func process_physics(_delta: float) -> State:
	if parent.has_method("is_on_floor") and not parent.is_on_floor():
		return fall_state
	return null
