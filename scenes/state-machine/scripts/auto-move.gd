extends State

@export var title: String = "auto-move"

@export var idle_state: String = "idle"
@export var move_speed: float = Constants.ENEMY_SPEED
@export var chase_player_distance: float = 300.0

var player = null
var tower = null

func _ready() -> void:
	player = Global.player
	tower = get_tree().get_root().get_node("Main/Map/Tower")

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	if not parent or not tower: return idle_state
	var target_pos = tower.global_position
	if player and parent.global_position.distance_to(player.global_position) < chase_player_distance:
		target_pos = player.global_position

	var direction: Vector2 = parent.global_position.direction_to(target_pos)
	update_face_direction(direction)
	parent.velocity = direction * move_speed
	parent.move_and_slide()
	return null
