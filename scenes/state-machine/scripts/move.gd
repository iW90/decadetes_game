extends State

@export var title: String = "move"

@export var idle_state: String = "idle"
@export var jump_state: String = "jump"

@export var move_speed: float = Constants.CHARACTER_SPEED

func enter() -> void:
	pass#parent.anim.play("walk")

func process_input(_event: InputEvent):
	if Input.is_action_just_pressed(Constants.KEY_JUMP):
		return jump_state
	return null

func process_physics(_delta: float):
	var dir = Constants.get_move_vector()
	if dir == Vector2.ZERO:
		parent.velocity = Vector2.ZERO
		return idle_state

	parent.velocity = dir * move_speed
	if parent.has_method("move_and_slide"):
		parent.move_and_slide()
	# top-down: no floor checks here
	return null
