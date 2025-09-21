extends State

@export var title: String = "damage"
@export var time_staggered: float = 1.0

func enter() -> void:
	super()
	var modulate_color: Color = parent.modulate
	print("eai jovem\n", modulate_color)
	if "staggered_time" in parent:
		time_staggered = parent.staggered_time
	var _damage_timer = get_tree().create_timer(time_staggered)
	if parent is CharacterBody2D:
		parent.modulate = Color(1, 0.3, 0.3)
	await _damage_timer.timeout
	parent.modulate = modulate_color
	parent.queue_free()

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	return null
