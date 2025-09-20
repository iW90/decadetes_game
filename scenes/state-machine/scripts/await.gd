extends State

@export var title: String = "await"
@export var attack: String = "attack"

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	if false == true:
		return attack
	return null

func process_physics(_delta: float):
	# top-down: floor is everywhere; nothing to do here
	return null
