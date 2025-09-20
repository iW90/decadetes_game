extends State

@export var title: String = "attack"

@export var idle_state: String = "idle"
@export var distance:float = 0.0

var attack_timer: Timer
var attack_duration: float = 1.0
var player = null


func _ready():
	player = Global.player
	
func enter() -> void:
	print("Entering attack state")

func process_physics(_delta: float):
	_is_touching_player()

func _on_attack_finished(): 
	return idle_state

func _is_touching_player() -> bool:
	if not player:
		return false

	change_animation()
	distance = parent.global_position.distance_to(player.global_position)
	print("distance to player: ", distance)
	return distance < 50.0
