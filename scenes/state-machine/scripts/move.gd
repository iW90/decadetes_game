extends State

@export var title: String = "move"

@export var idle_state: String = "idle"
@export var jump_state: String = "jump"

@export var move_speed: float = Constants.CHARACTER_SPEED

func enter() -> void:
	if !Input.is_action_pressed("backwards"):
		change_face(Constants.get_move_vector())
	super()

func process_input(_event: InputEvent):
	if Input.is_action_just_pressed(Constants.KEY_JUMP):
		return jump_state
	return null

func process_physics(_delta: float):
	var dir = Constants.get_move_vector()
	change_face(dir)
	if dir == Vector2.ZERO:
		parent.velocity = Vector2.ZERO

		if not Constants.get_move_vector():
			if not (Input.is_action_pressed("ui_left") or \
					Input.is_action_pressed("ui_right") or \
					Input.is_action_pressed("ui_up") or \
					Input.is_action_pressed("ui_down")):
				return idle_state
		parent.move_and_slide()
		return null
	parent.velocity = dir * move_speed
	change_face(parent.velocity)
	parent.move_and_slide()
	return null

func change_face(dir: Vector2) -> void:
	if "face" not in parent: return
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			parent.face = "right"
		else:
			parent.face = "left"
	else:
		if dir.y > 0:
			parent.face = "down"
		else:
			parent.face = "up"
	update_animation()
