extends State

@export var fall_state: State

@export var jump_force: float = Constants.JUMP_FORCE
@export var gravity: float = Constants.GRAVITY

var z_velocity: float = 0.0

func enter() -> void:
	super()
	z_velocity = -jump_force


func process_physics(delta: float) -> State:
	var dir = Constants.get_move_vector()
	parent.velocity = dir * Constants.CHARACTER_SPEED
	parent.move_and_slide()

	z_velocity += gravity * delta
	parent.position.y += z_velocity * delta

	if z_velocity > 0.0:
		return fall_state
	return null
