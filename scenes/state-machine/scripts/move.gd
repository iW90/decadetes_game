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

func process_physics(_delta: float) -> State:
	var dir = Constants.get_move_vector()
	if dir == Vector2.ZERO:
		# stop and go back to idle (keeps code simple & explicit)
		parent.velocity = Vector2.ZERO
		return idle_state
	
	parent.velocity = dir * speed
	parent.move_and_slide()

	if dir == Vector2.ZERO:
		return idle_state

	if parent.has_method("is_on_floor") and not parent.is_on_floor():
		return fall_state

	return null
