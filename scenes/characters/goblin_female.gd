extends CharacterBody2D

signal map_position(pos: Vector2)

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "move", "jump", "fall", "attack", "hurt", "dying"]
@onready var health_bar: ProgressBar = $HealthBar
@onready var face: String = "up"
var health := 100

func _ready() -> void:
	state_machine.init(self, available_states)
	Global.player = self
	health_bar.init(health)
	var minimap = get_tree().get_first_node_in_group("minimap")
	if minimap:
		var tracker = minimap.get_child(0)
		if tracker:
			tracker.register_unit(self)

# trying to avoid _unhandled_input
func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	if Input.is_action_just_pressed("click_attack"): # ao clicar com o esquerdo do mouse ataca
		state_machine.change_state_by_name("attack")

	map_position.emit(global_position)

	#codigo pra testar a vida (b diminui, enter aumenta)
	if Input.is_action_just_pressed("backwards"):
		take_damage(5)
	elif Input.is_action_just_pressed("ui_accept"):
		take_damage(-5)
	#fim do codigo descartavel

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy is CharacterBody2D:
		for child in enemy.get_children():
			if child is StateMachine:
				child.change_state("damage")

func take_damage(amount:int):
	health -= amount
	health_bar.set_health(health)
	state_machine.change_state_by_name("hurt")
	if health <= 0:
		state_machine.change_state_by_name("dying")
