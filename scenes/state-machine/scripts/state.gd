class_name State
extends Node

# parent will be the (CharacterBody2D), injected by StateMachine.init()
var parent: Node = null

# lifecycle hooks
func enter() -> void: pass

func exit() -> void: pass
# these may return either: null, a State node, or a String state-name (case-insensitive)
func process_input(_event: InputEvent): return null
func process_frame(_delta: float): return null
func process_physics(_delta: float): return null

func change_animation() -> void:
	if not parent.anim: return

	var last_dir = parent.last_direction
	var state = name.to_lower()
	
	if state == "auto-move":
		state = "move"

	var animation = state + "-" + last_dir
	parent.anim.play(animation)
