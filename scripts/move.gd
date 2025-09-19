extends State

@export var idle_state: State
@export var jump_state: State
@export var fall_state: State

@export var speed: float = Constants.CHARACTER_SPEED

func enter() -> void:
	super()

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed(Constants.KEY_JUMP) and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	var dir = Constants.get_move_vector()
	parent.velocity = dir * speed
	parent.move_and_slide()

	if dir == Vector2.ZERO:
		return idle_state
	if not parent.is_on_floor():
		return fall_state
	return null
