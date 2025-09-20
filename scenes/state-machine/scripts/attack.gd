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
	return null
