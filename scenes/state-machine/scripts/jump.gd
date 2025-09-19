extends State

@export var fall_state: State

@export var jump_force: float = Constants.JUMP_FORCE
@export var gravity: float = Constants.GRAVITY
@export var air_control_speed: float = Constants.CHARACTER_SPEED * 0.6

var z: float = 0.0
var z_velocity: float = 0.0

func enter() -> void:
	super()
	z = 0.0
	z_velocity = jump_force
	# we keep horizontal velocity controlled by air_control_speed while airborne
	# visual offset initialized
	parent.anim.position.y = 0

func process_input(_event: InputEvent) -> State:
	# no special input handling here; keep jumps clean.
	return null

func process_physics(delta: float) -> State:
	# horizontal control in air (tweak air_control_speed as needed)
	var dir: Vector2 = Constants.get_move_vector()
	parent.velocity = dir * air_control_speed
	parent.move_and_slide()

	# vertical simulation (z is height above ground)
	z += z_velocity * delta
	z_velocity -= gravity * delta

	# visual offset: raise sprite up as z increases
	parent.anim.position.y = -z

	# when upward velocity becomes zero or negative -> start falling
	if z_velocity <= 0.0:
		# ensure FallState knows the current z and velocity so it continues seamlessly
		if fall_state:
			# set initial values on the fall state before switching
			# fall_state is a node instance — we write to its properties directly
			if fall_state.has_method("set_initial_fall"):
				fall_state.set_initial_fall(z, z_velocity)
			else:
				# fallback: set vars (we declare them in FallState below)
				fall_state.initial_z = z
				fall_state.initial_z_velocity = z_velocity
		return fall_state

	return null
