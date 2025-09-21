extends State

@export var title: String = "spell-attack"
@export var hidden_state: String = "hidden"
@export var spell_damage_state: String = "spell-damage"

@export var move_speed: float = Constants.SPELL_SPEED

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	pass

func process_physics(_delta: float):
	
	var dir = Vector2.ZERO
	if "todirection" in parent:
		dir = parent.todirection
	parent.velocity = dir * move_speed
	parent.position += parent.velocity * _delta
	return null
