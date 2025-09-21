extends State

@export var title: String = "attack"

func enter() -> void:
	super()
	
func exit() -> void:
	super()

func process_input(_event: InputEvent):
	return null

func process_physics(_delta: float):
	if Global.player.health <= 0:
		parent.state_machine.change_state_by_name("idle")
		return null
		
	if parent.name == "Enemy":
		parent.coldown()

	if parent.name == "GoblinFemale":
		if parent.anim.frame == 9:
			parent.state_machine.change_state_by_name("idle")			
			parent.is_enable_damage_area(false)
			
	if parent.name == "Tower":
		parent.state_machine.change_state_by_name("damage")
		if parent and "_on_animation_damage_finished" in parent:
			parent.anim.animation_finished.connect(parent._on_animation_damage_finished)

	return null
