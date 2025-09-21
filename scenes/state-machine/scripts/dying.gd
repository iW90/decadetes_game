extends State

@export var title: String = "dying"

func enter() -> void:
	super()

func process_physics(_delta: float):
	if parent.anim.frame == 15:
		parent.queue_free()
	return null
