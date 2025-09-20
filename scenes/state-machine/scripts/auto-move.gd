extends State

@export var title: String = "auto-move"
@export var idle_state: String = "idle"
@export var move_speed: float = Constants.CHARACTER_SPEED
@export var arrival_threshold: float = 5.0

var target_position: Vector2

func enter() -> void:
	super()
	target_position = parent.auto_move_target

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	if not parent:
		return idle_state

	var distance_to_target = parent.global_position.distance_to(target_position)
	print("Distance to target: ", distance_to_target)

	if distance_to_target <= arrival_threshold:
		parent.velocity = Vector2.ZERO
		parent.stop_auto_move()
		return idle_state

	var direction = (target_position - parent.global_position).normalized()

	parent.velocity = direction * move_speed
	change_animation(direction)
	parent.move_and_slide()

	return null

func change_animation(direction: Vector2) -> void:
	if not parent.anim:
		return

	var dir_string: String = ""

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			dir_string = "right"
		else:
			dir_string = "left"
	else:
		if direction.y > 0:
			dir_string = "down"
		else:
			dir_string = "up"

	parent.anim.play("move-" + dir_string)
	parent.last_direction = dir_string
