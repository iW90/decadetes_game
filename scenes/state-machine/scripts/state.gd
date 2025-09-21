class_name State
extends Node

# parent will be the (CharacterBody2D), injected by StateMachine.init()
var parent: Node = null

# lifecycle hooks
func enter() -> void:
	update_animation()

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

	if "anim" in parent:
		animation_title += name.to_lower()
		if "face" in parent:
			animation_title = "%s-%s" %[animation_title, parent.face]
		if parent.anim.sprite_frames.has_animation(animation_title):
			parent.anim.play(animation_title)
