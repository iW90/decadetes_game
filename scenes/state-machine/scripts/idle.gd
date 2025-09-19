extends State

@export var move_state_name: String = "Move"
@export var jump_state_name: String = "Jump"
@export var fall_state_name: String = "Fall"

func enter() -> void:
	# grounded visuals and stop horizontal motion
	# rely on Player exposing `anim` and using CharacterBody2D.velocity
	if parent:
#		velocity = parent.velocity # read (CharacterBody2D)
		parent.velocity = Vector2.ZERO
		if parent.has_node("AnimatedSprite2D") or ("anim" in parent):
			parent.anim.position.y = 0 #???????????????????????????????
#			parent.anim.play("idle")

func process_input(_event: InputEvent):
	if Input.is_action_just_pressed(Constants.KEY_JUMP):
		return jump_state_name
	if Constants.move_action_just_pressed():
		return move_state_name
	return null

func process_physics(_delta: float):
	# top-down: floor is everywhere; nothing to do here
	return null
