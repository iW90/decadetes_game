extends State

@export var title: String = "attack"

@export var idle_state: String = "idle"
@export var move_state: String = "move"
@export var gravity: float = Constants.GRAVITY

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	#change_face(parent.global_position)
	return null

func change_face(direction: Vector2) -> void:
	if not "face" in parent:
		return

	var dir: String = ""

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			dir = "right"
		else:
			dir = "left"
	else:
		if direction.y > 0:
			dir = "down"
		else:
			dir = "up"
	parent.face = dir
	update_animation()
