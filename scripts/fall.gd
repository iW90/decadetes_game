extends State

@export var idle_state: State
@export var move_state: State

@export var gravity: float = Constants.GRAVITY
var z_velocity: float = 0.0

func enter() -> void:
	super()

func process_physics(delta: float) -> State:
	var dir = Constants.get_move_vector()
	parent.velocity = dir * Constants.CHARACTER_SPEED
	parent.move_and_slide()

	z_velocity += gravity * delta
	parent.position.y += z_velocity * delta

	if parent.is_on_floor():
		if dir == Vector2.ZERO:
			return idle_state
		else:
			return move_state
	return null
