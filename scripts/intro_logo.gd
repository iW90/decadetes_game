extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var _wait_time: float = 1
var _scene_timer: SceneTreeTimer = null

func _wait(action: Callable) -> void:
	_scene_timer = get_tree().create_timer(_wait_time)
	await _scene_timer.timeout
	action.call()
	_scene_timer = null

func _ready() -> void:
	_wait(animation_player.play.bind("intro"))
#	can also use:	
#	_wait(func(): animation_player.play("intro"))

func _on_animation_finished(_anim_name: StringName) -> void:
	await _wait(queue_free)
	get_tree().call_deferred("change_scene_to_file", "res://scenes/menu.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_accept"):
		animation_player.speed_scale = 5
		_wait_time = 0.75
		if _scene_timer:
			_scene_timer.timeout.emit()
