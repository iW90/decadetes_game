extends State

@export var title: String = "attack"

func enter() -> void:
	super()

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	if Global.player.health <= 0:
		parent.state_machine.change_state_by_name("idle")
		return null

	if parent.name == "GoblinFemale":
		if parent.anim.frame == 9:
			parent.state_machine.change_state_by_name("idle")
	return null
