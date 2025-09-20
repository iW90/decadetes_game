extends State

@export var title: String = "jump"

@export var fall_state: String = "fall"

@export var jump_force: float = Constants.JUMP_FORCE   # positive upward
@export var gravity: float = Constants.GRAVITY
@export var air_control_speed: float = Constants.CHARACTER_SPEED * 0.6

var z: float = 0.0
var z_velocity: float = 0.0

func enter() -> void:
	z = 0.0
	z_velocity = jump_force
	super()

func process_input(_event: InputEvent):
	return null

func process_physics(delta: float):
	var dir: Vector2 = Constants.get_move_vector()
	parent.velocity = dir * air_control_speed
	parent.move_and_slide()

	# vertical (z) integration
	z += z_velocity * delta
	z_velocity -= gravity * delta

	# visual offset (sprite rises up)
	if parent:
		parent.anim.position.y = -z

	# transition to fall when upward motion ends
	if z_velocity <= 0.0:
		# give Fall state the initial values so it continues seamlessly
		var fall_node = parent.state_machine.get_state(fall_state) if parent.state_machine else null
		if fall_node:
			if fall_node.has_method("set_initial_fall"):
				fall_node.set_initial_fall(z, z_velocity)
			else:
				fall_node.initial_z = z
				fall_node.initial_z_velocity = z_velocity
		return fall_state
	return null
