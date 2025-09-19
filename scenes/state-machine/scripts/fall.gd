extends State

@export var title: String = "fall"
@export var idle_state: String = "idle"
@export var move_state: String = "move"
@export var gravity: float = Constants.GRAVITY
@export var air_control_speed: float = Constants.CHARACTER_SPEED * 0.6

# set by Jump before transitioning
var initial_z: float = 0.0
var initial_z_velocity: float = 0.0

# runtime
var z: float = 0.0
var z_velocity: float = 0.0

func set_initial_fall(start_z: float, start_zv: float) -> void:
	initial_z = start_z
	initial_z_velocity = start_zv

func enter() -> void:
	z = initial_z
	z_velocity = initial_z_velocity


func process_input(_event: InputEvent):
	return null

func process_physics(delta: float):
	var dir: Vector2 = Constants.get_move_vector()
	parent.velocity = dir * air_control_speed
	parent.move_and_slide()

	# vertical integration
	z += z_velocity * delta
	z_velocity -= gravity * delta

	if parent:
		parent.anim.position.y = -z

	if z <= 0.0:
		z = 0.0
		z_velocity = 0.0

		if dir != Vector2.ZERO:
			return move_state
		else:
			return idle_state
	return null
