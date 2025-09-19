extends State

@export var idle_state: State
@export var move_state: State

@export var gravity: float = Constants.GRAVITY
@export var air_control_speed: float = Constants.CHARACTER_SPEED * 0.6

# set by JumpState (or will default if entering from other causes)
var initial_z: float = 0.0
var initial_z_velocity: float = 0.0

# runtime
var z: float = 0.0
var z_velocity: float = 0.0

func set_initial_fall(start_z: float, start_zv: float) -> void:
	initial_z = start_z
	initial_z_velocity = start_zv
	

func enter() -> void:
	super()
	# initialize local vertical state
	z = initial_z
	z_velocity = initial_z_velocity
	# ensure a starting visual offset (if we came from a JumpState, it will already be correct)
	parent.anim.position.y = -z

func process_input(_event: InputEvent) -> State:
	# optionally allow a double-jump (uncomment if desired)
	# if Input.is_action_just_pressed("ui_select"):
	#     return jump_state
	return null

func process_physics(delta: float) -> State:
	# horizontal air control
	var dir: Vector2 = Constants.get_move_vector()
	parent.velocity = dir * air_control_speed
	parent.move_and_slide()

	# vertical integration
	z += z_velocity * delta
	z_velocity -= gravity * delta

	# visual lift
	parent.anim.position.y = -z

	# landing detection: when z <= 0 we hit the ground
	if z <= 0.0:
		# snap visuals & physics
		z = 0.0
		z_velocity = 0.0
		parent.anim.position.y = 0

		# decide which ground state to pick based on input
		if dir != Vector2.ZERO:
			return move_state
		else:
			return idle_state

	return null
