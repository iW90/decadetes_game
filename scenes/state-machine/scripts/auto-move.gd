extends State

@export var title: String = "auto-move"

@export var idle_state: String = "idle"
@export var move_speed: float = Constants.ENEMY_SPEED

var player = null


func _ready() -> void:
	player = Global.player

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	if not parent or not player: return idle_state
	var direction: Vector2 = parent.global_position.direction_to(player.global_position)

	change_face(direction)
	parent.velocity = direction * move_speed
	parent.move_and_slide()

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
