class_name Constants
extends Node

const GRAVITY: float = 400.0
const JUMP_FORCE: float = 200.0
const CHARACTER_SPEED: float = 100.0
const KEY_JUMP: String = "ui_select"
const MOVE_ACTIONS: Array = ["ui_right", "ui_left", "ui_up", "ui_down"]

static func move_action_just_pressed() -> bool:
	for action in MOVE_ACTIONS:
		if Input.is_action_just_pressed(action):
			return true
	return false

static func get_move_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength(MOVE_ACTIONS[0]) - Input.get_action_strength(MOVE_ACTIONS[1]),
		Input.get_action_strength(MOVE_ACTIONS[3]) - Input.get_action_strength(MOVE_ACTIONS[2]),
	).normalized()
