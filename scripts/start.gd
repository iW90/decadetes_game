extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/loading/loading.tscn")
	#await get_tree().idle_frame
	#get_tree().call_deferred("change_scene_to_file", "res://scenes/main/main.tscn")

const LOADING_SCENE := "res://scenes/loading/loading.tscn"
func _on_pressed() -> void:
	# Troca para a tela de loading
	#get_tree().change_scene_to_file("res://scenes/loading/loading.tscn")
	get_tree().change_scene_to_file(LOADING_SCENE)
	# Espera o próximo frame renderizar a tela de loading
	#call_deferred("_load_main_scene")

func _load_main_scene() -> void:
	# Agora troca para a cena principal
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
