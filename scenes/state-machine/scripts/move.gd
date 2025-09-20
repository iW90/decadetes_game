extends State

@export var title: String = "move"

@export var idle_state: String = "idle"
@export var jump_state: String = "jump"

@export var move_speed: float = Constants.CHARACTER_SPEED

func enter() -> void:
	super()


func process_input(_event: InputEvent):
	if Input.is_action_just_pressed(Constants.KEY_JUMP):
		return jump_state
	return null

func process_physics(_delta: float):
	var dir = Constants.get_move_vector()

	if dir == Vector2.ZERO:
		parent.velocity = Vector2.ZERO

		if not (Input.is_action_pressed("ui_left") or \
				Input.is_action_pressed("ui_right") or \
				Input.is_action_pressed("ui_up") or \
				Input.is_action_pressed("ui_down")):
			return idle_state

		parent.move_and_slide()
		return null

	change_last_dir()
	parent.velocity = dir * move_speed
	parent.move_and_slide()
	return null

func change_last_dir() -> void:
	var dir: String = ""

	if parent.anim:
		if parent.velocity.x > 0:
			dir = "right"
		elif parent.velocity.x < 0:
			dir = "left"
		elif parent.velocity.y > 0:
			dir = "down"
		elif parent.velocity.y < 0:
			dir = "up"

	parent.last_direction = dir
	change_animation()
