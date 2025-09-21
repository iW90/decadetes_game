extends StaticBody2D

@onready var crystal: Area2D = $Crystal
@onready var anim: AnimatedSprite2D = $Bounce
@onready var state_machine: Node = $State
@onready var available_states: Array = ["await", "attack"]

var ThunderboltScene = preload("res://scenes/spells/thunderbolt/thunderbolt.tscn")
var can_attack := true

func _ready() -> void:
	state_machine.init(self, available_states)

func _input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_tower_spell_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		can_attack = false
		$TimeForNextAttack.start()
		var direction = (body.global_position - global_position).normalized()

		var start_position = global_position + Vector2(35, -100)
		var thunderbolt = ThunderboltScene.instantiate()
		thunderbolt.initialize(start_position, direction)
		get_parent().call_deferred("add_child", thunderbolt)


func _on_time_for_next_attack_timeout() -> void:
	can_attack = true
