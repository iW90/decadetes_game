extends State

@export var idle_state_name: String = "Idle"
@export var move_state_name: String = "Move"
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
	if parent and (parent.has_node("AnimatedSprite2D") or ("anim" in parent)):
		#parent.anim.play("fall")
		parent.anim.position.y = -z

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

	# landing detection: z <= 0 means ground contact
	if z <= 0.0:
		z = 0.0
		z_velocity = 0.0
		if parent:
			parent.anim.position.y = 0
		# choose next ground state based on input
		if dir != Vector2.ZERO:
			return move_state_name
		else:
			return idle_state_name
	return null
