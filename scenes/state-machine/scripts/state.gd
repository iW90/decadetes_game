class_name State
extends Node

# parent will be the (CharacterBody2D), injected by StateMachine.init()
var parent: Node = null
var game_over :=false

# lifecycle hooks
func enter() -> void:
	update_animations()

func exit() -> void: pass
# these may return either: null, a State node, or a String state-name (case-insensitive)
func process_input(_event: InputEvent): return null
func process_frame(_delta: float): return null
func process_physics(_delta: float): return null

func update_face_direction(direction: Vector2):
	if not "face" in parent:
		return

	var dir: String = ""

	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			dir = "right"
		else:
			dir = "left"
	else:
		if direction.y > 0:
			dir = "down"
		else:
			dir = "up"
	parent.face = dir
	update_animation()

func update_animation() -> void:
	var animation_title: String = ""
	if game_over: return

	if "anim" in parent:
		animation_title += name.to_lower()
		is_finish(animation_title)
		if "face" in parent:
			animation_title = "%s-%s" %[animation_title, parent.face]
		if parent.anim.sprite_frames.has_animation(animation_title):
			parent.anim.play(animation_title)


func update_animations() -> void:
	if "anims" in parent and parent.anims is Array:
		for anim in parent.anims:
			parent.anim = anim
			update_animation()
		return
	update_animation()

func is_finish(anim:String):
	if (not anim.contains("dying")): return

	if parent.name != "GoblinFemale":
		if parent.anim.frame == 9:
			parent.state_machine.disable()
	parent.anim.play(anim)

