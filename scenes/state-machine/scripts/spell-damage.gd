extends State

@export var title: String = "spell-damage"
@export var hidden_state: String = "hidden"
@export var spell_attack_state: String = "spell-attack"

@export var move_speed: float = Constants.SPELL_SPEED

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	super(_event)

func process_physics(_delta: float):
	pass
	
