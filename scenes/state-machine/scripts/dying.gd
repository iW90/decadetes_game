extends State

@export var title: String = "dying"

func enter() -> void:
	super()
	
func process_physics(_delta: float):
	if parent.name == "GoblinFemale":
		if parent.anim.frame == 9:
			parent.state_machine.change_state_by_name("idle")
	return null
