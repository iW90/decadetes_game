extends State

@export var title: String = "idle"
@export var move_state: String = "move"
@export var jump_state: String = "jump"


func enter() -> void:
	super()
	if parent:
		parent.velocity = Vector2.ZERO
		change_animation(parent.last_direction)

func process_input(_event: InputEvent):
	if Input.is_action_just_pressed(Constants.KEY_JUMP):
		return jump_state
	if Constants.move_action_just_pressed():
		return move_state
	return null

func process_physics(_delta: float):
	# top-down: floor is everywhere; nothing to do here
	return null

func change_animation(dir:String) -> void:
	if not dir or not parent.anim: return
	parent.anim.play("idle-"+dir)
	
