extends Node

@export var starting_state: State

var current_state: State = null
var states: Dictionary = {}

func init(parent: Node) -> void:
	if not starting_state:
		starting_state = get_child(0)
	for child in get_children():
		if child is State:
			child.parent = parent
			states[child.name.to_lower()] = child
	current_state = starting_state


func change_state(new_state: State) -> void:
	print("state-machine change state called with ", new_state)
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	if not current_state: return
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
