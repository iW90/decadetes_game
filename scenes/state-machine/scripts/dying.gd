extends State

@export var title: String = "dying"

func enter() -> void:
	super()

func _ready() -> void:
	if parent and "_on_animation_dying_finished" in parent:
		parent.anim.animation_finished.connect(parent._on_animation_dying_finished)

func process_physics(_delta: float):
	if parent.anim.frame == 15:
		print("calling queue_free")
		parent.queue_free()
	return null
