extends StaticBody2D

@onready var crystal: Area2D = $Crystal
@onready var anim: AnimatedSprite2D = $Bounce
@onready var state_machine: Node = $State
@onready var available_states: Array = ["await", "attack"]

func _ready() -> void:
	state_machine.init(self, available_states)

# trying to avoid _unhandled_input
func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:	
	state_machine.process_frame(delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.z_index -= 5
	print(body.z_index)

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.z_index += 5
