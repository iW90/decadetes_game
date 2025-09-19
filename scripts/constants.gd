class_name Constants
extends Node

const GRAVITY: float = 400.0
const JUMP_FORCE: float = 250.0
const CHARACTER_SPEED: float = 200.0

const KEY_JUMP: String = "ui_select"
const MOVE_ACTIONS: Array = ["ui_right", "ui_left", "ui_up", "ui_down"]

static func move_action_just_pressed() -> bool:
	for action in MOVE_ACTIONS:
		if Input.is_action_just_pressed(action):
			return true
	return false

static func get_move_vector() -> Vector2:
	var right = Input.get_action_strength(MOVE_ACTIONS[0])
	var left  = Input.get_action_strength(MOVE_ACTIONS[1])
	var up    = Input.get_action_strength(MOVE_ACTIONS[2])
	var down  = Input.get_action_strength(MOVE_ACTIONS[3])
	var v = Vector2(right - left, down - up)
	return v.normalized() if v.length() > 0 else Vector2.ZERO
