extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var _wait_time: float = 1.5

func _wait(action: Callable) -> void:
	await get_tree().create_timer(_wait_time).timeout
	action.call()

func _ready() -> void:
	_wait(animation_player.play.bind("intro"))
#	can also use:	
#	_wait(func(): animation_player.play("intro"))

func _on_animation_finished(_anim_name: StringName) -> void:
	_wait(queue_free)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_accept"):
		animation_player.speed_scale = 4.2
		_wait_time = 0.5
