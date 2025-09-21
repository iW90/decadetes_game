extends State

@export var title: String = "spell_attack"
@export var hidden_state: String = "hidden"
@export var spell_damage_state: String = "spell_damage"

@export var move_speed: float = Constants.SPELL_SPEED

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	pass

func process_physics(_delta: float):
	var dir = Vector2.ZERO
	if "direction" in parent:
		dir = parent.direction
	parent.velocity = dir * move_speed
	return null
