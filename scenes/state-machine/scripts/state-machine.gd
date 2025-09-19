class_name StateMachine
extends Node

@export var starting_state_name: String = "Idle"

var current_state: State = null
var states: Dictionary = {}
var parent_node: Node = null

func init(parent: Node) -> void:
	parent_node = parent
	# make the machine reachable from parent (states will use parent.state_machine.get_state(...))
	parent.state_machine = self

	# collect child State nodes keyed by node name (lowercase)
	for child in get_children():
		if child is State:
			child.parent = parent
			states[child.name.to_lower()] = child

	var start_key = starting_state_name.to_lower()
	if states.has(start_key):
		change_state(states[start_key])
	else:
		push_warning("StateMachine: starting state '%s' not found among children." % starting_state_name)

# Accept either a State node or a String name
func change_state(new_state) -> void:
	if new_state == null:
		push_error("StateMachine.change_state called with null")
		return

	var node_to_switch: State = null

	if typeof(new_state) == TYPE_STRING:
		var key = String(new_state).to_lower()
		if states.has(key):
			node_to_switch = states[key]
		else:
			push_warning("StateMachine.change_state: state '%s' not found." % new_state)
			return
	elif new_state is State:
		node_to_switch = new_state
	else:
		push_error("StateMachine.change_state: unsupported type: %s" % typeof(new_state))
		return

	if current_state:
		current_state.exit()
	current_state = node_to_switch
	current_state.enter()

func change_state_by_name(state_name: String) -> void:
	change_state(state_name)

func get_state(state_name: String) -> State:
	return states.get(state_name.to_lower(), null)

func process_input(event: InputEvent) -> void:
	if current_state == null: return
	var next = current_state.process_input(event)
	_check_for_transition(next)

func process_frame(delta: float) -> void:
	if current_state == null: return
	var next = current_state.process_frame(delta)
	_check_for_transition(next)

func process_physics(delta: float) -> void:
	if current_state == null: return
	var next = current_state.process_physics(delta)
	_check_for_transition(next)

func _check_for_transition(next) -> void:
	if next == null:
		return
	if typeof(next) == TYPE_STRING:
		change_state(next)
	elif next is State:
		change_state(next)
	else:
		push_warning("StateMachine: state returned unsupported type: %s" % typeof(next))
