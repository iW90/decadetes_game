extends State

@export var title: String = "damage"
@export var time_staggered: float = 1.0

func enter() -> void:
	var modulate_color: Color = parent.modulate
	if parent is CharacterBody2D:
		parent.modulate = Color(1, 0.3, 0.3)
	parent.modulate = modulate_color
	parent.take_damage()
