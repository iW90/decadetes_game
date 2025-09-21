extends CharacterBody2D

signal map_position(pos: Vector2)

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $State
@onready var available_states: Array = ["idle", "move", "jump", "fall", "attack", "hurt", "dying"]
@onready var health_bar: ProgressBar = $HealthBar
@onready var face: String = "up"
@onready var damage_area: Area2D = $DamageArea
var health := 30
var is_attacking := false


func _ready() -> void:
	state_machine.init(self, available_states)
	Global.player = self
	health_bar.init(health)
	var minimap = get_tree().get_first_node_in_group("minimap")
	if minimap:
		var tracker = minimap.get_child(0)
		if tracker:
			tracker.register_unit(self)

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	map_position.emit(global_position)
	attack()

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func take_damage(amount:int):
	health -= amount
	health_bar.set_health(health)
	state_machine.change_state_by_name("hurt")
	if health <= 0:
		state_machine.change_state_by_name("dying")

func attack():
	if Input.is_action_just_pressed("click_attack"): # ao clicar com o esquerdo do mouse ataca
		$AttackSound.play_random_sword_sound()
#		if not damage_area.get_collision_layer_value(2):
		is_enable_damage_area(true)
		state_machine.change_state_by_name("attack")

func _on_damage_area_area_entered(area: Area2D) -> void:
	if not damage_area.get_collision_layer_value(2): return
	var enemy = area.get_parent()
	if enemy is CharacterBody2D:
		for child in enemy.get_children():
			if child is StateMachine:
				child.change_state("damage")

func is_enable_damage_area(is_enable:bool):
	damage_area.set_collision_mask_value(2, is_enable)
	damage_area.set_collision_layer_value(2, is_enable)
