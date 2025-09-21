extends Button

const LOADING_SCENE := "res://scenes/loading/loading.tscn"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	get_tree().change_scene_to_file(LOADING_SCENE)

func _load_main_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
