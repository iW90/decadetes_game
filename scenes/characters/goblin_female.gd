extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "move", "jump", "fall", "auto-move"]
@onready var face: String = "up"

@export var last_direction: String = "down"

func _ready() -> void:
	state_machine.init(self, available_states)
	Global.player = self

# trying to avoid _unhandled_input
func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("viewport: ", viewport, " event: ", event, " index: ", shape_idx)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		print("my own body")
		return
	if body is CharacterBody2D:
		body.queue_free()
	else:
		print("body is ", body)


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("a body entered: ", body_rid, " body: ", body, " body_shape_index: ", body_shape_index, " local shape index: ", local_shape_index)


func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy is CharacterBody2D:
		for child in enemy.get_children():
			if child is StateMachine:
				child.change_state("damage")
