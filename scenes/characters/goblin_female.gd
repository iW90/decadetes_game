extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "move", "jump", "fall"]
@onready var health_bar: ProgressBar = $HealthBar

@onready var face: String = "up"
var health := 100
func _ready() -> void:
	state_machine.init(self, available_states)
	Global.player = self
	health_bar.init(health)

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	#codigo pra testar a vida (b diminui, enter aumenta)
	if Input.is_action_just_pressed("backwards"):
		take_damage(5)
	elif Input.is_action_just_pressed("ui_accept"):
		take_damage(-5)
	#fim do codigo descartavel

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

func take_damage(amount:int):
	health -= amount
	health_bar.set_health(health)
