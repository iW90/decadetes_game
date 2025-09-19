extends State

@export var idle_state_name: String = "Idle"
@export var jump_state_name: String = "Jump"
@export var fall_state_name: String = "Fall"
@export var move_speed: float = Constants.CHARACTER_SPEED

func enter() -> void:
	if parent:
		if parent.has_node("AnimatedSprite2D") or ("anim" in parent):
			pass#parent.anim.play("walk")

func process_input(_event: InputEvent):
	if Input.is_action_just_pressed(Constants.KEY_JUMP):
		return jump_state_name
	return null

func process_physics(_delta: float):
	var dir = Constants.get_move_vector()
	if dir == Vector2.ZERO:
		parent.velocity = Vector2.ZERO
		return idle_state_name

	parent.velocity = dir * move_speed
	parent.move_and_slide()
	# top-down: no floor checks here
	return null
